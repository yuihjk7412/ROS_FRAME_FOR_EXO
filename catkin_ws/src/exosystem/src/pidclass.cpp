#include "pidclass.h"

//位置PID
PID_position::PID_position():kp(0),ki(0),kd(0),target(0),actual(0),integral(0)
{
    e=target-actual;
    e_pre=e;
}
PID_position::PID_position(float p,float i,float d):kp(p),ki(i),kd(d),target(0),actual(0),integral(0)
{
   e=target-actual;
   e_pre=e;
}
float PID_position::pid_control(float tar,float act)
{
    float u;
    target=tar; //目标值
    actual=act; //实际值
    e=target-actual; //误差
    integral+=e; //积分项
    u=kp*e+ki*integral+kd*(e-e_pre); //计算结果
    e_pre=e; //计算前一拍误差
    return u;
}
void PID_position::pid_show()
{
    using std::cout;
    using std::endl;
    cout<<"The infomation of this position PID controller is as following:"<<endl;
    cout<<"       Kp="<<kp<<endl;
    cout<<"       Ki="<<ki<<endl;
    cout<<"       Kd="<<kd<<endl;
    cout<<" integral="<<integral<<endl;
    cout<<"   target="<<target<<endl;
    cout<<"   actual="<<actual<<endl;
    cout<<"        e="<<e<<endl;
    cout<<"    e_pre="<<e_pre<<endl;
}

//增量PID
PID_incremental::PID_incremental():kp(0),ki(0),kd(0),e_pre_1(0),e_pre_2(0),target(0),actual(0)
{
   A=kp+ki+kd;
   B=-2*kd-kp;
   C=kd;
   e=target-actual;
}
PID_incremental::PID_incremental(float p,float i,float d):kp(p),ki(i),kd(d),e_pre_1(0),e_pre_2(0),target(0),actual(0)
{
   A=kp+ki+kd;
   B=-2*kd-kp;
   C=kd;
   e=target-actual;
}
float PID_incremental::pid_control(float tar,float act)
{
   float u_increment;
   target=tar;
   actual=act;
   e=target-actual;
   u_increment=A*e+B*e_pre_1+C*e_pre_2;
   e_pre_2=e_pre_1;
   e_pre_1=e;
   return u_increment;
}

void PID_incremental::pid_show()
{
    using std::cout;
    using std::endl;
    cout<<"The infomation of this incremental PID controller is as following:"<<endl;
    cout<<"     Kp="<<kp<<endl;
    cout<<"     Ki="<<ki<<endl;
    cout<<"     Kd="<<kd<<endl;
    cout<<" target="<<target<<endl;
    cout<<" actual="<<actual<<endl;
    cout<<"      e="<<e<<endl;
    cout<<"e_pre_1="<<e_pre_1<<endl;
    cout<<"e_pre_2="<<e_pre_2<<endl;
}
