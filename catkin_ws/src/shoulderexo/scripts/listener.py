#!/usr/bin/env python
import rospy
from shoulderexo.msg import Sysstatus
from shoulderexo.msg import Motor_Force
import pandas as pd
from pandas import DataFrame
import time
import os
i = 0
Current_Time = time.strftime('%Y%m%d_%H%M%S', time.localtime(time.time()))
xtheta = -1
ytheta = -1
ztheta = -1
motor1_force = -1
motor2_force = -1


def callback(data):
    global i
    global Current_Time
    global xtheta
    global ytheta
    global ztheta
    global motor1_force
    global motor2_force
    if data.record_flag:
        if i == 0:
            Current_Time = time.strftime('%Y%m%d_%H%M%S', time.localtime(time.time()))
            os.mknod(r'/home/jackho/DataRecord/%s.csv' % Current_Time)
            df = DataFrame([['i','m1_angle','spring1_angle','angle_difference1','actual_torque1','ideal_torque1','m2_angle','spring2_angle','angle_difference2','actual_torque2','ideal_torque2','xtheta','ytheta','ztheta']])
            df.to_csv('/home/jackho/DataRecord/%s.csv'%Current_Time,mode='a',header=False,index=False,encoding='gbk')
            print("Start recording")
        df = DataFrame([[i,data.theta_m1,data.theta_l1,data.delta_theta_r1,data.Trr_ad,data.m1_target,data.theta_m2,data.theta_l2,data.delta_theta_r2,data.Trr_cf,data.m2_target,xtheta,ytheta,ztheta]])
        df.to_csv('/home/jackho/DataRecord/%s.csv'%Current_Time,mode='a',header=False,index=False)
        i = i + 1
    else:
        if i != 0:
            i = 0
            print("Finish recording")
        # rospy.loginfo(rospy.get_caller_id() + "theta_m1:%ftheta_l1:%fdelta_theta_r1:%fTrr_ad:%f"%(data.theta_m1,data.theta_l1,data.delta_theta_r1,data.Trr_ad))
    
def Motor_Forcecallback(data):
    global xtheta
    global ytheta
    global ztheta
    global motor1_force
    global motor2_force
    xtheta = data.xtheta
    ytheta = data.ytheta
    ztheta = data.ztheta
    motor1_force = data.motor1_force
    motor2_force = data.motor2_force
    # print("Motor_Forcecallback\r\n")


def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("system_status", Sysstatus, callback)

    rospy.Subscriber("motor_force_topic", Motor_Force, Motor_Forcecallback)

    print("Start listening.....")

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()