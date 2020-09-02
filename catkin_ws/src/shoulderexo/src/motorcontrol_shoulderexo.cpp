
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <pthread.h>
#include "controlcan.h"
#include <string.h>
#include <iostream>
#include<signal.h>

#include <ctime>
#include <cstdlib>
#include "unistd.h"
#include "motorclass.h"
#include "pidclass.h"

#include "ros/ros.h"
#include "shoulderexo/Limbpos.h"
#include "shoulderexo/Encoder.h"
#include "std_msgs/Float32.h"
#include "shoulderexo/Motor_Force.h"
#include "shoulderexo/Sysstatus.h"
#include "shoulderexo/Torque.h"


const float proportionality_coefficient = 0.18;	//适当的缩小协助力矩，基于安全的考虑
const float minimal_force = 5;	//设定最小的拉力值，避免出现松弛的现象
const float minimal_torque = minimal_force * 0.03;	//设定的最小扭矩	
const double reduction_ratio = 128.0; //减速器减速比128:1
const double encoder_line_num = 500; //编码器线数500线
const double cnt_per_circle = reduction_ratio * encoder_line_num * 4; //电机末端转一圈，编码器接收到的脉冲数
float Td_ad = 0, Td_cf = 0; //根据上肢位姿计算出来的理想力矩值
float *M1_target_pointer = new float(0), *M2_target_pointer = new float(0);//分配给两个电机的理想力矩，根据需要改变指向
float M1_target = 0, M2_target = 0;
float Tr_ad, Tr_cf; //拉力传感器测量出来的实际拉力值换算出来的力矩值
float Ti_ad, Ti_cf; //初始换算出来的扭力值
const float Ks = 0.03; //扭簧K值单位（Nm/degree）
const float Kv = 0.005; //对外表现的虚拟刚度
const float Tv = 0.20; //预扭矩
const float Bv = 0.003;//阻尼系数
float theta_l1, theta_l2; //扭簧末端扭转角
float theta_m1 = 0, theta_m2 = 0; //电机实际相对转角
int* monitor_switch1, *updated_flag1, *monitor_switch2, *updated_flag2; //can收发器监视开关，为0时不监测数据，1时监测数据
VCI_CAN_OBJ* temp_buf1, *temp_buf2; //存放
VCI_CAN_OBJ buf;
const int control_period = 1000; //定义控制周期常量,目前定义为1ms
int32_t theta_m_i1,theta_m_i2; //初始的电机位置
float theta_l_i1, theta_l_i2; //初始的弹簧末端位置
int16_t record_flag = 0;
bool is_updated_force = false;
bool is_updated_encoder = false;
bool is_updated_motorforce = false;

int *ret = new int, *ret0 = new int, *ret1 = new int;
pthread_t *threadid = new pthread_t, *threadid0 = new pthread_t, *threadid1 = new pthread_t;


VCI_BOARD_INFO pInfo;//用来获取设备信息。
int count=0;//数据列表中，用来存储列表序号。
VCI_BOARD_INFO pInfo1 [50];
int num=0;
motor motor1(1, &(count), &buf);//初始化电机1
motor motor2(2, &(count), &buf);//初始化电机2

void MySigintHandler(int sig)
{
	extern void usecsleep(unsigned long usec);
	ROS_INFO("SHUTTING DOWN!");
	record_flag = 0;//停止记录

	motor1.Motor_Stop();
	usecsleep(1000);
	motor1.Motor_Disable();
	usecsleep(1000);
	motor2.Motor_Stop();
	usecsleep(1000);
	motor2.Motor_Disable();
	usecsleep(1000000);//延时单位us，这里设置 10 000 000=10s    10s后关闭接收线程，并退出主程序。
	// m_run0=0;cache.run=0;//线程关闭指令。
	pthread_join(*threadid,NULL);//等待线程关闭。
	usecsleep(100000);//延时100ms。
	VCI_ResetCAN(VCI_USBCAN2, 0, 0);//复位CAN1通道。
	usecsleep(100000);//延时100ms。
	VCI_ResetCAN(VCI_USBCAN2, 0, 1);//复位CAN2通道。
	usecsleep(100000);//延时100ms。
	VCI_CloseDevice(VCI_USBCAN2,0);//关闭设备。
	ros::shutdown();
}

struct param
{
	int run;
	motor * motor1;
	motor * motor2;
};

/**
 * @description: 利用select函数改写usleep()函数，使得定时精度更高
 * @param {type} ：unsigned long usec
 * @return: void
 */
void usecsleep(unsigned long usec)
{
    struct timeval tv;
    tv.tv_sec = usec / 1000000;
    tv.tv_usec = usec % 1000000;

    int err;
    do {
        err = select(0, NULL, NULL, NULL, &tv);
    } while(err < 0 && errno == EINTR);
}

int sgn(float input)
{
	if (input < 0)
	{
		return -1;
	}
	else
	{
		return 1;
	}	
}

void chatterCallbackForce(const shoulderexo::Torque::ConstPtr& msg)
{
	Tr_ad = msg->torque1; //实际测量的拉力值换算成扭矩
	Tr_cf = msg->torque2;
	is_updated_force = true;
  	//ROS_INFO("Force: [%d]", msg->data);
}

void chatterCallbackMotorForce(const shoulderexo::Motor_Force::ConstPtr& msg)
{
	// Td_ad = msg->motor1_force * 0.03;
	// Td_cf = msg->motor2_force * 0.03; //末端输出理想转矩
	if (msg->motor1_force * 0.03 * proportionality_coefficient <= 0)
	{
		Td_ad = 0;
	}
	else
	{
		Td_ad = msg->motor1_force * 0.03 * proportionality_coefficient;
	}
	
	if (msg->motor2_force * 0.03 * proportionality_coefficient <= 0)
	{
		Td_cf = 0;
	}
	else
	{
		Td_cf = msg->motor2_force * 0.03 * proportionality_coefficient;
	}	
	ROS_INFO("motor1: [%f]motor2: [%f]", Td_ad, Td_cf);
	is_updated_motorforce = true;
}

void chatterCallbackEncoder(const shoulderexo::Encoder::ConstPtr& msg)
{
	theta_l1 = msg->encoder1 / (2500.0 * 4.0) * 360.0;
	theta_l2 = msg->encoder2 / (2500.0 * 4.0) * 360.0; //换算出弹簧末端的转角(单位为degree)
	is_updated_encoder = true;
	//ROS_INFO("encoder1: [%d]encoder2: [%d]", msg->encoder1, msg->encoder2);
}

void *receive_func(void* param)  //can接收线程。
{
	int reclen=0;
	VCI_CAN_OBJ rec[3000];//接收缓存，设为3000为佳。
	int i,j;
	
	int *run=(int*)param;//线程启动，退出控制。
    int ind=0;
	
	while((*run)&0x0f && ros::ok())
	{
		if((reclen=VCI_Receive(VCI_USBCAN2,0,ind,rec,3000,100))>0)//调用接收函数，如果有数据，进行数据处理显示。
		{
			for(j=0;j<reclen;j++)
			{
				if (*monitor_switch1 == 1 || *monitor_switch2 == 1)
				{
					/* code */
					if (rec[j].ID == 0x280 + 1)
					{
						memcpy(temp_buf1, &(rec[j]), sizeof(VCI_CAN_OBJ));
					}
					else if (rec[j].ID == 0x280 + 2)
					{
						memcpy(temp_buf2, &(rec[j]), sizeof(VCI_CAN_OBJ));
					}						
					// memcpy(temp_buf1, &(rec[j]), sizeof(VCI_CAN_OBJ));
					// memcpy(temp_buf2, &(rec[j]), sizeof(VCI_CAN_OBJ));
					*updated_flag1 = 1;
					*updated_flag2 = 1;
				}				
			}
		}
		ind=!ind;//变换通道号，以便下次读取另一通道，交替读取。		
	}
	printf("run thread exit\n");//退出接收线程	
	pthread_exit(0);
}

void *receive_ROS_func(void* param)//调取外部传感器数据线程
{
	ros::NodeHandle n;
	ros::Subscriber sub0 = n.subscribe("motor_force_topic", 10, chatterCallbackMotorForce);
	ros::Subscriber sub1 = n.subscribe("force_topic", 10, chatterCallbackForce);
	ros::Subscriber sub2 = n.subscribe("encoder_topic", 10, chatterCallbackEncoder);
	ros::MultiThreadedSpinner s(3);  //多线程
    ros::spin(s);  
}

void *pub_status(void* param)
{
	struct param * output;
	output = (struct param *)param;
	ros::NodeHandle n;
	ros::Publisher chatter_pub = n.advertise<shoulderexo::Sysstatus>("system_status", 1000);
	ros::Rate loop_rate(50);
	while (ros::ok() && (output->run)&0x0f)
	{			
		shoulderexo::Sysstatus msg;
		msg.record_flag = record_flag;
		// msg.theta_m1 = (float)(output->motor1->Motor_Main_Pos() - theta_m_i1) / cnt_per_circle * 360.0; //电机实际相对转角(单位为degree)
		msg.theta_m1 = theta_m1;
		msg.theta_l1 = theta_l1 - theta_l_i1;//弹簧末端实际相对转角
		msg.delta_theta_r1 = msg.theta_m1 - msg.theta_l1;//实际相对转角
		msg.Trr_ad = Tr_ad - Ti_ad;
		msg.m1_target = *M1_target_pointer;

		// msg.theta_m2 = (float)(output->motor2->Motor_Main_Pos() - theta_m_i2) / cnt_per_circle * 360.0; //电机实际相对转角(单位为degree)
		// usecsleep(500);
		msg.theta_m2 = theta_m2;
		msg.theta_l2 = theta_l2 - theta_l_i2;//弹簧末端实际相对转角
		msg.delta_theta_r2 = msg.theta_m2 - msg.theta_l2;//实际相对转角
		msg.Trr_cf = Tr_cf - Ti_cf;
		msg.m2_target = *M2_target_pointer;
		chatter_pub.publish(msg);
		ros::spinOnce();
		loop_rate.sleep();
	}
	
}

int initialize_can_adaptor(void)
{
	num=VCI_FindUsbDevice2(pInfo1);

	printf(">>USBCAN DEVICE NUM:");printf("%d", num);printf(" PCS");printf("\n");

		for(int i=0;i<num;i++)
		{
		printf("Device:");printf("%d", i);printf("\n");
                printf(">>Get VCI_ReadBoardInfo success!\n");
		
		printf(">>Serial_Num:%c", pInfo1[i].str_Serial_Num[0]);
		printf("%c", pInfo1[i].str_Serial_Num[1]);
		printf("%c", pInfo1[i].str_Serial_Num[2]);
		printf("%c", pInfo1[i].str_Serial_Num[3]);
		printf("%c", pInfo1[i].str_Serial_Num[4]);
		printf("%c", pInfo1[i].str_Serial_Num[5]);
		printf("%c", pInfo1[i].str_Serial_Num[6]);
		printf("%c", pInfo1[i].str_Serial_Num[7]);
		printf("%c", pInfo1[i].str_Serial_Num[8]);
		printf("%c", pInfo1[i].str_Serial_Num[9]);
		printf("%c", pInfo1[i].str_Serial_Num[10]);
		printf("%c", pInfo1[i].str_Serial_Num[11]);
		printf("%c", pInfo1[i].str_Serial_Num[12]);
		printf("%c", pInfo1[i].str_Serial_Num[13]);
		printf("%c", pInfo1[i].str_Serial_Num[14]);
		printf("%c", pInfo1[i].str_Serial_Num[15]);
		printf("%c", pInfo1[i].str_Serial_Num[16]);
		printf("%c", pInfo1[i].str_Serial_Num[17]);
		printf("%c", pInfo1[i].str_Serial_Num[18]);
		printf("%c", pInfo1[i].str_Serial_Num[19]);printf("\n");

		printf(">>hw_Type:%c", pInfo1[i].str_hw_Type[0]);
		printf("%c", pInfo1[i].str_hw_Type[1]);
		printf("%c", pInfo1[i].str_hw_Type[2]);
		printf("%c", pInfo1[i].str_hw_Type[3]);
		printf("%c", pInfo1[i].str_hw_Type[4]);
		printf("%c", pInfo1[i].str_hw_Type[5]);
		printf("%c", pInfo1[i].str_hw_Type[6]);
		printf("%c", pInfo1[i].str_hw_Type[7]);
		printf("%c", pInfo1[i].str_hw_Type[8]);
		printf("%c", pInfo1[i].str_hw_Type[9]);printf("\n");	

		printf(">>Firmware Version:V");
		printf("%x", (pInfo1[i].fw_Version&0xF00)>>8);
		printf(".");
		printf("%x", (pInfo1[i].fw_Version&0xF0)>>4);
		printf("%x", pInfo1[i].fw_Version&0xF);
		printf("\n");
	}
	printf(">>\n");
	printf(">>\n");
	printf(">>\n");
	if(VCI_OpenDevice(VCI_USBCAN2,0,0)==1)//打开设备
	{
		printf(">>open deivce success!\n");//打开设备成功
	}else
	{
		printf(">>open deivce error!\n");
		exit(1);
	}
	if(VCI_ReadBoardInfo(VCI_USBCAN2,0,&pInfo)==1)//读取设备序列号、版本等信息。
	{
        printf(">>Get VCI_ReadBoardInfo success!\n");		
		printf(">>Serial_Num:%c", pInfo.str_Serial_Num[0]);
		printf("%c", pInfo.str_Serial_Num[1]);
		printf("%c", pInfo.str_Serial_Num[2]);
		printf("%c", pInfo.str_Serial_Num[3]);
		printf("%c", pInfo.str_Serial_Num[4]);
		printf("%c", pInfo.str_Serial_Num[5]);
		printf("%c", pInfo.str_Serial_Num[6]);
		printf("%c", pInfo.str_Serial_Num[7]);
		printf("%c", pInfo.str_Serial_Num[8]);
		printf("%c", pInfo.str_Serial_Num[9]);
		printf("%c", pInfo.str_Serial_Num[10]);
		printf("%c", pInfo.str_Serial_Num[11]);
		printf("%c", pInfo.str_Serial_Num[12]);
		printf("%c", pInfo.str_Serial_Num[13]);
		printf("%c", pInfo.str_Serial_Num[14]);
		printf("%c", pInfo.str_Serial_Num[15]);
		printf("%c", pInfo.str_Serial_Num[16]);
		printf("%c", pInfo.str_Serial_Num[17]);
		printf("%c", pInfo.str_Serial_Num[18]);
		printf("%c", pInfo.str_Serial_Num[19]);printf("\n");

		printf(">>hw_Type:%c", pInfo.str_hw_Type[0]);
		printf("%c", pInfo.str_hw_Type[1]);
		printf("%c", pInfo.str_hw_Type[2]);
		printf("%c", pInfo.str_hw_Type[3]);
		printf("%c", pInfo.str_hw_Type[4]);
		printf("%c", pInfo.str_hw_Type[5]);
		printf("%c", pInfo.str_hw_Type[6]);
		printf("%c", pInfo.str_hw_Type[7]);
		printf("%c", pInfo.str_hw_Type[8]);
		printf("%c", pInfo.str_hw_Type[9]);printf("\n");

		printf(">>Firmware Version:V");
		printf("%x", (pInfo.fw_Version&0xF00)>>8);
		printf(".");
		printf("%x", (pInfo.fw_Version&0xF0)>>4);
		printf("%x", pInfo.fw_Version&0xF);
		printf("\n");	
	}else
	{
		printf(">>Get VCI_ReadBoardInfo error!\n");
		exit(1);
	}

	//初始化参数，严格参数二次开发函数库说明书。
	VCI_INIT_CONFIG config;
	config.AccCode=0;
	config.AccMask=0xFFFFFFFF;
	config.Filter=1;//接收所有帧
	config.Timing0=0x00;/*波特率500 Kbps  0x00  0x1C*/
	config.Timing1=0x1C;
	config.Mode=0;//正常模式		
	
	if(VCI_InitCAN(VCI_USBCAN2,0,0,&config)!=1)
	{
		printf(">>Init CAN1 error\n");
		VCI_CloseDevice(VCI_USBCAN2,0);
	}

	if(VCI_StartCAN(VCI_USBCAN2,0,0)!=1)
	{
		printf(">>Start CAN1 error\n");
		VCI_CloseDevice(VCI_USBCAN2,0);

	}

	if(VCI_InitCAN(VCI_USBCAN2,0,1,&config)!=1)
	{
		printf(">>Init can2 error\n");
		VCI_CloseDevice(VCI_USBCAN2,0);

	}
	if(VCI_StartCAN(VCI_USBCAN2,0,1)!=1)
	{
		printf(">>Start can2 error\n");
		VCI_CloseDevice(VCI_USBCAN2,0);
	}
}

float Speed_Limit(float speed)
{
	if (abs(speed)>180)
	{
		return 180*sgn(speed);
	}
	else
	{
		return speed;
	}
	
	
}


main(int argc, char **argv)
{
	char temp_str[20];
	std::cout<<"Input anything to start the process:";
	std::cin>>temp_str;
	std::cout<<">>programme running\r\n";	
	std::cout<<">>程序开始运行\r\n";//指示程序已运行

	initialize_can_adaptor();//初始化Can Adaptor设备
	
	ros::init(argc, argv, "motorcontrol");//初始化ros节点
	// pthread_t threadid0;
	// int ret0;
	*ret0 = pthread_create(threadid0,NULL,receive_ROS_func, NULL);//启动线程读取节点上传的数据	

	signal(SIGINT, MySigintHandler);
	
	// 对各个节点是否上传信息进行判断和检验，通过后方可进行下一步
	is_updated_encoder = false;
	is_updated_force = false;
	is_updated_motorforce = false;
	int loop_num = 0;
	usecsleep(200000);
	while (1)
	{
		loop_num = loop_num + 1;
		if (loop_num == 5)
		{
			std::cout<<"\r\n";
			std::cout<<">>DATA MISSING, PLEASE CHECK";
			ros::shutdown();
			VCI_CloseDevice(VCI_USBCAN2,0);//关闭设备
			exit(1);
		}
		
		if (is_updated_encoder==true&&is_updated_force==true)
		{
			std::cout<<">>ENCODER MESSAGE RECEIVED\r\n";
			std::cout<<">>FORCE MESSAGE RECEIVED\r\n";
			std::cout<<">>ALL MESSAGE RECEIVED\r\n";
			break;
		}
		else
		{
			if (is_updated_encoder==false)
			{
				std::cout<<">>ENCODER MESSAGE MISSING\r\n";
			}
			if (is_updated_force==false)
			{
				std::cout<<">>FORCE MESSAGE MISSING\r\n";
			}
			usecsleep(2000000);
			continue;
		}		
	}
	
	
	PID_position torque_ad_m(1000, 0, 0);
	PID_position delta_theta_m1(0, 0, 0);
	PID_position torque_cf_m(1000, 0, 0);
	PID_position delta_theta_m2(0, 0, 0);//设置PID控制参数 为避免累计误差均采用位置式PD控制

	// PID_incremental torque_ad_m(0.5, 0.2, 1);
	// PID_incremental delta_theta_m1(0, 0, 0);
	// PID_incremental torque_cf_m(0.5, 0.2, 1);
	// PID_incremental delta_theta_m2(0, 0, 0);//设置PID控制参数 为避免累计误差均采用增量式PD控制

	float delta_theta_d1, delta_theta_d2; //理想的转角差
	float delta_theta_r1, delta_theta_r2; //实际的转角差
	float Trr_ad, Trr_cf; //相对零点的实测力矩值
	float torque_result;
	float delta_result;

	std::cout<<"Initialization completed...\r\n";

	usecsleep(5 * 1000000);//延时1秒
	// motor motor1(1, &(count), &buf);//初始化电机1
	monitor_switch1 = &(motor1.data_coming);//初始化监视器标志
	updated_flag1 = &(motor1.data_updated);//初始化更新数据标志
	temp_buf1 = &(motor1.rec_data);	//连接暂存数组

	// motor motor2(2, &(count), &buf);//初始化电机2
	monitor_switch2 = &(motor2.data_coming);
	updated_flag2 = &(motor2.data_updated);
	temp_buf2 = &(motor2.rec_data);

	int m_run0 = 1;
	// pthread_t threadid;
	// int ret;
	*ret = pthread_create(threadid,NULL,receive_func, &m_run0);//启动接收线程

	motor1.Initialize_Can();//初始化CAN网络
	motor1.Motor_Disable();//失能电机
	motor1.Motor_Mode(2);//选择速度模式
	motor1.Motor_Enable();//使能电机

	motor2.Motor_Disable();//失能电机
	motor2.Motor_Mode(2);//选择位置模式
	motor2.Motor_Enable();//使能电机

	usecsleep(500);//延时500us
	printf("start record\r\n");

	/*记录初始状态值 */
	theta_m_i1 = motor1.Motor_Main_Pos(); //电机的初始位置
	printf("theta_m_i1:%d\r\n",theta_m_i1);
	usecsleep(1000);
	theta_m_i2 = motor2.Motor_Main_Pos();
	printf("theta_m_i2:%d\r\n",theta_m_i2);
	theta_l_i1 = theta_l1; //弹簧末端的初始位置
	theta_l_i2 = theta_l2; //弹簧末端的初始位置
	//printf("theta_l_i1:%f\r\n",theta_l_i1);
	Ti_ad = Tr_ad; //记录初始力矩值
	Ti_cf = Tr_cf; //记录初始力矩值
	usecsleep(1000000); //延时1秒
	/*         */

	struct param cache;
	cache.run = 1;
	cache.motor1 = &motor1;
	cache.motor2 = &motor2;
	// pthread_t threadid1;
	// int ret1;
	*ret1 = pthread_create(threadid1,NULL,pub_status, &cache);//启动发布线程

	// //////预张紧/////////////////////
	// int32_t theta_temp;
	// printf("开始M2预张紧\r\n");
	// usecsleep(500);
	// motor2.Motor_Speed_for_PTP(25600);//设置预张紧速度为0.1r/s
	// usecsleep(10000);
	// theta_temp = motor2.Motor_Main_Pos();
	// usecsleep(10000);
	// motor2.Move_To(theta_temp + 2 * cnt_per_circle);
	// usecsleep(500);
	// int64_t s_time_temp_2 = getCurrentTime();
	// while (Tr_cf - Ti_cf < minimal_torque)
	// {
	// 	int64_t f_time_temp = getCurrentTime();
	// 	if (f_time_temp - s_time_temp_2 > 10000000)//时间大于10秒，控制回路终止
	// 	{
	// 		break;
	// 	}
	// }
	// motor2.Motor_Stop();
	// usecsleep(1000000);

	// printf("开始M1预张紧\r\n");
	// usecsleep(500);
	// motor1.Motor_Speed_for_PTP(25600);//设置预张紧速度为0.1r/s
	// usecsleep(10000);
	// theta_temp = motor1.Motor_Main_Pos();
	// usecsleep(10000);
	// motor1.Move_To(theta_temp + 2 * cnt_per_circle);
	// usecsleep(500);
	// int64_t s_time_temp = getCurrentTime();
	// while (Tr_ad - Ti_ad < minimal_torque)
	// {
	// 	int64_t f_time_temp = getCurrentTime();
	// 	if (f_time_temp - s_time_temp > 10000000)//时间大于10秒，控制回路终止
	// 	{
	// 		break;
	// 	}
	// }
	// motor1.Motor_Stop();
	// usecsleep(1000000);
	
	// printf("预张紧结束\r\n");
	///////////////////////////////////////////

	/*记录预张紧后的初始状态值 */
	printf("记录预张紧后的初始状态值\r\n");
	theta_m_i1 = motor1.Motor_Main_Pos(); //电机的初始位置
	printf("theta_m_i1:%d\r\n",theta_m_i1);
	usecsleep(100000);//0.1s
	std::cout<<"111111111111111111111111\r\n";
	theta_m_i2 = motor2.Motor_Main_Pos();
	// usecsleep(100000);
	printf("theta_m_i2:%d\r\n",theta_m_i2);
	theta_l_i1 = theta_l1; //弹簧末端的初始位置
	theta_l_i2 = theta_l2; //弹簧末端的初始位置
	//printf("theta_l_i1:%f\r\n",theta_l_i1);
	Ti_ad = Tr_ad; //记录初始力矩值
	Ti_cf = Tr_cf; //记录初始力矩值
	printf("电机1的初始角度theta_m_i1:%d\r\n",theta_m_i1);
	printf("电机2的初始角度theta_m_i2:%d\r\n",theta_m_i2);
	printf("弹簧1末端初始角度theta_l_i1:%f\r\n",theta_l_i1);
	printf("弹簧1末端初始角度theta_l_i2:%f\r\n",theta_l_i2);
	printf("电机1的初始力矩:Ti_ad:%f\r\n",Ti_ad);
	printf("电机1的初始力矩:Ti_cf:%f\r\n",Ti_cf);
	// usecsleep(10000); //延时0.01秒
	/*         */

	//将电机视为理想位置源，通过控制扭簧两端的形变，控制输出的力 
	//下面测试力控效果，输入固定的控制目标
	float T_tar = 0.8; //控制末端输出力为10N，则弹簧末端输出扭矩为0.3Nm
	delta_theta_d1 = 0;delta_theta_d2=0;
	const float MAXIMUN_DELTA_THETA = 3; //最大pid调节量

	int64_t s_time = getCurrentTime();
	float theta_m1_prev = 0;
	float theta_m2_prev = 0;//前一节拍的电机位置
	float speed_cf = 0;
	float speed_ad = 0;
	theta_m_i2 = motor2.Motor_Main_Pos();
	record_flag = 1;//开始记录

	
	// *M1_target_pointer = M1_target;
	// *M2_target_pointer = M2_target;
	std::cout<<"START CONTROL LOOP\r\n";
	M1_target_pointer = &M1_target;
	M2_target_pointer = &M2_target;
	
	while (ros::ok())
	{
		// record_flag = 1;//开始记录

		// M2力控制回路 		
		Trr_cf = Tr_cf - Ti_cf;	//实测相对力矩值
		torque_result = torque_cf_m.pid_control(*M2_target_pointer, Trr_cf);
		theta_m2 = (float)(motor2.Motor_Main_Pos() - theta_m_i2) / cnt_per_circle * 360.0; //电机实际相对转角
		speed_cf = (Tv - Kv*theta_m2 + (Kv-Ks)*(*M2_target_pointer)/Ks) / Bv + torque_result;//理想速度（degree/s）
		// speed_cf = (Tv - Kv*theta_m2 + (Kv-Ks)*0/Ks) / Bv;
		// printf("speed_cf:%f\r\n",speed_cf);
		// printf("theta_m2:%f\r\n",theta_m2);
		// printf("torque_result:%f\r\n",torque_result);
		speed_cf = Speed_Limit(speed_cf);
		motor2.Motor_Speed((int32_t)(speed_cf/360.0*cnt_per_circle));
		// motor2.Motor_Speed((int32_t)(256000));
		motor2.Motor_Begin();
		usecsleep(100);

		// M1力控制回路 		
		Trr_ad = Tr_ad - Ti_ad;	//实测相对力矩值
		torque_result = torque_ad_m.pid_control(*M1_target_pointer, Trr_ad);
		theta_m1 = (float)(motor1.Motor_Main_Pos() - theta_m_i1) / cnt_per_circle * 360.0; //电机实际相对转角
		speed_ad = (Tv - Kv*theta_m1 + (Kv-Ks)*(*M1_target_pointer)/Ks) / Bv + torque_result;//理想速度（degree/s）
		// speed_cf = (Tv - Kv*theta_m2 + (Kv-Ks)*0/Ks) / Bv;
		// printf("speed_cf:%f\r\n",speed_cf);
		// printf("theta_m2:%f\r\n",theta_m2);
		// printf("torque_result:%f\r\n",torque_result);
		speed_ad = Speed_Limit(speed_ad);
		motor1.Motor_Speed((int32_t)(speed_ad/360.0*cnt_per_circle));
		// motor2.Motor_Speed((int32_t)(256000));
		motor1.Motor_Begin();
		usecsleep(100);
		
		// //倒计时
		// int64_t f_time = getCurrentTime();
		// if (f_time - s_time > 1200 * 1000000)
		// {
		// 	break;
		// }
		

		usecsleep(control_period*3);//延时5ms
	}

	record_flag = 0;//停止记录

	motor1.Motor_Stop();
	usecsleep(1000);
	motor1.Motor_Disable();
	usecsleep(1000);
	motor2.Motor_Stop();
	usecsleep(1000);
	motor2.Motor_Disable();
	usecsleep(1000000);//延时单位us，这里设置 10 000 000=10s    10s后关闭接收线程，并退出主程序。
	m_run0=0;cache.run=0;//线程关闭指令。
	pthread_join(*threadid,NULL);//等待线程关闭。
	usecsleep(100000);//延时100ms。
	VCI_ResetCAN(VCI_USBCAN2, 0, 0);//复位CAN1通道。
	usecsleep(100000);//延时100ms。
	VCI_ResetCAN(VCI_USBCAN2, 0, 1);//复位CAN2通道。
	usecsleep(100000);//延时100ms。
	VCI_CloseDevice(VCI_USBCAN2,0);//关闭设备。
	// 除收发函数外，其它的函数调用前后，最好加个毫秒级的延时，即不影响程序的运行，又可以让USBCAN设备有充分的时间处理指令。
	// goto ext;
	std::cout<<">>programme end. press ctrl and c to exit the process...";
	while (ros::ok())
	{
		;
	}
	
}
