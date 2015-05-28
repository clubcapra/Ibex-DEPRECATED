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

        self.requested_vel = None
        self.requested_vel_time = 0

        rospy.init_node('juvav_recovery_node', log_level=rospy.INFO)
        s_run = rospy.Service('juvav_recovery_node/run', Run, self.handle_run)

        self.smart_cmd_vel_publisher = rospy.Publisher('/smart_cmd_vel', Twist, queue_size=10)
        rospy.Subscriber('/cmd_vel', Twist, self.cmd_vel_callback)

        listener = tf.TransformListener()

        rate = rospy.Rate(4)  # 4Hz
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

    @staticmethod
    def handle_run(msg):
        print "Got a call on RUN service!"
        return True

    def publish_smart_cmd_vel(self, event):
        self.smart_cmd_vel_publisher.publish(self.requested_vel)

    def cmd_vel_callback(self, msg):
        self.requested_vel = msg
        self.requested_vel_time = rospy.get_time()
        self.publish_smart_cmd_vel(None)


if __name__ == "__main__":
    try:
        s = JuvavRecoveryNode()
    except rospy.ROSInterruptException:
        pass
