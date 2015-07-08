#!/usr/bin/env python

import rospy

from nav_msgs.msg import Odometry
from geometry_msgs.msg import Quaternion
from tf.transformations import *
import math

'''
This node adds a theta to the gps by using the last data's position
'''

def odom_cb(msg):
    new_odom = msg

    # copy covariance but change orientation x,y an z
    cov = new_odom.pose.covariance
    cov2 = []
    for i in range(0, len(cov)):
        if i == 0 or i == 7 or i == 14:
            cov2.append(5.0)
        else:
            cov2.append(cov[i])
    new_odom.pose.covariance = cov2
    pub_odom.publish(new_odom)

if __name__ == "__main__":
    rospy.init_node('gps_low_cov')
    global pub_odom
    pub_odom = rospy.Publisher("/odometry/gps_cov", Odometry, queue_size=10)
    rospy.Subscriber("/odometry/gps", Odometry,  odom_cb)
    rospy.spin()