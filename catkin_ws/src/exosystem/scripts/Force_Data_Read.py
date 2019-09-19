#! /usr/bin/env python
import serial
import time
import numpy as np
import threading
import binascii
import rospy
from std_msgs.msg import Float32
from exosystem.msg import Torque


if __name__ == '__main__':
    port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    request_Command = bytes.fromhex('01 03 01 C2 00 08 E4 0C')
    with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
        ser.write(request_Command)  #发出请求
        buf = ser.read(21)          #接收回复
        if len(buf) < 21:
            raise serial.SerialTimeoutException
        print("Serial Port OK!")

    pub = rospy.Publisher('force_topic', Torque, queue_size=10)
    rospy.init_node('force_talker', anonymous=True)
    rate = rospy.Rate(60)
    
    #打开串口
    ser = serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None)

    exception_flag = 0  #标志错误发生
    
    while not rospy.is_shutdown():
        # with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None) as ser:
        #     ser.write(request_Command)
        #     buf = ser.read(21)

        ser.write(request_Command)  #发出请求
        buf = ser.read(21)          #接收回复

        if len(buf) < 21:
            # ser.flushInput()
            # exception_flag += 1
            # if exception_flag == 10:
            #     print("Time out error. Please check the connection.")
            #     break
            # else:
            #     print("read error")
            continue
        if buf[0] == 0x01:
            pub_msg = Torque()            
            pub_msg.torque1 = -(int.from_bytes(buf[3:7], signed=True, byteorder='big')) * 0.1 * 0.03
            pub_msg.torque2 = -(int.from_bytes(buf[7:11], signed=True, byteorder='big')) * 0.1 * 0.03
            pub.publish(pub_msg)
            rospy.loginfo("force1:%f\tforce2:%f"%(pub_msg.torque1,pub_msg.torque2))
            #print(int.from_bytes(buf[3:7], signed=True, byteorder='big'))
            rate.sleep()
    ser.close()