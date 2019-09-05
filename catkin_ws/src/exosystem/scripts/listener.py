#!/usr/bin/env python
import rospy
from exosystem.msg import Sysstatus

def callback(data):
    rospy.loginfo(rospy.get_caller_id() + "theta_m1:%ftheta_l1:%fdelta_theta_r1:%fTrr_ad:%f"%(data.theta_m1,data.theta_l1,data.delta_theta_r1,data.Trr_ad))
    
def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("system_status", Sysstatus, callback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()