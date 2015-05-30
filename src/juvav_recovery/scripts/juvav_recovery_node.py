#! /usr/bin/env python


import rospy
from sensor_msgs.msg import Image, PointCloud2
import sensor_msgs.point_cloud2 as pc2
from geometry_msgs.msg import Twist
from nav_msgs.msg import Path

import tf
from cv_bridge import CvBridge
from math import *
from juvav_recovery.srv import *

from numpy import array
from numpy.linalg import inv

from collections import deque

undo_cmd_vel = False


class JuvavRecoveryNode:

    def __init__(self):
        self.undo_stack = deque((), 400)
        self.requested_vel = None
        self.requested_vel_time = 0

        rospy.init_node('juvav_recovery_node', log_level=rospy.INFO)
        s_run = rospy.Service('juvav_recovery_node/run', Run, self.handle_run)

        self.smart_cmd_vel_publisher = rospy.Publisher('/smart_cmd_vel', Twist, queue_size=10)
        rospy.Subscriber('/cmd_vel', Twist, self.cmd_vel_callback)
        rospy.Subscriber('/move_base/TrajectoryPlannerROS/local_plan', Path, self.local_path_callback)

        listener = tf.TransformListener()

        count = 0

        rate = rospy.Rate(4)  # 4Hz
        while not rospy.is_shutdown():

            count += 1
            if count == 50:
                self.handle_run(None)

            tf_found = False

            try:
                (trans, rotQ) = listener.lookupTransform('/base_footprint', '/odom', rospy.Time(0))
                rotE = tf.transformations.euler_from_quaternion(rotQ)

                #print trans, rotQ

            except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
                # output error only if the tf was previously found and is now lost.
                if tf_found:
                    rospy.logerr("Error looking up tf")

            rate.sleep()

    @staticmethod
    def handle_run(msg):
        global undo_cmd_vel
        undo_cmd_vel = True

        print 'inb4'

        return True

    def publish_smart_cmd_vel(self, event):
        global undo_cmd_vel

        if undo_cmd_vel:
            try:
                twist = self.undo_stack.pop()
                #assert isinstance(twist, Twist)

                twist.linear.x *= -1.0
                twist.linear.y *= -1.0
                twist.linear.z *= -1.0

                twist.angular.x *= -1.0
                twist.angular.y *= -1.0
                twist.angular.z *= -1.0

                self.smart_cmd_vel_publisher.publish(twist)
            except IndexError:
                undo_cmd_vel = False
        else:
            self.undo_stack.append(self.requested_vel)
            self.smart_cmd_vel_publisher.publish(self.requested_vel)
            print '(', self.requested_vel.linear.x, self.requested_vel.linear.y, self.requested_vel.linear.z, ') (', \
                self.requested_vel.angular.x, self.requested_vel.angular.y, self.requested_vel.angular.z, ')'


    def cmd_vel_callback(self, msg):
        self.requested_vel = msg
        self.requested_vel_time = rospy.get_time()
        self.publish_smart_cmd_vel(None)

    def local_path_callback(self, msg):
        """
        1( 0.0 0.0 0.0 ) ( 0.0 0.0 0.0 )

        ( 0.0 0.0 0.0 ) ( 0.0 0.0 0.0 )
        1
        ( 0.0 0.0 0.0 ) ( 0.0 0.0 0.0 )
        1
        1

        :param msg:
        :return:
        """

        assert isinstance(msg, Path)
        print len(msg.poses)

if __name__ == "__main__":
    try:
        s = JuvavRecoveryNode()
    except rospy.ROSInterruptException:
        pass
