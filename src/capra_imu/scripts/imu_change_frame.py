#!/usr/bin/env python

import rospy
import tf

from sensor_msgs.msg import Imu
from geometry_msgs.msg import Quaternion, PoseStamped, Pose

import math

'''
This node does some work to transform the imu data for it to be ready for use
in localization
'''
def imu_cb(msg):

    msg_imu = msg

    # Change frame id
    msg_imu.header.frame_id = "imu"
    msg_imu.header.stamp = msg.header.stamp
    pub_imu.publish(msg_imu)


if __name__ == "__main__":
    rospy.init_node('imu_wrapper')
    global pub_imu
    pub_imu = rospy.Publisher("/imu/data", Imu, queue_size=10)
    rospy.Subscriber("/imu/raw", Imu,  imu_cb)
    rospy.spin()