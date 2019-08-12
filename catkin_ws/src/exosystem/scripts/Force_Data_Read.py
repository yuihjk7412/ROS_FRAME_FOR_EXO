#! /usr/bin/env python
import serial
import time
import numpy as np
import threading
import binascii
import rospy
from std_msgs.msg import Int32


if __name__ == '__main__':
    port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    request_Command = bytes.fromhex('01 03 01 C2 00 08 E4 0C')
    with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
        print("Serial Port OK!")
    ser.close()
    pub = rospy.Publisher('force_topic', Int32, queue_size=10)
    rospy.init_node('force_talker', anonymous=True)
    rate = rospy.Rate(100)
    while not rospy.is_shutdown():
        with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None) as ser:
            ser.write(request_Command)
            buf = ser.read(21)

        if len(buf) < 21:
                continue
        if buf[0] == 0x01:
            force_val = int.from_bytes(buf[3:7], signed=True, byteorder='big')
            pub.publish(force_val)
            rospy.loginfo("force:%d"%force_val)
            #print(int.from_bytes(buf[3:7], signed=True, byteorder='big'))
            rate.sleep()