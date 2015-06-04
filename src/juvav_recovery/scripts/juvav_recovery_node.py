#! /usr/bin/env python


import rospy
from sensor_msgs.msg import Image, PointCloud2
import sensor_msgs.point_cloud2 as pc2
from geometry_msgs.msg import Twist, Vector3
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


class Position(object):
    def __init__(self, trans, yaw):
        self.trans = trans
        self.yaw = yaw


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

        count = 0

        rate = rospy.Rate(20)  # 4Hz
        while not rospy.is_shutdown():
            current_time = rospy.get_time()

            try:

                if count == 200:
                    #count = 0
                    undo_cmd_vel = True
                    print 'JUVAV!!'
                count += 1

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

                #for i in xrange(len(self.undo_stack)):
                #    print self.undo_stack[i]



                precision_x = 0.14#0.08
                precision_y = 0.1
                precision_yaw = 0.05#0.001

                twist_found = False

                new_trans_x = 0.0
                new_yaw = 0.0
                while not twist_found:

                    ((current_trans_x, current_trans_y, trans_z), rotQ) = self.tf_listener.lookupTransform('/base_footprint', '/odom', rospy.Time(0))
                    current_yaw = tf.transformations.euler_from_quaternion(rotQ)[2]


                    (target_trans_x, target_trans_y, target_yaw) = self.undo_stack[-1]

                    #if -precision_x <= current_trans_x - target_trans_x <= precision_x \
                    #        and -precision_yaw <= current_trans_x - target_yaw <= precision_yaw:
                    #    self.undo_stack.pop()
                    #    print 'ENDED'
                    #else:
                    #    twist_found = True

                    if abs(current_yaw - target_yaw) > precision_yaw:
                        new_yaw = (current_yaw - target_yaw) * 7.0
                        twist_found = True
                    else:
                        if abs(current_trans_x - target_trans_x) > precision_x:
                            new_trans_x = (current_trans_x - target_trans_x) * 6.0
                            twist_found = True
                        else:
                            self.undo_stack.pop()
                            #twist_found = True
                            print 'ENDED'

                    #if abs(new_yaw) < 0.05:
                    #    new_yaw = copysign(0.05, new_yaw)


                    #new_yaw = current_yaw - target_yaw
                    #if -precision_yaw <= new_yaw <= precision_yaw:
                    #    new_yaw = 0.0
                    #    new_trans_x = current_trans_x - target_trans_x
                    #    if abs(new_trans_x) < 0.6:
                    #        new_trans_x = copysign(0.6, new_trans_x)
                    #else:
                    #    if abs(new_yaw) < 0.1:
                    #            new_yaw = copysign(0.1, new_yaw)



                #if new_trans_x >= new_trans_y:
                #    factor = new_trans_x / 0.4
                #else:
                #    factor = new_trans_y / 0.4

                #new_trans_x *= factor
                #new_trans_y *= factor

                twist = Twist(
                    linear=Vector3(x=new_trans_x, y=0.0, z=0.0),
                    angular=Vector3(x=0.0, y=0.0, z=new_yaw))

                #print '({}, {}, {})'.format(trans_x, trans_y, yaw)


                self.smart_cmd_vel_publisher.publish(twist)
                print '({}, {}, {})'.format(current_trans_x, current_trans_y, current_yaw)
                print '({}, {}, {})'.format(target_trans_x, target_trans_y, target_yaw)
                print '({}, {}, {})'.format(twist.linear.x, twist.linear.y, twist.angular.z)
                print 'publishing undo cmd_vel msg on /smart_cmd_vel'


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
            try:
                ((trans_x, trans_y, trans_z), rotQ) = self.tf_listener.lookupTransform('/base_footprint', '/odom', rospy.Time(0))
                yaw = tf.transformations.euler_from_quaternion(rotQ)[2]


                self.undo_stack.append((trans_x, trans_y, yaw))
                self.smart_cmd_vel_publisher.publish(self.requested_vel)




                self.local_path_analyzer.last_cmd_vel_values.append(self.requested_vel)
                self.local_path_analyzer.last_cmd_vel_time.append(rospy.get_time())
                #print '.'



                (last_trans_x, last_trans_y, last_yaw) = self.undo_stack[1]



                print '({}, {}, {})'.format(trans_x, trans_y, yaw)
                print '({}, {}, {})'.format(trans_x - last_trans_x, trans_y - last_trans_y, yaw - last_yaw)
                print '(({}, {}, {}) ({}, {}, {}))'.format(
                    self.requested_vel.linear.x, self.requested_vel.linear.y, self.requested_vel.linear.z,
                    self.requested_vel.angular.x, self.requested_vel.angular.y, self.requested_vel.angular.z)
            except IndexError:
                pass

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



"""


"""


"""

(trans_x, trans_y, yaw)
(lin_x, lin_y, lin_z) (ang_x, ang_y, ang_z)


(-22.5, 40.0, 0.0)
((0.1, 0.0, 0.0) (0.0, 0.0, 0.0))

(-22.5, 40.0, 0.0)
((0.1, 0.0, 0.0) (0.0, 0.0, 0.0))

(-22.5102, 40.0, 0.0)
((0.1, 0.0, 0.0) (0.0, 0.0, 0.0))

(-22.5102, 40.0, 0.0)
((0.131578947761, 0.0, 0.0) (0.0, 0.0, 0.328421052632))

(-22.4366247473, 40.0443011545, -0.00197052630128)
((0.126045207224, 0.0, 0.0) (0.0, 0.0, 0.266006193255))

(-21.2332658587, 40.702385129, -0.0320990710925)
((0.171635558041, 0.0, 0.0) (0.0, 0.0, 0.653170641598))

(-21.2332658587, 40.702385129, -0.0320990710925)
((0.163676051592, 0.0, 0.0) (0.0, 0.0, 0.653170641598))

(-18.6069548211, 41.9763946566, -0.0960123232951)
((0.225924684217, 0.0, 0.0) (0.0, 0.0, 0.72634615208))

(-17.0816746966, 42.6246483027, -0.132324220503)
((0.21594361644, 0.0, 0.0) (0.0, 0.0, 0.678433803132))

(-15.6017559516, 43.1926970395, -0.167068080292)
((0.272121228293, 0.0, 0.0) (0.0, 0.0, 0.787787399919))

(-13.8823368188, 43.7804815874, -0.206917174914)
((0.296709975192, 0.0, 0.0) (0.0, 0.0, 0.636208452551))

(-12.3016472692, 44.2551447431, -0.243153278328)
((0.350752635881, 0.0, 0.0) (0.0, 0.0, 0.655039174306))

(-10.8722609715, 44.631992941, -0.275656400645)
((0.379256305883, 0.0, 0.0) (0.0, 0.0, 0.0))

(-9.8545054718, 44.8762415723, -0.299237810139)
((0.407139223312, 0.0, 0.0) (0.0, 0.0, 0.0))

(-9.8747119139, 44.8762415725, -0.299237810139)
((0.461361571237, 0.0, 0.0) (0.0, 0.0, 0.176842105263))

(-9.74566648151, 44.9092471802, -0.302597810179)
((0.478310002967, 0.0, 0.0) (0.0, 0.0, 0.0757894736842))

"""

"""
(0.0, 0.0, 0.0)
((0.1, 0.0, 0.0) (0.0, 0.0, 0.0))

(0.0, 0.0, 0.0)
((0.1, 0.0, 0.0) (0.0, 0.0, 0.0))

(0.0102, 0.0, 0.0)
((0.145696595797, 0.0, 0.0) (0.0, 0.0, 0.429473684211))

(-0.77717326605, -0.437148398642, 0.0197557891943)
((0.125263158208, 0.0, 0.0) (0.0, 0.0, 0.378947368421))

(-1.59717794708, -0.870805152925, 0.0400926310761)
((0.167866120087, 0.0, 0.0) (0.0, 0.0, 0.564210545891))

(-2.75024981739, -1.44471621223, 0.0683115787134)
((0.16452275753, 0.0, 0.0) (0.0, 0.0, 0.52507738973))

[ WARN] [/move_base] [1433094397.317602629, 3627.277000000]: Map update loop missed its desired rate of 10.0000Hz... the loop actually took 0.1130 seconds
(-3.88487993528, -1.97072173465, 0.0957166555119)
((0.156457412839, 0.0, 0.0) (0.0, 0.0, 0.47455107394))
[ WARN] [/move_base] [1433094397.424562237, 3627.343000000]: Control loop missed its desired rate of 20.0000Hz... the loop actually took 0.0570 seconds
(-4.9087106985, -2.41370022787, 0.120171391483)
((0.217161066407, 0.0, 0.0) (0.0, 0.0, 0.714196514958))
(-6.20810460098, -2.93369669637, 0.150843922241)
((0.211913103304, 0.0, 0.0) (0.0, 0.0, 0.706873036121))
(-7.75878476812, -3.49475525561, 0.186975003905)
((0.19326091942, 0.0, 0.0) (0.0, 0.0, 0.706873036121))
[ WARN] [/move_base] [1433094397.602971399, 3627.438000000]: Control loop missed its desired rate of 20.0000Hz... the loop actually took 0.0520 seconds
[ WARN] [/move_base] [1433094397.728284941, 3627.519000000]: Control loop missed its desired rate of 20.0000Hz... the loop actually took 0.0830 seconds
(-9.32596069382, -3.99835867725, 0.223025527375)
((0.264610040972, 0.0, 0.0) (0.0, 0.0, 0.727737920535))
[ WARN] [/move_base] [1433094397.829697500, 3627.573000000]: Control loop missed its desired rate of 20.0000Hz... the loop actually took 0.0870 seconds
(-10.916485376, -4.44683746946, 0.259222105082)
((0.248833033788, 0.0, 0.0) (0.0, 0.0, 0.681609960983))
[ WARN] [/move_base] [1433094397.832576361, 3627.574000000]: Map update loop missed its desired rate of 10.0000Hz... the loop actually took 0.1100 seconds
(-14.1039308845, -5.16406419027, 0.330914332602)
((0.275997794616, 0.0, 0.0) (0.0, 0.0, 0.98763120325))
[ WARN] [/move_base] [1433094397.986110276, 3627.671000000]: Control loop missed its desired rate of 20.0000Hz... the loop actually took 0.1350 seconds
(-15.8880864381, -5.46211991337, 0.370572778396)
((0.343444717715, 0.0, 0.0) (0.0, 0.0, 0.0))

"""
