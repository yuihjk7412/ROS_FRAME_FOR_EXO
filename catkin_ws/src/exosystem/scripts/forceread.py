#! /usr/bin/env python
#用作拉力记录检测使用
import serial
import time
import numpy as np
import threading
import binascii
import rospy
import pandas as pd
from pandas import DataFrame
import os


if __name__ == '__main__':
    port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    request_Command = bytes.fromhex('01 03 01 C2 00 08 E4 0C')
    with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
        ser.write(request_Command)  #发出请求
        buf = ser.read(21)          #接收回复
        if len(buf) < 21:
            raise serial.SerialTimeoutException
        print("Serial Port OK!")

    while 1:
        temp = input('开始测量？（Y/N）：')
        if temp == 'Y' or temp == 'y':
            break

    rospy.init_node('force_talker', anonymous=True)
    rate = rospy.Rate(60)
    
    #打开串口
    ser = serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None)

    exception_flag = 0  #标志错误发生
    Current_Time = time.strftime('%Y%m%d_%H%M%S', time.localtime(time.time()))
    os.mknod('%s.csv' % Current_Time)
    df = DataFrame([['i','force1']])
    df.to_csv('%s.csv'%Current_Time,mode='a',header=False,index=False)
    print("Start recording")
    i = 0

    while not rospy.is_shutdown():
        ser.write(request_Command)  #发出请求
        buf = ser.read(21)          #接收回复

        if len(buf) < 21:
            continue
        if buf[0] == 0x01:           
            force1 = (int.from_bytes(buf[3:7], signed=True, byteorder='big')) * 0.1
            force2 = (int.from_bytes(buf[7:11], signed=True, byteorder='big')) * 0.1
            df = DataFrame([[i,force1]])
            df.to_csv('%s.csv'%Current_Time,mode='a',header=False,index=False)
            i = i + 1
            rate.sleep()
    ser.close()
