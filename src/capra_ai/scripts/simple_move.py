#! /usr/bin/env python

import roslib; roslib.load_manifest('capra_ai')
import rospy
import time

from geometry_msgs.msg import Twist

rospy.init_node('simple_move')
pub = rospy.Publisher("/cmd_vel", Twist, queue_size=10)

time.sleep(3)

while not rospy.is_shutdown():
    msg = Twist()
    msg.linear.x = 0.4
    msg.angular.z = 0.2
    pub.publish(msg)

    rospy.sleep(1)

rospy.spin()
