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
    # Publish a pose with the imu orientation
    p = PoseStamped()
    p.header.frame_id = "odom"
    p.pose = Pose()
    p.pose.orientation = msg.orientation
    global pub_pose
    pub_pose.publish(p)

def imu_cb_raw(msg):
    # Publish a pose with the imu orientation
    p = PoseStamped()
    p.header.frame_id = "odom"
    p.pose = Pose()
    p.pose.orientation = msg.orientation
    global pub_pose_raw
    pub_pose_raw.publish(p)

if __name__ == "__main__":
    rospy.init_node('imu_wrapper')
    global pub_pose_raw
    global pub_pose
    pub_pose = rospy.Publisher("/imu/pose", PoseStamped, queue_size=10)
    pub_pose_raw = rospy.Publisher("/imu/pose_raw", PoseStamped, queue_size=10)
    rospy.Subscriber("/imu/data", Imu,  imu_cb)
    rospy.Subscriber("/imu/raw", Imu,  imu_cb_raw)
    rospy.spin()