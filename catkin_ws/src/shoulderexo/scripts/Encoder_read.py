#! /usr/bin/env python
import rospy
from shoulderexo.msg import Encoder
import serial
import threading    
from shoulderexo.msg import Torque
import eventlet  #导入eventlet这个模块

if __name__ == '__main__':
    rospy.init_node('encoder_talker', anonymous=True)
    eventlet.monkey_patch()   #必须加这条代码
    # port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    request_Command = bytes.fromhex('7ff7')
    port_Num = 10
    force_port_num = -1

    try:
        encoder_message = rospy.wait_for_message('encoder_topic',Encoder,timeout=1)
        force_port_num = encoder_message.port_num
        print(force_port_num)
    except rospy.exceptions.ROSException as ex:
        pass

    # 遍历串口找到合适的串口
    while 1:
        if port_Num < 0:
            raise serial.SerialTimeoutException
        if port_Num == force_port_num:
            port_Num = port_Num + 1
            continue
        try:
            with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
                ser.write(request_Command)  #发出请求
                buf = ser.read(6)          #接收回复
                if len(buf) >= 6 and buf[0] == 0x7f and buf[-1] == 0xf7:
                    break
        except serial.serialutil.SerialException as ex:
            pass
        port_Num = port_Num - 1
    print("Serial Port %d OK!"%port_Num)
    
    pub = rospy.Publisher('encoder_topic', Encoder, queue_size=10)
    rate = rospy.Rate(100)

    ser = serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None)

    ser.write(request_Command)
    buf = ser.read(6)
    # t.start()
    exception_flag = 0

    while not rospy.is_shutdown():
        # with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None) as ser:
        exception_flag = 1
        with eventlet.Timeout(0.1,False):
            ser.write(request_Command)  #发出请求
            buf = ser.read(6)          #接收回复
            exception_flag = 0
        if exception_flag:
            ser.flushInput()
        # ser.write(request_Command)
        # buf = ser.read(6)      
        
        if len(buf) < 6:
            print("less than ok")
            continue
        if buf[0] == 0x7f and buf[-1] == 0xf7:
            #print("found data")
            encoder1 = int.from_bytes(buf[1:3], signed=False, byteorder='big')
            encoder2 = int.from_bytes(buf[3:5], signed=False, byteorder='big')
            pub_msg = Encoder()
            pub_msg.encoder1 = 65536/2.0 - encoder1
            pub_msg.encoder2 = 65536/2.0 - encoder2
            pub.publish(pub_msg)
            rospy.loginfo("/dev/ttyUSB%d:encoder1:%f  encoder2:%f"%(port_Num, pub_msg.encoder1,pub_msg.encoder2))
            rate.sleep()
        
                