#ifndef __MOTORCLASS_H__
#define __MOTORCLASS_H__

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
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


class motor
{
private:
	/* data */
	u_int32_t ID; 
	int32_t speed_limit_L, speed_limit_H; //速度上下限
	int * count;

public:
	motor(u_int32_t id, int * count);
	~motor();
	int data_coming; //显示是否等待有数据到来，0为没有，1为有
	int data_updated; //显示数据是否已经更新
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

#endif