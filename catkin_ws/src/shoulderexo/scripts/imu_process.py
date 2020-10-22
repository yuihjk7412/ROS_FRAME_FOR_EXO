#! /usr/bin/env python
import ctypes
from ctypes import *
import serial
import time
import numpy as np
import threading
import matplotlib.pyplot as plt
import pandas as pd
from pandas import DataFrame
from multiprocessing import Process, Queue
import os
import rospy
from exosystem.msg import Limbpos
from exosystem.msg import Motor_Force
import cmath
import quat
import math


Initialize_Num = 5
Initialize_Threshold = 0.02
Limb_Length = 200; #the length between the origin of the platform and the base
Upper_Limb_Origin = np.array([[0],[0],[0],[1]])
R_initial = np.array([[0,0,1],[0,1,0],[-1,0,0]])
RSs2Js = np.array([[0,0,1],[0,1,0],[-1,0,0]])
Maxium_Graph_Length = 300

def Imu_Data_Decode_Init():
    '''
    wrap the imu_data_decode_init()
    :return: void
    '''
    total_lib.imu_data_decode_init()

def Packet_Decode_w(c):
    '''

    :param c:
    :return:
    '''
    total_lib.Packet_Decode(c_char(c))

def Get_Quat(pointer):
    '''

    :param pointer:
    :return:
    '''
    total_lib.get_quat(byref(pointer))

def Print_Quat_Info():
    '''

    :return:
    '''
    print("POINT1:quat(W X Y Z):%0.3f %0.3f %0.3f %0.3f\r\n" % (Quat[0], Quat[1], Quat[2], Quat[3]))
    print("POINT2:quat(W X Y Z):%0.3f %0.3f %0.3f %0.3f\r\n" % (Quat[4], Quat[5], Quat[6], Quat[7]))

def Stable_Position():
    '''
    description: 获得稳定姿态下四元数
    param {*}
    return {*}返回稳定的四元数
    '''
    temp = np.zeros([1,32])
    i = 0
    while i < Initialize_Num:
        Get_Quat(Quat)
        for j in range(32):
            temp[i,j] = Quat[j]
        print("The %d time initialization:"%(i+1))
        #print(temp)
        #Print_Quat_Info()
        Max_Dif = np.max(temp,axis=0,keepdims=True) - np.min(temp,axis=0,keepdims=True)
        assert (Max_Dif.shape == (1,32))
        if ((Max_Dif > Initialize_Threshold).any()):
            i = 0
            # print(Max_Dif > Initialize_Threshold)
            print("\nStablization Failure!Please stay still!\n")
            temp = np.zeros([1, 32])
            continue
        time.sleep(0.5)
        temp = np.row_stack((temp, np.zeros([1,32])))
        i = i + 1

    temp = np.delete(temp,-1,0)
    assert (temp.shape == (Initialize_Num,32))
    average = np.average(temp, axis=0)
    average = np.reshape(average,(1,32))
    assert(average.shape == (1,32))
    return average

def Hold_On(sec):
    stime = time.time()
    while (time.time()-stime)<sec:
        print('>', end="")
        time.sleep(1)
    print('\r\n')

def Joint2Sensor():
    '''
    description: 得到人体关节相对于传感器的四元数
    param {*}
    return {*}
    '''

    # 先获得Npose姿态下第一个姿态的四元数和偏航角
    print("ORIGIN POSITION")
    print("请保持双臂紧贴于身体两侧，手掌贴于身体两侧且拇指指向身体前方")
    position_0 = Stable_Position()
    qSs02Es = quat.Quaternion(position_0[0][0],position_0[0][1],position_0[0][2],position_0[0][3])
    qSu02Eu = quat.Quaternion(position_0[0][4],position_0[0][5],position_0[0][6],position_0[0][7])

    # 使用者保持Npose原地转动一定角度，获取当前姿态下四元数和偏航角
    print("身体转过一定角度")
    print("请保持双臂紧贴于身体两侧，手掌贴于身体两侧且拇指指向身体前方")
    Hold_On(5)
    position_1 = Stable_Position()
    qSs12Es = quat.Quaternion(position_1[0][0],position_1[0][1],position_1[0][2],position_1[0][3])
    qSu12Eu = quat.Quaternion(position_1[0][4],position_1[0][5],position_1[0][6],position_1[0][7])

    # 计算初始偏航角
    delta_theta_s = (qSs12Es.Euler321())[0] - (qSs02Es.Euler321())[0]
    delta_theta_u = (qSu12Eu.Euler321())[0] - (qSu02Eu.Euler321())[0]
    w1 = qSs02Es.s
    z1 = qSs02Es.z
    w2 = qSs12Es.s
    z2 = qSs12Es.z
    theta = delta_theta_s
    theta_s = -2 * math.atan2(w1-w2*math.cos(theta/2)+z2*math.sin(theta/2), z2*math.cos(theta/2)-z1+w2*math.sin(theta/2))
    # theta_s = -cmath.log(-cmath.sqrt(-(w1*1j - z1 - w2*cmath.exp((theta*1j)/2)*1j + z2*cmath.exp((theta*1j)/2))*(w2*1j + z2 - w1*cmath.exp((theta*1j)/2)*1j - z1*cmath.exp((theta*1j)/2)))/(w1*cmath.exp((theta*1j)/4) - w2*cmath.exp((theta*3j)/4) + z1*cmath.exp((theta*1j)/4)*1j - z2*cmath.exp((theta*3j)/4)*1j))*2j
    # theta_s = theta_s.real

    w1 = qSu02Eu.s
    z1 = qSu02Eu.z
    w2 = qSu12Eu.s
    z2 = qSu12Eu.z
    theta = delta_theta_u
    theta_u = -2 * math.atan2(w1-w2*math.cos(theta/2)+z2*math.sin(theta/2), z2*math.cos(theta/2)-z1+w2*math.sin(theta/2))
    # theta_u = -cmath.log(-cmath.sqrt(-(w1*1j - z1 - w2*cmath.exp((theta*1j)/2)*1j + z2*cmath.exp((theta*1j)/2))*(w2*1j + z2 - w1*cmath.exp((theta*1j)/2)*1j - z1*cmath.exp((theta*1j)/2)))/(w1*cmath.exp((theta*1j)/4) - w2*cmath.exp((theta*3j)/4) + z1*cmath.exp((theta*1j)/4)*1j - z2*cmath.exp((theta*3j)/4)*1j))*2j
    # theta_u = theta_u.real
    #计算人体关节相对于传感器的四元数
    qJs02Es = quat.Quaternion(cmath.cos(theta_s/2),0,0,cmath.sin(theta_s/2))
    qJu02Eu = quat.Quaternion(cmath.cos(theta_s/2),0,0,cmath.sin(theta_s/2))
    qJs2Ss = qSs02Es.conj()*qJs02Es
    qJu2Su = qSu02Eu.conj()*qJu02Eu
    return[qJs2Ss,qJu2Su]

    temp = np.zeros([1,32])
    print("Initialization Processing")
    print("请保持双臂紧贴于身体两侧，手掌贴于身体两侧且拇指指向身体前方")
    i = 0
    while i < Initialize_Num:
        Get_Quat(Quat)
        for j in range(32):
            temp[i,j] = Quat[j]
        print("The %d time initialization:"%(i+1))
        #print(temp)
        #Print_Quat_Info()
        Max_Dif = np.max(temp,axis=0,keepdims=True) - np.min(temp,axis=0,keepdims=True)
        assert (Max_Dif.shape == (1,32))
        if ((Max_Dif > Initialize_Threshold).any()):
            i = 0
            # print(Max_Dif > Initialize_Threshold)
            print("\nInitialization Failure!Please stay still!\n")
            temp = np.zeros([1, 32])
            continue
        time.sleep(0.5)
        temp = np.row_stack((temp, np.zeros([1,32])))
        i = i + 1

    temp = np.delete(temp,-1,0)
    assert (temp.shape == (Initialize_Num,32))
    average = np.average(temp, axis=0)
    average = np.reshape(average,(1,32))
    assert(average.shape == (1,32))
    print("Initialization Completed!")
    print('The 1 IMU initial Quat is:',average[0][0:4])
    print('The 2 IMU initial Quat is:',average[0][4:8])
    return average

def Serial_Read():
    # ser = serial.Serial("/dev/ttyUSB%d"%int(Port_Num), 115200)
    while not rospy.is_shutdown():
        with serial.Serial("/dev/ttyUSB%d"%int(Port_Num), 115200) as ser:
            time.sleep(0.01)
            num = ser.in_waiting
            buf = ser.read(num)
        
        # time.sleep(0.01)
        # num = ser.in_waiting
        # buf = ser.read(num)

        if num:
            for i in range(num):
                Packet_Decode_w(buf[i])
    
    print("EXIT SERIAL_READ THREAD")

def Quat2R(q0,q1,q2,q3):
    '''

    :param q0:
    :param q1:
    :param q2:
    :param q3:
    :return:
    '''
    R = np.zeros([3,3])
    R[0,0] = 1 - 2 * q2**2 - 2 * q3**2
    R[0,1] = 2 * q1 * q2 - 2 * q0 * q3
    R[0,2] = 2 * q1 * q3 + 2 * q0 * q2
    R[1,0] = 2 * q1 * q2 + 2 * q0 * q3
    R[1,1] = 1 - 2 * q1**2 - 2 * q3**2
    R[1,2] = 2 * q2 * q3 - 2 * q0 * q1
    R[2,0] = 2 * q1 * q3 - 2 * q0 * q2
    R[2,1] = 2 * q2 * q3 + 2 * q0 * q1
    R[2,2] = 1 - 2 * q1**2 - 2 * q2**2
    assert (R.shape == (3,3))
    return R

def Cur_Quat2Relative_R(Relative_Zero_Points, Current_Points, REu2Es, RSs2Js, Total_Arr_Length = 32):

    RSs02e= Quat2R(Relative_Zero_Points[0,0],Relative_Zero_Points[0,1],Relative_Zero_Points[0,2],Relative_Zero_Points[0,3])
    RSu02e = Quat2R(Relative_Zero_Points[0,4],Relative_Zero_Points[0,5],Relative_Zero_Points[0,6],Relative_Zero_Points[0,7])
    RSs2e = Quat2R(Current_Points[0,0],Current_Points[0,1],Current_Points[0,2],Current_Points[0,3])
    RSu2e = Quat2R(Current_Points[0,4],Current_Points[0,5],Current_Points[0,6],Current_Points[0,7])
    
    RSs2Ss0 = np.dot(np.linalg.inv(RSs02e), RSs2e)
    RSu2Su0 = np.dot(np.linalg.inv(RSu02e),RSu2e)

    RJs2Js0 = np.dot(RSs2Js, RSs2Ss0)
    RJs2Js0 = np.dot(RJs2Js0, np.linalg.inv(RSs2Js))

    RSu2Ju = np.dot(RSs2Js, np.linalg.inv(RSs02e))
    RSu2Ju = np.dot(RSu2Ju, REu2Es)
    RSu2Ju = np.dot(RSu2Ju, RSu02e)
    RJu2Ju0 = np.dot(RSu2Ju, RSu2Su0)
    RJu2Ju0 = np.dot(RJu2Ju0, np.linalg.inv(RSu2Ju))

    RJu2Js = np.dot(np.linalg.inv(RJs2Js0), RJu2Ju0)

    return RJu2Js

def Get_Limb_Pos(Rot_Mat):
    assert (Rot_Mat.shape == (3,3))
    Trans = np.column_stack((Rot_Mat, np.zeros([3,1])))
    Trans = np.row_stack((Trans, np.zeros((1,4))))
    # 初始位姿为双臂垂于体侧
    Linear_Trans = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,-Limb_Length],[0,0,0,1]])
    # 初始位姿为Tpose
    #Linear_Trans = np.array([[1, 0, 0, 0], [0, 1, 0, -Limb_Length], [0, 0, 1, 0], [0, 0, 0, 1]])
    Trans = np.dot(Trans,Linear_Trans)
    u_o = np.dot(Trans, Upper_Limb_Origin)
    return [u_o]

def Stop_The_Process():
    while(1):
        temp = input("input q to terminate the process:")
        if temp == 'q':
            return False

def Get_Euler_Angle(Rot_Mat):
    assert (Rot_Mat.shape == (3, 3))
    #初始位姿为Tpose
    '''xtheta = np.degrees(np.arcsin(-Rot_Mat[1][2]))
    ytheta = np.degrees(np.arctan(Rot_Mat[0][2] / Rot_Mat[2][2]))
    ztheta = np.degrees(np.arctan(Rot_Mat[1][0] / Rot_Mat[1][1]))'''
    #初始姿态为Npose
    xtheta = np.degrees(np.arctan2(-Rot_Mat[1][2], Rot_Mat[2][2]))
    # ytheta = np.degrees(np.arctan2(Rot_Mat[0][2]*np.sin(np.radians(xtheta)), -Rot_Mat[1][2]))
    ytheta = np.degrees(np.arctan(Rot_Mat[0][2]*np.sin(np.radians(xtheta)) / -Rot_Mat[1][2]))
    ztheta = np.degrees(np.arctan2(-Rot_Mat[0][1], Rot_Mat[0][0]))
    return [xtheta, ytheta, ztheta]


def cal_RSsJs(q0,q1,q2,q3):
    '''计算传感器相对于关节角度的旋转矩阵'''
    # 放置与躯干传感器默认Y轴与关节Y轴平行，放置于胸前，Z轴指向身体外
    RSs2Js = Quat2R(q0,q1,q2,q3)
    xta = np.arctan2(RSs2Js[2,1], RSs2Js[2,2])
    yta = np.arcsin(-RSs2Js[2,0])
    yta = np.squeeze(yta)
    xta = np.squeeze(xta)
    RSs2Js = np.array([[np.cos(yta),np.sin(xta)*np.sin(yta), np.sin(yta)*np.cos(xta)],[0,np.cos(xta),-np.sin(xta)],
                       [-np.sin(yta),np.cos(yta)*np.sin(xta),np.cos(xta)*np.cos(yta)]])
    print('ytheta:%0.3f'%np.degrees(yta))
    print('xtheta:%0.3f' % np.degrees(xta))
    return RSs2Js

def Norm_Cordinate():
    '''
    description: 两个传感器初始姿态存在偏差，需要进行统一
    param {None}
    return {}大臂传感器相对于肩关节传感器的四元数
    '''
    print("请将两个IMU放置为同一姿态")
    time.sleep(2)
    temp = np.zeros([1, 32])
    i = 0
    while i < Initialize_Num:
        Get_Quat(Quat)
        for j in range(32):
            temp[i, j] = Quat[j]
        print("The %d time initialization:" % (i + 1))
        # print(temp)
        # Print_Quat_Info()
        Max_Dif = np.max(temp, axis=0, keepdims=True) - np.min(temp, axis=0, keepdims=True)
        assert (Max_Dif.shape == (1, 32))
        if ((Max_Dif > Initialize_Threshold).any()):
            i = 0
            print(Max_Dif > Initialize_Threshold)
            print("Initialization Failure!Please stay still!")
            temp = np.zeros([1, 32])
            continue
        time.sleep(0.5)
        temp = np.row_stack((temp, np.zeros([1, 32])))
        i = i + 1

    temp = np.delete(temp, -1, 0)
    average = np.average(temp, axis=0)
    average = np.reshape(average, (1, 32))
    # RSs2Es = Quat2R(average[0][0],average[0][1],average[0][2],average[0][3])
    # RSu2Eu = Quat2R(average[0][4],average[0][5],average[0][6],average[0][7])
    # REu2Es = np.dot(RSs2Es,np.linalg.inv(RSu2Eu))
    # return REu2Es 
    qSs2Es = quat.Quaternion(average[0][0],average[0][1],average[0][2],average[0][3])
    qSu2Eu = quat.Quaternion(average[0][4],average[0][5],average[0][6],average[0][7])
    qEu2Es = qSs2Es * qSu2Eu.conj()
    return qEu2Es
    
    

"""根据位姿计算两路绳系的拉力值"""
def Cal_Motor_Force(Rot_Mat_u2s):
    Tad = (189*(409**(1/2))*(Rot_Mat_u2s[0,0]*Rot_Mat_u2s[1,2] - Rot_Mat_u2s[0,2]*Rot_Mat_u2s[1,0]))/(20*(Rot_Mat_u2s[0,0]*Rot_Mat_u2s[1,1]*Rot_Mat_u2s[2,2] - Rot_Mat_u2s[0,0]*Rot_Mat_u2s[1,2]*Rot_Mat_u2s[2,1] - Rot_Mat_u2s[0,1]*Rot_Mat_u2s[1,0]*Rot_Mat_u2s[2,2] + Rot_Mat_u2s[0,1]*Rot_Mat_u2s[1,2]*Rot_Mat_u2s[2,0] + Rot_Mat_u2s[0,2]*Rot_Mat_u2s[1,0]*Rot_Mat_u2s[2,1] - Rot_Mat_u2s[0,2]*Rot_Mat_u2s[1,1]*Rot_Mat_u2s[2,0]))
    Tcf = (189*(409**(1/2))*(Rot_Mat_u2s[0,1]*Rot_Mat_u2s[1,2] - Rot_Mat_u2s[0,2]*Rot_Mat_u2s[1,1]))/(20*(Rot_Mat_u2s[0,0]*Rot_Mat_u2s[1,1]*Rot_Mat_u2s[2,2] - Rot_Mat_u2s[0,0]*Rot_Mat_u2s[1,2]*Rot_Mat_u2s[2,1] - Rot_Mat_u2s[0,1]*Rot_Mat_u2s[1,0]*Rot_Mat_u2s[2,2] + Rot_Mat_u2s[0,1]*Rot_Mat_u2s[1,2]*Rot_Mat_u2s[2,0] + Rot_Mat_u2s[0,2]*Rot_Mat_u2s[1,0]*Rot_Mat_u2s[2,1] - Rot_Mat_u2s[0,2]*Rot_Mat_u2s[1,1]*Rot_Mat_u2s[2,0]))
    return [Tad,Tcf]

def Bias_Minimize(R):
    # 算法的思路是前面的步骤已经将人体关节和传感器关节调整到同一水平面内，则需要调整偏航角保证朝向相同
    print("请水平外展手臂\r\n")
    time.sleep(2)
    theta_bias_z_abd = 100
    while np.absolute(np.degrees(theta_bias_z_abd)) > 2 and not rospy.is_shutdown() :
        theta_bias_z_abd = 0
        for i in range(5):
            Get_Quat(Quat)
            Rot_Mat_u2s = Cur_Quat2Relative_R(Quat_Relative_Zero_Point, (np.asarray(Quat)).reshape((1,-1)), REu2Es, R)
            upper_o = Get_Limb_Pos(Rot_Mat_u2s)
            print("X:%-8.3fY:%-8.3fZ:%-8.3f"%(upper_o[0][0,0],upper_o[0][1,0],upper_o[0][2,0]))
            x_bias = upper_o[0][0,0]
            y_bias = upper_o[0][1,0]
            theta_bias_z_abd = np.arctan(x_bias / y_bias) / 5 + theta_bias_z_abd
            print("x_bias:%-8.3f\ty_bias:%-8.3f\tangle:%-8.3f\r\n"%(x_bias,y_bias, np.arctan(x_bias / y_bias)))
            time.sleep(1)
        bias_matrix = np.array([[np.cos(theta_bias_z_abd),-np.sin(theta_bias_z_abd), 0],[np.sin(theta_bias_z_abd),np.cos(theta_bias_z_abd),0],
                       [0,0,1]])
        R = np.dot(bias_matrix, R)
        print("角度偏差：%f\n"%np.degrees(theta_bias_z_abd))

    print("请水平前抬手臂\r\n")
    time.sleep(2)
    theta_bias_z = 100
    while np.absolute(np.degrees(theta_bias_z)) > 2 and not rospy.is_shutdown() :
        theta_bias_z = 0
        for i in range(5):
            Get_Quat(Quat)
            Rot_Mat_u2s = Cur_Quat2Relative_R(Quat_Relative_Zero_Point, (np.asarray(Quat)).reshape((1,-1)), REu2Es, R)
            upper_o = Get_Limb_Pos(Rot_Mat_u2s)
            print("X:%-8.3fY:%-8.3fZ:%-8.3f"%(upper_o[0][0,0],upper_o[0][1,0],upper_o[0][2,0]))
            x_bias = upper_o[0][0,0]
            y_bias = upper_o[0][1,0]
            theta_bias_z = -np.arctan(y_bias / x_bias) / 5 + theta_bias_z
            print("x_bias:%-8.3f\ty_bias:%-8.3f\tangle:%-8.3f\r\n"%(x_bias,y_bias, -np.arctan(y_bias / x_bias)))
            time.sleep(1)
        bias_matrix = np.array([[np.cos(theta_bias_z),-np.sin(theta_bias_z), 0],[np.sin(theta_bias_z),np.cos(theta_bias_z),0],
                       [0,0,1]])
        R = np.dot(bias_matrix, R)
        print("角度偏差：%f\n"%np.degrees(theta_bias_z))
    return R


if __name__ == '__main__':


    while 1:
        temp = input("start the process?(Y/N):")
        if temp == 'Y' or temp == 'y':
            break

    total_lib = cdll.LoadLibrary("/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/scripts/libtotal.so")
    Imu_Data_Decode_Init()
    Quat = (c_float * 32)()
    xtheta = [0]
    ytheta = [0]
    ztheta = [0]
    xpos = [0]
    ypos = [0]
    zpos = [0]
    Port_Num = input('PLEASE INPUT THE PORT NUMBER(/dev/ttyUSB*):')
    with serial.Serial("/dev/ttyUSB%d" % int(Port_Num), 115200, timeout=0.2) as ser:
        print("Serial Port OK!")
    ser.close()

    # 打开串口线程，持续读数
    try:
        ts = threading.Thread(target=Serial_Read, name='Serial_Read_Thread')

    except:
        raise EOFError
    ts.start() #start reading the data from the Serai port

    # 初始化ROS节点和发布者
    # pub = rospy.Publisher('pos_topic', Limbpos, queue_size=10)
    pub_f = rospy.Publisher('motor_force_topic', Motor_Force, queue_size=10)
    rospy.init_node('pos_talker', anonymous=True)
    rate = rospy.Rate(100)

    # 统一IMU的参考系
    temp = input("统一IMU参考系?(Y/N)")
    if temp == 'Y' or temp == 'y':
        qEu2Es = Norm_Cordinate()
    else:
        qEu2Es = quat.Quaternion(1,0,0,0)

    # 设置初始姿态，Npose，即为双手自然下垂，紧贴大腿两侧
    while 1:
        temp = input("Set the initial position?(Y/N)")
        if temp == 'Y' or temp == 'y':
            break
    [qJs2Ss,qJu2Su] = Joint2Sensor() #关节相对于传感器的四元数

    while not rospy.is_shutdown():
        Get_Quat(Quat)
        qSs2Es = quat.Quaternion(Quat[0],Quat[1],Quat[2],Quat[3])
        qSu2Eu = quat.Quaternion(Quat[4],Quat[5],Quat[6],Quat[7])
        qJs2Es = qSs2Es*qJs2Ss
        qJu2Eu = qSu2Eu*qJu2Su
        qJu2Js = qJs2Es.conj() * qEu2Es
        qJu2Js = qJu2Js * qJu2Eu
        msg_pub = Motor_Force()
        [msg_pub.ztheta, msg_pub.ytheta, msg_pub.xtheta] = qJu2Js.Euler321()
        pos = np.dot(qJu2Js.Rotation_Matrix(), np.array([[0],[0],[-Limb_Length]]))
        [msg_pub.motor1_force,msg_pub.motor2_force] = Cal_Motor_Force(qJu2Js.Rotation_Matrix())
        print("\r xtheta:%-8.2fytheta:%-8.2fztheta:%-8.2fxpos:%-8.2fypos:%-8.2fzpos:%-8.2fTad:%-8.2fTcf:%-8.2f"\
            %(msg_pub.xtheta,msg_pub.ytheta,msg_pub.ztheta,pos[0,0],pos[1,0],pos[2,0],msg_pub.motor1_force,msg_pub.motor2_force), end="")

        pub_f.publish(msg_pub)

        rate.sleep()

    ts.join()

    # print(Quat_Relative_Zero_Point[0,0],Quat_Relative_Zero_Point[0,1],Quat_Relative_Zero_Point[0,2],Quat_Relative_Zero_Point[0,3])
    # RSs2Js = cal_RSsJs(Quat_Relative_Zero_Point[0,0],Quat_Relative_Zero_Point[0,1],Quat_Relative_Zero_Point[0,2],Quat_Relative_Zero_Point[0,3])
    # RSs2Js = Bias_Minimize(RSs2Js)
    # # 是否记录数据
    # Flag_Data_Record = input("Record the data?(Y/N)")
    # if Flag_Data_Record == 'Y' or Flag_Data_Record == 'y':
    #     Flag_Data_Record = True
    #     # 获取当前时间作为文件名，建立空白.csv文档
    #     Current_Time = time.strftime('%Y%m%d_%H%M%S', time.localtime(time.time()))
    #     os.mknod('%s.csv' % Current_Time)
    #     df = DataFrame([['xtheta','ytheta','ztheta','xpos','ypos','zpos','Tad','Tcf']])
    #     df.to_csv('%s.csv'%Current_Time,mode='a',header=False,index=False)
    # else:
    #     Flag_Data_Record = False

    # time_start = time.time()

    # while not rospy.is_shutdown():
    #     Get_Quat(Quat)
    #     Rot_Mat_u2s = Cur_Quat2Relative_R(Quat_Relative_Zero_Point, (np.asarray(Quat)).reshape((1,-1)), REu2Es, RSs2Js)
    #     msg_pub = Motor_Force()
    #     [msg_pub.motor1_force,msg_pub.motor2_force] = Cal_Motor_Force(Rot_Mat_u2s)
    #     upper_o = Get_Limb_Pos(Rot_Mat_u2s)
    #     [msg_pub.xtheta, msg_pub.ytheta, msg_pub.ztheta] = Get_Euler_Angle(Rot_Mat_u2s)
    #     pub_f.publish(msg_pub)#发布计算出来的拉力结果
    #     '''xtheta.append(xtheta_temp)
    #     ytheta.append(ytheta_temp)
    #     ztheta.append(ztheta_temp)
    #     xpos.append(upper_o[0][0,0])
    #     ypos.append(upper_o[0][1,0])
    #     zpos.append(upper_o[0][2,0])'''
    #     #msg_pub = Limbpos()
    #     #msg_pub.xtheta = xtheta_temp
    #     #msg_pub.ytheta = ytheta_temp
    #     #msg_pub.ztheta = ztheta_temp
    #     #pub.publish(msg_pub)
    #     # rospy.loginfo("Tad:%-8.2fTcf:%-8.2f"%(msg_pub.motor1_force,msg_pub.motor2_force))
    #     print("\r xtheta:%-8.2fytheta:%-8.2fztheta:%-8.2fxpos:%-8.2fypos:%-8.2fzpos:%-8.2fTad:%-8.2fTcf:%-8.2f"\
    #     %(msg_pub.xtheta,msg_pub.ytheta,msg_pub.ztheta,upper_o[0][0,0],upper_o[0][1,0],upper_o[0][2,0],msg_pub.motor1_force,msg_pub.motor2_force), end="")

    #     #Points_Num = list(range(len(xtheta)))
    #     if Flag_Data_Record:
    #         df = DataFrame([[msg_pub.xtheta,msg_pub.ytheta,msg_pub.ztheta,upper_o[0][0,0],upper_o[0][1,0],upper_o[0][2,0],msg_pub.motor1_force,msg_pub.motor2_force]])
    #         df.to_csv('%s.csv'%Current_Time,mode='a',header=False,index=False)

    #     rate.sleep()
    
    # ts.join()
    # print("")
