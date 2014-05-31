#! /usr/bin/env python

import roslib; roslib.load_manifest('capra_lidar_localization')
import rospy
import csv
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Pose2D, Quaternion
import time
import math
from tf.transformations import quaternion_from_euler

def callback(data):
    odom = Odometry()
    odom.pose.pose.position.x = data.x
    odom.pose.pose.position.y = data.y
    odom.header.stamp = rospy.Time.now()
    odom.header.frame_id = "/laser"
    
    q = quaternion_from_euler(0, 0, data.theta)
    odom.pose.pose.orientation = Quaternion(*q)
    global pub
    pub.publish(odom)

rospy.init_node('listener', anonymous=True)
pub = rospy.Publisher('lidar_odom', Odometry)
rospy.Subscriber("/pose2D", Pose2D, callback)
rospy.spin()
