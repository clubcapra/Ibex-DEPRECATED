#!/usr/bin/env python

import roslib
roslib.load_manifest('animatics_smart_motor')
import rospy
from nav_msgs.msg import Odometry
from tf.broadcaster import TransformBroadcaster


def odom_callback(odom):
    global broadcaster
    o = odom.pose.pose.orientation
    p = odom.pose.pose.position
    broadcaster.sendTransform((p.x, p.y, 0),
                               (o.x, o.y, o.z, o.w),
                               odom.header.stamp,
                               "base_footprint",
                               "odom")

rospy.init_node("odom_to_tf")
broadcaster = TransformBroadcaster()
rospy.Subscriber("/odom", Odometry, odom_callback)
rospy.spin()