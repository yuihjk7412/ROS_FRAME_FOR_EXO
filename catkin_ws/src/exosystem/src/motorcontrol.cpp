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

#include "ros/ros.h"
#include "exosystem/Limbpos.h"
#include "exosystem/Encoder.h"
#include "std_msgs/Float32.h"
#include "exosystem/Motor_Force.h"

float Td_ad, Td_cf; //根据上肢位姿计算出来的理想力矩值
float Tr_ad, Tr_cf; //拉力传感器测量出来的实际拉力值换算出来的力矩值
float Ti_ad, Ti_cf; //初始换算出来的扭力值
float Ks = 0.0856; //扭簧K值单位（Nm/degree）
float theta_l1, theta_l2; //扭簧末端扭转角
int* monitor_switch, *updated_flag; //can收发器监视开关，为0时不监测数据，1时监测数据
VCI_CAN_OBJ* temp_buf; //存放

/*PID控制程序结构体 */
typedef struct
{
  float setpoint;       //设定值
  float proportiongain = 0;     //比例系数
  float integralgain = 0;      //积分系数
  float derivativegain = 0;    //微分系数
  float lasterror;     //前一拍偏差
  float result; //输出值
  float integral;//积分值
}PID;

VCI_BOARD_INFO pInfo;//用来获取设备信息。
int count=0;//数据列表中，用来存储列表序号。
VCI_BOARD_INFO pInfo1 [50];
int num=0;

void chatterCallbackForce(const std_msgs::Float32::ConstPtr& msg)
{
	Tr_ad = msg->data; //实际测量的拉力值换算成扭矩
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

class motor
{
private:
	/* data */
	u_int32_t ID; 
	int32_t speed_limit_L, speed_limit_H; //速度上下限
public:
	motor(u_int32_t id);
	~motor();
	int data_coming = 0; //显示是否等待有数据到来，0为没有，1为有
	int data_updated = 0; //显示数据是否已经更新
	VCI_CAN_OBJ rec_data; //暂存接收到的数据
	int Send_Command(VCI_CAN_OBJ * command);
	int Initialize_Can();
	int Motor_Disable();
	int Motor_Mode(u_int8_t mode);
	int Motor_Enable();
	int Motor_Speed(int32_t speed);
	int Motor_Begin();
	int Motor_Stop();
	int Motor_Main_Pos();
	int Move_To(int32_t pos);
	int Motor_Set_Pos(int32_t pos);
	int Motor_Acc(int32_t acc);
	int Motor_Dec(int32_t dec);
	int Motor_Stop_Dec(int32_t sdec);
	int Motor_Speed_for_PTP(int32_t speed);	
};

motor::motor(u_int32_t id)
{
	ID = id;
	speed_limit_H = 496666;
	speed_limit_L = -496666;
}

int motor::Initialize_Can()
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 2;
	BYTE Data[command.DataLen] = {0x01, 0x00};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Disable()
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE Data[command.DataLen] = {0x4D, 0x4F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Mode(u_int8_t mode)
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE Data[command.DataLen] = {0x55, 0x4D, 0x00, 0x00, mode, 0x00, 0x00, 0x00};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Enable()
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE Data[command.DataLen] = {0x4D, 0x4F, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Speed(int32_t speed)
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE speed_array[4];
	memcpy(speed_array, &speed, 4 * sizeof(BYTE));
	BYTE Data[command.DataLen] = {0x4A, 0x56, 0x00, 0x00, speed_array[0], speed_array[1], speed_array[2], speed_array[3]};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Begin()
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 4;
	BYTE Data[command.DataLen] = {0x42, 0x47, 0x00, 0x00};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Stop()
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 4;
	BYTE Data[command.DataLen] = {0x53, 0x54, 0x00, 0x00};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Move_To(int32_t pos)
{
	int flag;
	Motor_Stop();
	flag = Motor_Set_Pos(pos);
	Motor_Begin();	
	return(flag);
}

int motor::Motor_Set_Pos(int32_t pos)
{
	if (pos<-1000000000 && pos>1000000000)
	{
		return 0;
	}	
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE pos_array[4];
	memcpy(pos_array, &pos, 4 * sizeof(BYTE));
	BYTE Data[command.DataLen] = {0x50, 0x41, 0x00, 0x00, pos_array[0], pos_array[1], pos_array[2], pos_array[3]};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Acc(int32_t acc)
{
	if (acc<100 && acc > 1000000000)
	{
		return(0);
	}	
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE acc_array[4];
	memcpy(acc_array, &acc, 4 * sizeof(BYTE));
	BYTE Data[command.DataLen] = {0x41, 0x43, 0x00, 0x00, acc_array[0], acc_array[1], acc_array[2], acc_array[3]};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Dec(int32_t dec)
{
	if (dec<100 && dec > 1000000000)
	{
		return(0);
	}	
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE dec_array[4];
	memcpy(dec_array, &dec, 4 * sizeof(BYTE));
	BYTE Data[command.DataLen] = {0x44, 0x43, 0x00, 0x00, dec_array[0], dec_array[1], dec_array[2], dec_array[3]};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));	
}

int motor::Motor_Stop_Dec(int32_t sdec)
{
	if (sdec<200 && sdec > 1000000000)
	{
		return(0);
	}	
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE sdec_array[4];
	memcpy(sdec_array, &sdec, 4 * sizeof(BYTE));
	BYTE Data[command.DataLen] = {0x53, 0x44, 0x00, 0x00, sdec_array[0], sdec_array[1], sdec_array[2], sdec_array[3]};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));
}

int motor::Motor_Speed_for_PTP(int32_t speed)
{
	if (speed<speed_limit_L && speed > speed_limit_L)
	{
		return(0);
	}	
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 8;
	BYTE speed_array[4];
	memcpy(speed_array, &speed, 4 * sizeof(BYTE));
	BYTE Data[command.DataLen] = {0x53, 0x50, 0x00, 0x00, speed_array[0], speed_array[1], speed_array[2], speed_array[3]};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	return(Send_Command(&command));	
}

int motor::Motor_Main_Pos()
{
	VCI_CAN_OBJ command;
	command.ID = (u_int32_t)0x300 + ID;
	command.SendType = 1;
	command.RemoteFlag = 0;
	command.ExternFlag = 0;
	command.DataLen = 4;
	BYTE Data[command.DataLen] = {0x50, 0x58, 0x00, 0x00};
	memcpy(command.Data, Data, command.DataLen * sizeof(BYTE));
	monitor_switch = &(data_coming);
	updated_flag = &(data_updated);
	temp_buf = &(rec_data);
	data_coming = 1;
	Send_Command(&command);
	while (data_coming && ros::ok())
	{
		/* code */
		if (rec_data.ID == 0x280 + ID && data_updated)
		{
			//printf("it is my boy\r\n");
			/* code */
			if (rec_data.Data[0]==0x50 && rec_data.Data[1]==0x58)
			{
				/* code */
				data_coming = 0;
				data_updated = 0;
				break;
			}			
		}			
	}
	int32_t main_pos;
	memcpy(&main_pos, &(rec_data.Data[4]), 4 * sizeof(BYTE));
	return main_pos;

}

int motor::Send_Command(VCI_CAN_OBJ * command)
{
	if(VCI_Transmit(VCI_USBCAN2, 0, 0, command, 1) == 1)
	{
		//打印发送指令
		printf("Index:%04d  ",count);count++;
		printf("CAN1 TX ID:0x%08X",command->ID);
		if(command->ExternFlag==0) printf(" Standard ");
		if(command->ExternFlag==1) printf(" Extend   ");
		if(command->RemoteFlag==0) printf(" Data   ");
		if(command->RemoteFlag==1) printf(" Remote ");
		printf("DLC:0x%02X",command->DataLen);
		printf(" data:0x");
		for(int i=0;i<command->DataLen;i++)
		{
			printf(" %02X",command->Data[i]);
		}
		printf("\n");
		return 1;
	}
	else
	{
		return 0;
	}
}

motor::~motor()
{
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
				printf("Index:%04d  ",count);count++;//序号递增
				printf("CAN%d RX ID:0x%08X", ind+1, rec[j].ID);//ID
				if(rec[j].ExternFlag==0) printf(" Standard ");//帧格式：标准帧
				if(rec[j].ExternFlag==1) printf(" Extend   ");//帧格式：扩展帧
				if(rec[j].RemoteFlag==0) printf(" Data   ");//帧类型：数据帧
				if(rec[j].RemoteFlag==1) printf(" Remote ");//帧类型：远程帧
				printf("DLC:0x%02X",rec[j].DataLen);//帧长度
				printf(" data:0x");	//数据 */
				for(i = 0; i < rec[j].DataLen; i++)
				{
					printf(" %02X", rec[j].Data[i]);
				}
				printf(" TimeStamp:0x%08X",rec[j].TimeStamp);//时间标识。
				printf("\n");
				//printf("%d\r\n",*monitor_switch);
				if (*monitor_switch == 1)
				{
					/* code */
					memcpy(temp_buf, &(rec[j]), sizeof(VCI_CAN_OBJ));
					*updated_flag = 1;
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
		
		//printf(" %08X", pInfo.hw_Version);printf("\n");
		//printf(" %08X", pInfo.fw_Version);printf("\n");
		//printf(" %08X", pInfo.dr_Version);printf("\n");
		//printf(" %08X", pInfo.in_Version);printf("\n");
		//printf(" %08X", pInfo.irq_Num);printf("\n");
		//printf(" %08X", pInfo.can_Num);printf("\n");
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

void PIDRegulation(PID *vPID, float processValue)
{
  float thisError;
  thisError=vPID->setpoint-processValue;
  vPID->integral+=thisError;
  vPID->result=vPID->proportiongain*thisError+vPID->integralgain*vPID->integral+vPID->derivativegain*(thisError-vPID->lasterror);
  vPID->lasterror=thisError;
}




main(int argc, char **argv)
{
	printf(">>programme running\r\n");//指示程序已运行

	initialize_can_adaptor();//初始化Can Adaptor设备
	
	ros::init(argc, argv, "motorcontrol");
	pthread_t threadid0;
	int ret0;
	ret0 = pthread_create(&threadid0,NULL,receive_ROS_func, NULL);//启动线程读取节点上传的数据
	
	int m_run0=1;
	pthread_t threadid;
	int ret;
	ret=pthread_create(&threadid,NULL,receive_func,&m_run0);//启动接收线程

	PID torque_ad_m; //力矩控制的PID环节
	PID delta_theta_m1; //转角的PID环节
	float delta_theta_d1; //理想的转角差
	float delta_theta_r1; //实际的转角差
	int32_t theta_m_i1; //初始的电机位置
	float theta_l_i1; //初始的弹簧末端位置
	float Trr_ad; //相对零点的实测力矩值
	float theta_m1; //电机实际相对转角


	usleep(1000000);
	motor motor2(2);
	motor2.Initialize_Can();
	motor2.Motor_Disable();
	motor2.Motor_Mode(5);//选择速度模式
	motor2.Motor_Enable();
	motor2.Motor_Speed_for_PTP(49666);

	theta_m_i1 = motor2.Motor_Main_Pos(); //电机的初始位置
	theta_l_i1 = theta_l1; //弹簧末端的初始位置
	printf("theta_l_i1:%f\r\n",theta_l_i1);
	Ti_ad = Tr_ad; //记录初始力矩值
	usleep(1000000);

	while (ros::ok())
	{
		/* code */
		float degree;
		printf("Input the degree you want to move:");
		scanf("%f",&degree);
		usleep(1000000); //延时一秒
		motor2.Move_To((int32_t)((degree + theta_m1) / 360 * (128.0*500.0*4.0)+ theta_m_i1));
		usleep(1000000); //延时一秒
		theta_m1 = (float)(motor2.Motor_Main_Pos() - theta_m_i1) / (128.0*500.0*4.0) * 360.0; //电机实际相对转角(单位为degree)
		delta_theta_r1 = theta_m1 - (theta_l1 - theta_l_i1); //实际的转角差		
		Trr_ad = Tr_ad - Ti_ad;
		printf("电机转角：%-8.3f末端转角：%-8.3f差值：%-8.3f输出扭矩：%-8.3f\r\n",theta_m1, (theta_l1 - theta_l_i1), delta_theta_r1, Trr_ad);
		usleep(100000); //延时一秒
	}
	

	/*for (int i = 0; i < 1000; i++)
	{
		/* code 
		motor1.Move_To((int32_t)(theta_m_i1 + 2 * i / 360.0 * (128.0*500.0*4.0)));
		usleep(100000);
	}

	for (int i = 0; i < 1000; i++)
	{*/
		/* code
		motor1.Move_To((int32_t)(theta_m_i1 - 2 * i / 360.0 * (128.0*500.0*4.0)));
		usleep(100000);
	}
	motor1.Motor_Stop();
	motor1.Motor_Disable();*/

	//motor* motor2 = new motor(2);
	

	

	/*下面为控制回路 */
	while (ros::ok())
	{
		/* code 
		torque_ad_m.setpoint = Td_ad;
		PIDRegulation(&torque_ad_m, Tr_ad);//力矩值经过PID调制
		delta_theta_d1 = torque_ad_m.result / Ks; //理想的转角差
		delta_theta_m1.setpoint = delta_theta_d1;
		float theta_m1; //电机实际相对转角
		theta_m1 = (float)(motor1.Motor_Main_Pos() - theta_m_i1) / (128.0*500.0*4.0) * 360.0; //电机实际相对转角
		delta_theta_r1 = theta_m1 - (theta_l1 - theta_l_i1); //实际的转角差
		printf("theta_m1:%f\r\n", theta_m1);
		PIDRegulation(&delta_theta_m1, delta_theta_r1);
		motor1.Move_To((int32_t)(((theta_l1 - theta_l_i1) + delta_theta_m1.result) / 360 * (128.0*500.0*4.0)+ theta_m_i1));
		*/

		
		usleep(1000000);
	}
	/*end */

	/*motor motor1(1);
	motor1.Initialize_Can();
	motor1.Motor_Disable();
	motor1.Motor_Mode(2);//选择速度模式
	motor1.Motor_Enable();
	motor1.Motor_Speed(128000);
	motor1.Motor_Begin();
	usleep(5000000);
	motor1.Motor_Stop(); */
	//需要发送的帧，结构体设置
	VCI_CAN_OBJ send[1];
	send[0].ID=0;
	send[0].SendType=0;
	send[0].RemoteFlag=0;
	send[0].ExternFlag=1;
	send[0].DataLen=8;
	
	int i=0;
	for(i = 0; i < send[0].DataLen; i++)
	{
		send[0].Data[i] = i;
	}

	

	int times = 5;
	while(times--)
	{
		if(VCI_Transmit(VCI_USBCAN2, 0, 0, send, 1) == 1)
		{
			printf("Index:%04d  ",count);count++;
			printf("CAN1 TX ID:0x%08X",send[0].ID);
			if(send[0].ExternFlag==0) printf(" Standard ");
			if(send[0].ExternFlag==1) printf(" Extend   ");
			if(send[0].RemoteFlag==0) printf(" Data   ");
			if(send[0].RemoteFlag==1) printf(" Remote ");
			printf("DLC:0x%02X",send[0].DataLen);
			printf(" data:0x");

			for(i=0;i<send[0].DataLen;i++)
			{
				printf(" %02X",send[0].Data[i]);
			}

			printf("\n");
			send[0].ID+=1;
		}
		else
		{
			break;
		}
		
		if(VCI_Transmit(VCI_USBCAN2, 0, 1, send, 1) == 1)
		{
			printf("Index:%04d  ",count);count++;
			printf("CAN2 TX ID:0x%08X", send[0].ID);
			if(send[0].ExternFlag==0) printf(" Standard ");
			if(send[0].ExternFlag==1) printf(" Extend   ");
			if(send[0].RemoteFlag==0) printf(" Data   ");
			if(send[0].RemoteFlag==1) printf(" Remote ");
			printf("DLC:0x%02X",send[0].DataLen);
			printf(" data:0x");			
			for(i = 0; i < send[0].DataLen; i++)
			{
				printf(" %02X", send[0].Data[i]);
			}
			printf("\n");
			send[0].ID+=1;
		}
		else	break;
	}
	usleep(10000000);//延时单位us，这里设置 10 000 000=10s    10s后关闭接收线程，并退出主程序。
	m_run0=0;//线程关闭指令。
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
