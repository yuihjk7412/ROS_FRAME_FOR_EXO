#ifndef __PIDCLASS_H__
#define __PIDCLASS_H__

#include <iostream>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

#include <ctime>
#include <cstdlib>
#include "unistd.h"

//位置式PID
class PID_position
{
private:
    float kp;//比例系数
    float ki;//积分系数
    float kd;//微分系数
    float target;//目标值
    float actual;//实际值
    float e;//误差
    float e_pre;//上一次误差
    float integral;//积分项
public:
    PID_position();
    ~PID_position(){};
    PID_position(float p,float i,float d);
    float pid_control(float tar,float act);//执行PID控制
    void pid_show();//显示PID控制器的内部参数
};

//增量式PID
class PID_incremental
{
private:
    float kp;
    float ki;
    float kd;
    float target;
    float actual;
    float e;
    float e_pre_1;
    float e_pre_2;
    float A;
    float B;
    float C;
public:
    PID_incremental();
    PID_incremental(float p,float i,float d);
    float pid_control(float tar,float act);
    void pid_show();
};

#endif