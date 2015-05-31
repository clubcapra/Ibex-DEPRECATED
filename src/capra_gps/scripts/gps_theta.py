#!/usr/bin/env python

import rospy

from nav_msgs.msg import Odometry
from geometry_msgs.msg import Quaternion
from tf.transformations import *
import math
import Queue

'''
This node adds a theta to the gps by using the last data's position
'''
last_odom = Queue.Queue()

def odom_cb(msg):
    global last_odom
    new_odom = msg
    cov_yaw = 10000
    if last_odom.qsize() >= 6:
        oldest = last_odom.get()
        dx = msg.pose.pose.position.x - oldest.pose.pose.position.x
        dy = msg.pose.pose.position.y - oldest.pose.pose.position.y

        # check diff big enough
        if abs(dx) + abs(dy) > 0.3:
            theta = math.atan(dy/dx)
            if dx < 0:
                theta+= math.pi
            #print dx, dy, theta
            theta_q = quaternion_from_euler(0,0,theta)
            new_odom.pose.pose.orientation = Quaternion(theta_q[0], theta_q[1], theta_q[2], theta_q[3])
            cov_yaw = 0.1 #we have a relatively good data, lower covariance

    # copy covariance but change orientation x,y an z
    cov = new_odom.pose.covariance
    cov2 = []
    for i in range(0, len(cov)):
        if i == 21 or i == 28:
            cov2.append(10000)
        elif i == 35:
            cov2.append(cov_yaw)
        elif i == 0 or i == 7 or i == 14:
            cov2.append(0.1)
        else:
            cov2.append(cov[i])
    new_odom.pose.covariance = cov2
    pub_odom.publish(new_odom)
    last_odom.put(msg)

if __name__ == "__main__":
    rospy.init_node('imu_wrapper')
    global pub_odom
    pub_odom = rospy.Publisher("/odometry/gps_theta", Odometry, queue_size=10)
    rospy.Subscriber("/odometry/gps", Odometry,  odom_cb)
    rospy.spin()