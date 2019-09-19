#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <pthread.h>
#include "controlcan.h"
#include <string.h>

#include <ctime>
#include <cstdlib>
#include "unistd.h"
#include "motorclass.h"
#include "pidclass.h"

#include "ros/ros.h"
#include "exosystem/Limbpos.h"
#include "exosystem/Encoder.h"
#include "std_msgs/Float32.h"
#include "exosystem/Motor_Force.h"
#include "exosystem/Sysstatus.h"
#include "exosystem/Torque.h"

float Td_ad, Td_cf; //根据上肢位姿计算出来的理想力矩值
float Tr_ad, Tr_cf; //拉力传感器测量出来的实际拉力值换算出来的力矩值
float Ti_ad, Ti_cf; //初始换算出来的扭力值
float Ks = 0.0856; //扭簧K值单位（Nm/degree）
float theta_l1, theta_l2; //扭簧末端扭转角
int* monitor_switch1, *updated_flag1, *monitor_switch2, *updated_flag2; //can收发器监视开关，为0时不监测数据，1时监测数据
VCI_CAN_OBJ* temp_buf1, *temp_buf2; //存放
VCI_CAN_OBJ buf;
const int control_period = 1000; //定义控制周期常量,目前定义为1ms
int32_t theta_m_i1; //初始的电机位置
float theta_l_i1; //初始的弹簧末端位置
int16_t record_flag = 0;


VCI_BOARD_INFO pInfo;//用来获取设备信息。
int count=0;//数据列表中，用来存储列表序号。
VCI_BOARD_INFO pInfo1 [50];
int num=0;

struct param
{
	int run;
	motor * motor1;
};


void chatterCallbackForce(const exosystem::Torque::ConstPtr& msg)
{
	Tr_ad = msg->torque1; //实际测量的拉力值换算成扭矩
	Tr_cf = msg->torque2;
  	//ROS_INFO("Force: [%d]", msg->data);
}

void chatterCallbackLimbpos(const exosystem::Limbpos::ConstPtr& msg)
{
	ROS_INFO("xtheta: [%f]ytheta: [%f]ztheta: [%f]", msg->xtheta, msg->ytheta, msg->ztheta);
}

void chatterCallbackMotorForce(const exosystem::Motor_Force::ConstPtr& msg)
{
	Td_ad = msg->motor1_force * 0.03;
	Td_cf = msg->motor2_force * 0.03; //末端输出理想转矩
	//ROS_INFO("motor1: [%f]motor2: [%f]", msg->motor1_force, msg->motor2_force);
}

void chatterCallbackEncoder(const exosystem::Encoder::ConstPtr& msg)
{
	theta_l1 = msg->encoder1 / (2500.0 * 4.0) * 360.0;
	theta_l2 = msg->encoder2 / (2500.0 * 4.0) * 360.0; //换算出弹簧末端的转角(单位为degree)
	//ROS_INFO("encoder1: [%d]encoder2: [%d]", msg->encoder1, msg->encoder2);
}

void *receive_func(void* param)  //接收线程。
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
				// printf("Index:%04d  ",count);count++;//序号递增
				// printf("CAN%d RX ID:0x%08X", ind+1, rec[j].ID);//ID
				// if(rec[j].ExternFlag==0) printf(" Standard ");//帧格式：标准帧
				// if(rec[j].ExternFlag==1) printf(" Extend   ");//帧格式：扩展帧
				// if(rec[j].RemoteFlag==0) printf(" Data   ");//帧类型：数据帧
				// if(rec[j].RemoteFlag==1) printf(" Remote ");//帧类型：远程帧
				// printf("DLC:0x%02X",rec[j].DataLen);//帧长度
				// printf(" data:0x");	//数据 */
				// for(i = 0; i < rec[j].DataLen; i++)
				// {
				// 	printf(" %02X", rec[j].Data[i]);
				// }
				// printf(" TimeStamp:0x%08X",rec[j].TimeStamp);//时间标识。
				// printf("\n");
				//printf("%d\r\n",*monitor_switch);
				if (*monitor_switch1 == 1 || *monitor_switch2 == 1)
				{
					/* code */
					memcpy(temp_buf1, &(rec[j]), sizeof(VCI_CAN_OBJ));
					memcpy(temp_buf2, &(rec[j]), sizeof(VCI_CAN_OBJ));
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

void *receive_ROS_func(void* param)
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
	ros::Publisher chatter_pub = n.advertise<exosystem::Sysstatus>("system_status", 1000);
	ros::Rate loop_rate(50);
	while (ros::ok() && (output->run)&0x0f)
	{			
		exosystem::Sysstatus msg;
		msg.record_flag = record_flag;
		msg.theta_m1 = (float)(output->motor1->Motor_Main_Pos() - theta_m_i1) / (128.0*500.0*4.0) * 360.0; //电机实际相对转角(单位为degree)
		msg.theta_l1 = theta_l1 - theta_l_i1;
		msg.delta_theta_r1 = msg.theta_m1 - msg.theta_l1;
		msg.Trr_ad = Tr_ad - Ti_ad;
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


main(int argc, char **argv)
{
	printf(">>programme running\r\n");//指示程序已运行

	initialize_can_adaptor();//初始化Can Adaptor设备
	
	ros::init(argc, argv, "motorcontrol");
	pthread_t threadid0;
	int ret0;
	ret0 = pthread_create(&threadid0,NULL,receive_ROS_func, NULL);//启动线程读取节点上传的数据
	
	int m_run0 = 1;
	pthread_t threadid;
	int ret;
	ret = pthread_create(&threadid,NULL,receive_func, &m_run0);//启动接收线程
	
	PID_position torque_ad_m(0.4, 0, 0);
	PID_position delta_theta_m1(0, 0, 0);

	float delta_theta_d1; //理想的转角差
	float delta_theta_r1; //实际的转角差
	float Trr_ad; //相对零点的实测力矩值
	float theta_m1; //电机实际相对转角
	float torque_result;
	float delta_result;


	usleep(1000000);//延时1秒
	motor motor1(1, &(count), &buf);//
	monitor_switch1 = &(motor1.data_coming);
	updated_flag1 = &(motor1.data_updated);
	temp_buf1 = &(motor1.rec_data);
	motor1.Initialize_Can();//初始化CAN网络
	motor1.Motor_Disable();//失能电机
	motor1.Motor_Mode(5);//选择位置模式
	motor1.Motor_Enable();//使能电机
	motor1.Motor_Speed_for_PTP(496665);//设置位置模式下电机运转速度

	motor motor2(2, &(count), &buf);//
	monitor_switch2 = &(motor2.data_coming);
	updated_flag2 = &(motor2.data_updated);
	temp_buf2 = &(motor2.rec_data);
	motor2.Motor_Disable();//失能电机
	// motor2.Motor_Mode(5);//选择位置模式
	// motor2.Motor_Enable();//使能电机
	// motor2.Motor_Speed_for_PTP(496665);//设置位置模式下电机运转速度

	/*记录初始状态值 */
	theta_m_i1 = motor1.Motor_Main_Pos(); //电机的初始位置
	theta_l_i1 = theta_l1; //弹簧末端的初始位置
	//printf("theta_l_i1:%f\r\n",theta_l_i1);
	Ti_ad = Tr_ad; //记录初始力矩值
	usleep(1000000); //延时1秒
	struct param cache;
	cache.run = 1;
	cache.motor1 = &motor1;
	pthread_t threadid1;
	int ret1;
	ret1 = pthread_create(&threadid1,NULL,pub_status, &cache);//启动接收线程


	// //下面为用于调试作用
	// while (ros::ok())
	// {
	// 	float degree;
	// 	printf("Input the degree you want to move:");
	// 	scanf("%f",&degree);
	// 	usleep(100000); //延时0.1秒
	// 	motor1.Move_To((int32_t)((degree + theta_m1) / 360 * (128.0*500.0*4.0)+ theta_m_i1));
	// 	usleep(1000000); //延时一秒
	// 	theta_m1 = (float)(motor1.Motor_Main_Pos() - theta_m_i1) / (128.0*500.0*4.0) * 360.0; //电机实际相对转角(单位为degree)
	// 	delta_theta_r1 = theta_m1 - (theta_l1 - theta_l_i1); //实际的转角差		
	// 	Trr_ad = Tr_ad - Ti_ad;
	// 	printf("电机转角：%-8.3f末端转角：%-8.3f差值：%-8.3f输出扭矩：%-8.3f\r\n",theta_m1, (theta_l1 - theta_l_i1), delta_theta_r1, Trr_ad);
	// 	usleep(100000); //延时一秒
	// }	

	// //将电机视为理想位置源，通过控制扭簧两端的形变，控制输出的力 
	// //下面为控制回路
	// while (ros::ok())
	// {
	// 	// 力控制回路 
	// 	Trr_ad = Tr_ad - Ti_ad;	//实测相对力矩值
	// 	torque_result = torque_ad_m.pid_control(Td_ad, Trr_ad);
	// 	delta_theta_d1 = torque_result / Ks; //理想的转角差
	// 	theta_m1 = (float)(motor1.Motor_Main_Pos() - theta_m_i1) / (128.0*500.0*4.0) * 360.0; //电机实际相对转角
	// 	delta_theta_r1 = theta_m1 - (theta_l1 - theta_l_i1); //实际的转角差
	// 	delta_result = delta_theta_m1.pid_control(delta_theta_d1, delta_theta_r1); //转角PID控制器输出的结果
	// 	motor1.Move_To((int32_t)(((theta_l1 - theta_l_i1) + delta_result) / 360 * (128.0*500.0*4.0) + theta_m_i1));			
	// 	usleep(control_period);//延时
	// }

	//将电机视为理想位置源，通过控制扭簧两端的形变，控制输出的力 
	//下面测试力控效果，输入固定的控制目标
	float T_tar = 0.3; //控制末端输出力为10N，则弹簧末端输出扭矩为0.3Nm
	delta_theta_d1 = 0;
	int32_t pos_Limit = theta_m_i1 + (128.0*500.0*4.0) * 2; //设置位置上下限

	record_flag = 1;//开始记录
	
	while (ros::ok())
	{
		// 力控制回路 		
		Trr_ad = Tr_ad - Ti_ad;	//实测相对力矩值
		torque_result = torque_ad_m.pid_control(T_tar, Trr_ad);
		//delta_theta_d1 = (torque_result + T_tar) / Ks; //理想的转角差
		delta_theta_d1 = (torque_result) / Ks + delta_theta_d1; //理想的转角差
		theta_m1 = (float)(motor1.Motor_Main_Pos() - theta_m_i1) / (128.0*500.0*4.0) * 360.0; //电机实际相对转角
		delta_theta_r1 = theta_m1 - (theta_l1 - theta_l_i1); //实际的转角差
		delta_result = delta_theta_m1.pid_control(delta_theta_d1, delta_theta_r1); //转角PID控制器输出的结果
		int32_t pos = (int32_t)(((theta_l1 - theta_l_i1) + delta_result + delta_theta_d1) / 360 * (128.0*500.0*4.0) + theta_m_i1);
		//检测位置是否超限
		if (pos > pos_Limit || pos < -pos_Limit)
		{
			printf("POSITION out of the range！\r\n");
			motor1.Motor_Stop();
			motor1.Motor_Disable();
			break;
		}
		motor1.Move_To(pos);
		printf("实测拉力值:%f\t理论角度偏差:%f\t实际角度偏差:%f\r\n",Trr_ad, delta_theta_d1, delta_theta_r1);
		usleep(control_period*2);//延时
	}

	record_flag = 0;//停止记录

	motor1.Motor_Stop();
	motor1.Motor_Disable();
	usleep(1000000);//延时单位us，这里设置 10 000 000=10s    10s后关闭接收线程，并退出主程序。
	m_run0=0;cache.run=0;//线程关闭指令。
	pthread_join(threadid,NULL);//等待线程关闭。
	usleep(100000);//延时100ms。
	VCI_ResetCAN(VCI_USBCAN2, 0, 0);//复位CAN1通道。
	usleep(100000);//延时100ms。
	VCI_ResetCAN(VCI_USBCAN2, 0, 1);//复位CAN2通道。
	usleep(100000);//延时100ms。
	VCI_CloseDevice(VCI_USBCAN2,0);//关闭设备。
	//除收发函数外，其它的函数调用前后，最好加个毫秒级的延时，即不影响程序的运行，又可以让USBCAN设备有充分的时间处理指令。
	//goto ext;
}
