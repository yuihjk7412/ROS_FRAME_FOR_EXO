#! /usr/bin/env python
import rospy
from exosystem.msg import Encoder
import serial

if __name__ == '__main__':
    # port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    request_Command = bytes.fromhex('7ff7')
    port_Num = 10

    # 遍历串口找到合适的串口
    while 1:
        if port_Num < 0:
            raise serial.SerialTimeoutException
        try:
            with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
                ser.write(request_Command)  #发出请求
                buf = ser.read(6)          #接收回复
                if len(buf) >= 6:
                    break
        except serial.serialutil.SerialException as ex:
            pass
        port_Num = port_Num - 1
    print("Serial Port %d OK!"%port_Num)

    # with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
    #     ser.write(request_Command)  #发出请求
    #     buf = ser.read(6)          #接收回复
    #     if len(buf) < 6:
    #         raise serial.SerialTimeoutException
    #     print("Serial Port OK!")
    
    pub = rospy.Publisher('encoder_topic', Encoder, queue_size=10)
    rospy.init_node('encoder_talker', anonymous=True)
    rate = rospy.Rate(100)

    ser = serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None)

    while not rospy.is_shutdown():
        # with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None) as ser:
        ser.write(request_Command)
        buf = ser.read(6)
        
        if len(buf) < 6:
            continue
        if buf[0] == 0x7f and buf[-1] == 0xf7:
            #print("found data")
            encoder1 = int.from_bytes(buf[1:3], signed=False, byteorder='big')
            encoder2 = int.from_bytes(buf[3:5], signed=False, byteorder='big')
            pub_msg = Encoder()
            pub_msg.encoder1 = 65536/2.0 - encoder1
            pub_msg.encoder2 = 65536/2.0 - encoder2
            pub.publish(pub_msg)
            rospy.loginfo("encoder1:%f  encoder2:%f"%(pub_msg.encoder1,pub_msg.encoder2))
            rate.sleep()
        
                