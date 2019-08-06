#! /usr/bin/env python
import rospy
from std_msgs.msg import UInt16
import serial

if __name__ == '__main__':
    port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
        print("Serial Port OK!")
    pub = rospy.Publisher('encoder_topic', UInt16, queue_size=10)
    rospy.init_node('encoder_talker', anonymous=True)
    rate = rospy.Rate(50)
    while not rospy.is_shutdown():
        with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.1) as ser:
            buf = ser.read(6)
            print(buf)
            if len(buf) < 6:
                continue
            if buf[0] == b'\x7f' and buf[-1] == b'\xf7':
                print("found data")
                encoder1 = int.from_bytes(buf[1:3], signed=False, byteorder='big')
                encoder2 = int.from_bytes(buf[3:5], signed=False, byteorder='big')
                rospy.loginfo("encoder1:%d  encoder2:%d"%(encoder1,encoder2))
                rate.sleep()
        
                