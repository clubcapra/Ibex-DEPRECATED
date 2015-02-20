#! /usr/bin/env python

import roslib; roslib.load_manifest('capra_ai')
import rospy
import csv
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Pose2D, Quaternion, PoseWithCovarianceStamped
import time
import math
from tf.transformations import quaternion_from_euler

def callback(data):
    print data
    odom = Odometry()
    odom.pose = data.pose
    odom.header.stamp = rospy.Time.now()
    odom.header.frame_id = "/odom"
    global pub
    pub.publish(odom)

rospy.init_node('listener', anonymous=True)
pub = rospy.Publisher('ekf_odom', Odometry)
rospy.Subscriber("/robot_pose_ekf/odom", PoseWithCovarianceStamped, callback)
rospy.spin()
