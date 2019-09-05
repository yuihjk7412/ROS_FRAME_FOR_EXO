#include "motorclass.h"


/*初始化motor类，需要提供驱动器can节点号以及外部计数器 */
motor::motor(u_int32_t id, int * count)
{
	ID = id;
	speed_limit_H = 496666;
	speed_limit_L = -496666;
	data_coming = 0;
	data_updated = 0;
    this->count = count;
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
	BYTE Data[command.DataLen] = {0x53, 0x44, 0x00, 0x00, speed_array[0], speed_array[1], speed_array[2], speed_array[3]};
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
		printf("Index:%04d  ",*count);*count++;
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