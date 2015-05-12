#!/usr/bin/env python

import rospy
from tf.transformations import *

from sensor_msgs.msg import Imu
from geometry_msgs.msg import Quaternion, PoseStamped, Pose, Point
from nav_msgs.msg import Odometry

import math
import numpy as np

'''
This node does some work to transform the imu data for it to be ready for use
in localization
'''
def imu_cb(msg):

    msg_imu = msg

    # Change frame id
    msg_imu.header.frame_id = "base_footprint"
    msg_imu.header.stamp = msg.header.stamp

    initial = [msg.orientation.x, msg.orientation.y, msg.orientation.z, msg.orientation.w]

    rotation_y = quaternion_about_axis(math.pi/2.0, [0, 1, 0])
    q_rotated_90_y = quaternion_multiply(initial, rotation_y)
    rotation_x = quaternion_about_axis(math.pi, [1, 0, 0])
    q_rotated_90_yx = quaternion_multiply(q_rotated_90_y, rotation_x)
    q_rotated_90_yx[2] = -q_rotated_90_yx[2]
    rotation_z = quaternion_about_axis(math.pi/2.0, [0, 0, 1])
    q_final = quaternion_multiply(q_rotated_90_yx, rotation_z)

    msg_imu.orientation = Quaternion(q_final[0], q_final[1], q_final[2], q_final[3])

    # covariance
    cov = [1.0,0,0,0,1.0,0,0,0,1.0]
    msg_imu.orientation_covariance = cov

    #euler = tf.transformations.euler_from_quaternion(q_flipped)
    pub_imu.publish(msg_imu)

    # publish (0,0,0,1)
    zero = Imu()
    zero.header.frame_id = "odom"
    zero.orientation = Quaternion(0, 0, 0, 1)
    pub_imu_zero.publish(zero)


#def odom_cb(msg):
#
#    msg_mod = msg

#    position = msg.pose.pose.position
#    translation_matrix = tf.transformations.translation_matrix([position.x, position.y, position.z])
#    rotation_initiale = tf.transformations.rotation_matrix(1.22, [0, 0, 1])

#    result = np.dot(rotation_initiale, translation_matrix)
#    result_t = tf.transformations.translation_from_matrix(result)

#    msg_mod.pose.pose.position = Point(result_t[0], result_t[1], result_t[2])

#    pub_odom.publish(msg_mod)


if __name__ == "__main__":
    rospy.init_node('imu_wrapper')
    global pub_imu
    pub_imu_zero = rospy.Publisher("/imu/zero", Imu, queue_size=10)
    pub_imu = rospy.Publisher("/imu/data", Imu, queue_size=10)
    #pub_odom = rospy.Publisher("/odometry/gps_mod", Odometry, queue_size=10)
    rospy.Subscriber("/imu/raw", Imu,  imu_cb)
    #rospy.Subscriber("/odometry/gps", Odometry,  odom_cb)
    rospy.spin()