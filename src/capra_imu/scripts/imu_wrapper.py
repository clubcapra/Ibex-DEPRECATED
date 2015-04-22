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

    declination = rospy.get_param("~magnetic_declination_radians") # in rad

    msg_imu = msg

    # Change frame id
    msg_imu.header.frame_id = "base_footprint"

    # Add covariance
    msg_imu.orientation_covariance = [1.0, 0.0, 0.0,
                                      0.0, 1.0, 0.0,
                                      0.0, 0.0, 1.0]

    euler = tf.transformations.euler_from_quaternion([msg.orientation.x, msg.orientation.y, msg.orientation.z, msg.orientation.w])

    # Add magnetic declination and invert direction for compatibility with localization
    new_yaw = -(euler[2] - declination) + math.pi/2

    # normalize and convert to quaternion
    if new_yaw >= math.pi:
        new_yaw -= 2 * math.pi;

    if new_yaw <= -math.pi:
        new_yaw += 2 * math.pi;

    euler = (euler[0], euler[1], new_yaw)
    quaternion = tf.transformations.quaternion_from_euler(euler[0], euler[1], euler[2])
    msg_imu.orientation = Quaternion(quaternion[0], quaternion[1], quaternion[2], quaternion[3])

    # publish
    pub_imu.publish(msg)

    # Publish a pose with the imu orientation
    p = PoseStamped()
    p.header.frame_id = "odom"
    p.pose = Pose()
    p.pose.orientation = msg_imu.orientation
    pub_odom.publish(p)

if __name__ == "__main__":
    rospy.init_node('imu_wrapper')
    global pub_imu
    global pub_odom
    pub_imu  = rospy.Publisher("/imu/data", Imu, queue_size=10)
    pub_odom  = rospy.Publisher("/imu/pose", PoseStamped, queue_size=10)
    rospy.Subscriber("/imu/raw", Imu,  imu_cb)
    rospy.spin()