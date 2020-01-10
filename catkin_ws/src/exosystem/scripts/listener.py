#!/usr/bin/env python
import rospy
from exosystem.msg import Sysstatus
import pandas as pd
from pandas import DataFrame
import time
import os
i = 0
Current_Time = time.strftime('%Y%m%d_%H%M%S', time.localtime(time.time()))

def callback(data):
    global i
    global Current_Time
    if data.record_flag:
        if i == 0:
            Current_Time = time.strftime('%Y%m%d_%H%M%S', time.localtime(time.time()))
            os.mknod(r'/home/jackho/DataRecord/%s.csv' % Current_Time)
            df = DataFrame([['i','data.theta_m1','data.theta_l1','data.delta_theta_r1','data.Trr_ad','data.theta_m2','data.theta_l2','data.delta_theta_r2','data.Trr_cf']])
            df.to_csv('/home/jackho/DataRecord/%s.csv'%Current_Time,mode='a',header=False,index=False)
            print("Start recording")
        df = DataFrame([[i,data.theta_m1,data.theta_l1,data.delta_theta_r1,data.Trr_ad,data.theta_m2,data.theta_l2,data.delta_theta_r2,data.Trr_cf]])
        df.to_csv('/home/jackho/DataRecord/%s.csv'%Current_Time,mode='a',header=False,index=False)
        i = i + 1
    else:
        if i != 0:
            i = 0
            print("Finish recording")
        # rospy.loginfo(rospy.get_caller_id() + "theta_m1:%ftheta_l1:%fdelta_theta_r1:%fTrr_ad:%f"%(data.theta_m1,data.theta_l1,data.delta_theta_r1,data.Trr_ad))
    
def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("system_status", Sysstatus, callback)

    print("Start listening.....")

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()