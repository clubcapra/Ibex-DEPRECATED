#! /usr/bin/env python


import rospy
from sensor_msgs.msg import Image, PointCloud2
import sensor_msgs.point_cloud2 as pc2
from geometry_msgs.msg import Twist
import tf
from cv_bridge import CvBridge
from math import *
from juvav_recovery.srv import *

class JuvavRecoveryNode:

    def __init__(self):

        rospy.init_node('juvav_recovery_node', log_level=rospy.INFO)

        s_run = rospy.Service('juvav_recovery_node/run', Run, self.handle_run)

        pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

        #publish transform to image
        listener = tf.TransformListener()

        rate = rospy.Rate(10)
        while not rospy.is_shutdown():

            tf_found = False

            try:
                (trans, rotQ) = listener.lookupTransform('/base_footprint', '/odom', rospy.Time(0))
                rotE = tf.transformations.euler_from_quaternion(rotQ)

                print trans, rotQ

            except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
                # output error only if the tf was previously found and is now lost.
                if tf_found:
                    rospy.logerr("Error looking up tf")

            rate.sleep()
        rospy.spin()

    def handle_run(self, msg):
        print "Got a call on RUN service!"
        return True

if __name__ == "__main__":
    try:
        s = JuvavRecoveryNode()
    except rospy.ROSInterruptException:
        pass
