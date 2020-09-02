#! /usr/bin/env python
#读取拉力值，经过转换为实测力矩值，发布话题
import serial
import numpy as np
import threading
import binascii
import rospy
from std_msgs.msg import Float32
from shoulderexo.msg import Torque
from shoulderexo.msg import Encoder
import eventlet  #导入eventlet这个模块
import signal
import time


def set_timeout(num, callback):
    def wrap(func):
        def handle(signum, frame): # 收到信号 SIGALRM 后的回调函数，第一个参数是信号的数字，第二个参数是the interrupted stack frame.
            raise RuntimeError

        def to_do(*args, **kwargs):
            try:
                signal.signal(signal.SIGALRM, handle) # 设置信号和回调函数
                signal.alarm(num) # 设置 num 秒的闹钟
                # print('start alarm signal.')
                r = func(*args, **kwargs)
                # print('close alarm signal.')
                signal.alarm(0) # 关闭闹钟
                return r
            except RuntimeError as e:
                return callback()

        return to_do

    return wrap


if __name__ == '__main__':
    rospy.init_node('force_talker', anonymous=True)
    # eventlet.monkey_patch()   #必须加这条代码
    # port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    request_Command = bytes.fromhex('01 03 01 C2 00 08 E4 0C')
    port_Num = 0
    encoder_port_num = -1

    try:
        encoder_message = rospy.wait_for_message('encoder_topic',Encoder,timeout=1)
        encoder_port_num = encoder_message.port_num
        print(encoder_port_num)
    except rospy.exceptions.ROSException as ex:
        pass

    # 遍历串口找到合适的串口
    while 1:
        if port_Num > 10:
            raise serial.SerialTimeoutException
        if port_Num == encoder_port_num:
            port_Num = port_Num + 1
            continue
        try:
            with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
                ser.write(request_Command)  #发出请求
                buf = ser.read(21)          #接收回复
                if len(buf) >= 21 and buf[0] == 0x01:
                    break
        except serial.serialutil.SerialException as ex:
            pass
        port_Num = port_Num + 1
    print("Serial Port %d OK!"%port_Num)

    # with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=0.2) as ser:
    #     ser.write(request_Command)  #发出请求
    #     buf = ser.read(21)          #接收回复
    #     if len(buf) < 21:
    #         raise serial.SerialTimeoutException
    #     print("Serial Port OK!")

    pub = rospy.Publisher('force_topic', Torque, queue_size=10)
    # rospy.init_node('force_talker', anonymous=True)
    rate = rospy.Rate(100)
    
    #打开串口
    ser = serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None)

    exception_flag = 0  #标志错误发生
    pub_msg = Torque()   
    pub_msg.port_num = port_Num 

    def after_timeout(): # 超时后的处理函数
        ser.flushInput()
        rospy.loginfo("Reading timeout")
        exception_flag = 1
        return None, exception_flag


    @set_timeout(1, after_timeout) # 限时 2 秒
    def connect(): # 要执行的函数
        ser.write(request_Command)
        buf = ser.read(21)
        exception_flag = 0
        return buf, exception_flag
    
    while not rospy.is_shutdown():
        # with serial.Serial("/dev/ttyUSB%d" % int(port_Num), 115200, timeout=None) as ser:
        # ser.write(request_Command)
        # buf = ser.read(21)
        buf, exception_flag= connect()

        # exception_flag = 1
        # with eventlet.Timeout(0.1,False):
        #     ser.write(request_Command)  #发出请求
        #     buf = ser.read(21)          #接收回复
        #     exception_flag = 0
        # if exception_flag:
        #     ser.flushInput()
        #     continue
        

        # ser.write(request_Command)  #发出请求
        # buf = ser.read(21)          #接收回复

        if exception_flag:
            continue
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
            # pub_msg = Torque()            
            pub_msg.torque1 = -(int.from_bytes(buf[3:7], signed=True, byteorder='big')) * 0.1 * 0.03
            pub_msg.torque2 = -(int.from_bytes(buf[7:11], signed=True, byteorder='big')) * 0.1 * 0.03
            pub.publish(pub_msg)
            rospy.loginfo("/dev/ttyUSB%d:force1:%f\tforce2:%f"%(port_Num, pub_msg.torque1,pub_msg.torque2))
            rate.sleep()
    ser.close()