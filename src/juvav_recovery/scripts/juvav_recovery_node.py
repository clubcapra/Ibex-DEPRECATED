#! /usr/bin/env python


import rospy
from sensor_msgs.msg import Image, PointCloud2
import sensor_msgs.point_cloud2 as pc2
from geometry_msgs.msg import Twist
from nav_msgs.msg import Path, Odometry

import tf
from cv_bridge import CvBridge
from math import *
from juvav_recovery.srv import *

from numpy import array
from numpy.linalg import inv

from collections import deque
import copy

undo_cmd_vel = False
undo_cmd_vel_time = 0.0




class BehaviorAnalyzer:

    INVALID_CMD_VALUE = ((), ())

    def __init__(self):
        self.last_cmd_vel_values = deque((Twist(),), 20)
        self.last_cmd_vel_values.pop()

        self.last_tf_values = deque(((tuple(), tuple(), tuple()),), 10)
        self.last_tf_values.pop()

        self.last_local_path_values = deque((Path(),), 10)
        self.last_local_path_values.pop()

        self.last_cmd_vel_time = deque((float(),), 10)
        self.last_cmd_vel_time.pop()

        self.last_tf_time = deque((float(),), 10)
        self.last_tf_time.pop()

        self.last_local_path_time = deque((float(),), 10)
        self.last_local_path_time.pop()

    def is_undo_needed(self):
        global undo_cmd_vel
        current_time = rospy.get_time()
        try:
            #((trans_x, trans_y, trans_z), (rot_quat_x, rot_quat_y, rot_quat_), ()) = self.last_tf_values[0]



            """

            reculer pendant au moins 2 secondes
            """

            if len(self.last_local_path_values[0].poses) < 5:
                return True

            if current_time - self.last_cmd_vel_time[0] > 3.0:
                return True

            if current_time - self.last_local_path_time[0] > 3.0:
                nb_invalid_cmd_vel = True



                last_twist_msgs = [self.last_cmd_vel_values[i] for i in xrange(3)]
                for lin_x, lin_y, lin_z, ang_x, ang_y, ang_z in [(twist.linear.x, twist.linear.y, twist.linear.z,
                                                                  twist.angular.x, twist.angular.y, twist.angular.z)
                                                                 for twist in copy.deepcopy(last_twist_msgs)]:
                    if ((lin_x, lin_y, lin_z), (ang_x, ang_y, ang_z)) == ((0.0, 0.0, 0.0), (0.0, 0.0, 0.0)):
                        nb_invalid_cmd_vel += 1

                if nb_invalid_cmd_vel > 3:
                    return True

            #if current_time - self.last_cmd_vel_time[0] > 0.5:
           #     return True

           # if undo_cmd_vel:

            #    if len(self.last_local_path_values[0].poses) > 5:
           #         return False

           #     if current_time - self.last_cmd_vel_time[0] > 0.5:
           #         return False

           # else:

                #nb_invalid_cmd_vel = 0
                #last_twist_msgs = [self.last_cmd_vel_values[i] for i in xrange(3)]
                #for lin_x, lin_y, lin_z, ang_x, ang_y, ang_z in [(twist.linear.x, twist.linear.y, twist.linear.z,
                #                                                 twist.angular.x, twist.angular.y, twist.angular.z)
                #                                                 for twist in last_twist_msgs]:
                #    if ((lin_x, lin_y, lin_z), (ang_x, ang_y, ang_z)) == ((0.0, 0.0, 0.0), (0.0, 0.0, 0.0)):
                 #       nb_invalid_cmd_vel += 1

                #if nb_invalid_cmd_vel < 3:
                #    #print 'Warning: {} invalid twist cmd_vel in a row since good behavior'.format(nb_invalid_cmd_vel)
                #    return False




            #last_local_paths = [ for i in xrange(1)]
            #nb_valid_local_paths = 0
            #for local_path in last_local_paths:
            #    if len(local_path) > 5:
            #        nb_valid_local_paths += 1


            #if nb_valid_local_paths > 0:
            #    return False

            #print current_time - self.last_cmd_vel_time[0], current_time - self.last_tf_time[0], \
            #    current_time - self.last_local_path_time[0]

            #nb_invalid_elapsed_time = 0
            #cmd_vel_elapsed_times = [current_time - last_time for last_time in
            #                         [self.last_cmd_vel_time[i] for i in xrange(8)]]
            #for elapsed_time in cmd_vel_elapsed_times:
            #    if elapsed_time > 1.5:
            #        nb_invalid_elapsed_time += 1

            #if nb_invalid_elapsed_time > 0:
                #print 'Warning: {} invalid cmd_vel elapsed time since good behavior'.format(nb_invalid_elapsed_time)
                #return True
            #    pass

            return False
        except IndexError:
            pass


class JuvavRecoveryNode:

    def __init__(self):
        self.undo_stack = deque((Odometry,), 100)
        self.undo_stack.pop()
        self.requested_vel = None
        self.requested_vel_time = 0

        self.local_path_analyzer = BehaviorAnalyzer()

        rospy.init_node('juvav_recovery_node', log_level=rospy.INFO)
        s_run = rospy.Service('juvav_recovery_node/run', Run, self.handle_run)

        self.smart_cmd_vel_publisher = rospy.Publisher('/smart_cmd_vel', Twist, queue_size=10)
        rospy.Subscriber('/cmd_vel', Twist, self.cmd_vel_callback)
        rospy.Subscriber('/move_base/TrajectoryPlannerROS/local_plan', Path, self.local_path_callback)
        rospy.Subscriber('/odom', Odometry, self.odom_callback)


        self.tf_listener = tf.TransformListener()

        global undo_cmd_vel
        last_time = rospy.get_time()

        rate = rospy.Rate(20)  # 4Hz
        while not rospy.is_shutdown():
            current_time = rospy.get_time()

            try:

                if current_time - last_time > 5.0:
                    undo_cmd_vel = True
                    last_time = current_time


                #print id(self.local_path_analyzer.last_cmd_vel_values)
                #print id(copy.deepcopy(self.local_path_analyzer.last_cmd_vel_values))
                """
                if current_time - self.local_path_analyzer.last_cmd_vel_time[0] > 3.0:
                    undo_cmd_vel = self.local_path_analyzer.is_undo_needed()
                    self.publish_smart_cmd_vel(None)

                invalid_cmd_vel_stack = True
                for lin_x, lin_y, lin_z, ang_x, ang_y, ang_z in [
                    (twist.linear.x, twist.linear.y, twist.linear.z, twist.angular.x, twist.angular.y, twist.angular.z)
                        for twist in copy.deepcopy(self.local_path_analyzer.last_cmd_vel_values)]:

                    if ((lin_x, lin_y, lin_z), (ang_x, ang_y, ang_z)) != ((0.0, 0.0, 0.0), (0.0, 0.0, 0.0)):
                        invalid_cmd_vel_stack = False

                if invalid_cmd_vel_stack:
                    undo_cmd_vel = self.local_path_analyzer.is_undo_needed()
                    self.publish_smart_cmd_vel(None)
                """
            except IndexError:
                pass




            #is_undo_needed = self.local_path_analyzer.is_undo_needed()
            #if is_undo_needed != undo_cmd_vel:
            #    undo_cmd_vel = is_undo_needed

            #if is_undo_needed and rospy.get_time() - self.local_path_analyzer.last_cmd_vel_time[0] > 0.2:
            #    self.publish_smart_cmd_vel(None)

            rate.sleep()

    @staticmethod
    def handle_run(msg):
        global undo_cmd_vel
        undo_cmd_vel = True
        return True

    def publish_smart_cmd_vel(self, event):
        global undo_cmd_vel, undo_cmd_vel_time
        current_time = rospy.get_time()

        #undo_cmd_vel = self.local_path_analyzer.is_undo_needed()
        if undo_cmd_vel:
            try:

                ((trans_x, trans_y, trans_z), (rot_quat_x, rot_quat_y, rot_quat_z, rot_quat_w),
                 (rot_eul_x, rot_eul_y, rot_eul_z)) = self.undo_stack.pop()

                print '({}, {}, {}) ({}, {}, {})'.format(
                    trans_x, trans_y, trans_z, rot_eul_x, rot_eul_y, rot_eul_z)



                """
                if undo_cmd_vel_time == 0.0:
                    undo_cmd_vel_time = rospy.get_time()

                twist = self.undo_stack.pop()
                #assert isinstance(twist, Twist)

                twist.linear.x *= -1.0
                twist.linear.y *= -1.0
                twist.linear.z *= -1.0

                twist.angular.x *= -1.0
                twist.angular.y *= -1.0
                twist.angular.z *= -1.0

                self.smart_cmd_vel_publisher.publish(twist)
                print 'publishing undo cmd_vel msg on /smart_cmd_vel'

                if current_time - undo_cmd_vel_time > 1.0:
                    undo_cmd_vel = False
                    undo_cmd_vel_time = 0.0
                    print 'undo behavior was ended after 1 second'
                else:
                    print '|', current_time - undo_cmd_vel_time, '|'
                """
            except IndexError:
                undo_cmd_vel = False
                #undo_cmd_vel_time = 0.0
        else:
            (trans, rotQ) = self.tf_listener.lookupTransform('/base_footprint', '/odom', rospy.Time(0))
            rotE = tf.transformations.euler_from_quaternion(rotQ)


            self.undo_stack.append((trans, rotQ, rotE))
            self.smart_cmd_vel_publisher.publish(self.requested_vel)




            self.local_path_analyzer.last_cmd_vel_values.append(self.requested_vel)
            self.local_path_analyzer.last_cmd_vel_time.append(rospy.get_time())
            print '.'

            #print '(({}, {}, {}) ({}, {}, {}))'.format(self.requested_vel.linear.x, self.requested_vel.linear.y, self.requested_vel.linear.z,
            #                                           self.requested_vel.angular.x, self.requested_vel.angular.y, self.requested_vel.angular.z)

    def cmd_vel_callback(self, msg):
        self.requested_vel = msg
        self.requested_vel_time = rospy.get_time()
        self.publish_smart_cmd_vel(None)

    def odom_callback(self, msg):
        type(msg)

    def local_path_callback(self, msg):
        """
        :param msg:
        :return:
        """

        global undo_cmd_vel

        (trans, rotQ) = self.tf_listener.lookupTransform('/base_footprint', '/odom', rospy.Time(0))
        rotE = tf.transformations.euler_from_quaternion(rotQ)

        self.local_path_analyzer.last_tf_values.append((trans, rotQ, rotE))
        self.local_path_analyzer.last_tf_time.append(rospy.get_time())

        self.local_path_analyzer.last_local_path_values.append(msg)
        self.local_path_analyzer.last_local_path_time.append(rospy.get_time())

if __name__ == "__main__":
    try:
        s = JuvavRecoveryNode()
    except rospy.ROSInterruptException:
        pass
