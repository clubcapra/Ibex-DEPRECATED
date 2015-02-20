#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist, Pose2D
from nav_msgs.msg import Odometry
from capra_motor_calibrator.srv import *


# use in straight hallway with a lot of detail
def calibrate_service(req):
    #  TODO: Change robot width from hardcoded value once URDF is in place
    rospy.logwarn("Change robot width from hardcoded value once URDF is in place")
    robot_width = 0.54
    robot_speed = 0.5  # speed in m/s
    calibration_distance = req.calibration_distance
    rospy.loginfo("calibrating motors for a distance of %i m." % calibration_distance)

    rospy.Subscriber("/odom", Odometry, odom_handler, calibration_distance)
    rospy.Subscriber("/pose2D", Pose2D, pose_handler)
    cmd_vel_publisher = rospy.Publisher("/cmd_vel", Twist, queue_size=10)

    # keep publishing so the robot goes forward
    while not calibration_done:
        start = Twist()
        start.linear.x = robot_speed
        cmd_vel_publisher.publish(start)
        rospy.sleep(0.1)  # no need to spam the message

    # stop the robot
    stop = Twist()
    stop.linear.x = 0
    cmd_vel_publisher.publish(stop)

    # deviation is in rad/m
    average_deviation = last_msg.theta / total_distance
    ang_vel_corr = -average_deviation  # might not even be needed

    # adjust motor ratios so they get the right distance
    left_distance = total_distance - (last_msg.theta * robot_width) / 2
    right_distance = 2 * total_distance - left_distance
    left_corr = total_distance / left_distance
    right_corr = total_distance / right_distance

    rospy.loginfo("deviation of %i rad/m" % average_deviation)
    rospy.loginfo("left motor travelled %i m and correction correction is %i" % (left_distance, left_corr))
    rospy.loginfo("right motor travelled %i m and correction correction is %i" % (right_distance, right_corr))


# check if calibration is done
def odom_handler(msg, callback_args):
    rospy.logdebug(msg)
    calibration_distance = callback_args
    if msg.pose.pose.position.x >= calibration_distance:
        global calibration_done
        calibration_done = True


# get total distance robot has travelled
def pose_handler(msg):
    rospy.logdebug(msg)
    global last_msg, total_distance
    distance_delta = ((msg.x - last_msg.x) ** 2 + (msg.y - last_msg.y) ** 2) ** 0.5
    total_distance += distance_delta
    last_msg = msg


class MotorCalibrator:
    def __init__(self):
        rospy.loginfo("starting calibration")
        rospy.init_node("capra_motor_calibrator")
        rospy.Service("~calibrate", CalibrateMotor, calibrate_service)
        rospy.spin()


calibration_done = False
total_distance = 0.0
last_msg = Pose2D()  # initialize at zero
if __name__ == "__main__":
    try:
        MotorCalibrator()
    except rospy.ROSInterruptException:
        pass