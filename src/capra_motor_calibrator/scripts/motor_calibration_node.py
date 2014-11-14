#!/usr/bin/env python

import rospy
from capra_motor_calibrator.srv import *
from geometry_msgs.msg import Twist, PoseStamped
from nav_msgs.msg import Odometry
from tf.transformations import euler_from_quaternion


# use in straight hallway with a lot of detail
def calibrate_service(req):
    print "uyytrrwe"
    calibration_distance = req.calibration_distance
    rospy.logdebug("calibrating motors for a distance of %i m." % calibration_distance)

    rospy.Subscriber("/odom", Odometry, odom_handler, calibration_distance)

    # does the subscriber run in parallel with the main function?
    start = Twist()
    start.linear.x = 0.5
    cmd_vel_publisher.publish(start)

    # wait until the calibration is finished
    while not calibration_done and not rospy.is_shutdown():
        rospy.sleep(0.1)  # value needs to be small so the calibration is as accurate as possible

    stop = Twist()
    stop.linear.x = 0
    cmd_vel_publisher.publish(stop)

    #  TODO: Change robot width from hardcoded value once URDF is in place
    import warnings
    warnings.warn("Change robot width from hardcoded value once URDF is in place")
    robot_width = 0.6096

    quaternion_position = rospy.wait_for_message("/slam_out_pose", PoseStamped, 10)
    actual_position = euler_from_quaternion(quaternion_position)
    print actual_position
    lvalue = actual_position.x - (actual_position.z * robot_width) / 2
    rvalue = actual_position.z * robot_width + lvalue
    correction_values = [lvalue, rvalue]
    return correction_values


def odom_handler(msg, callback_args):
    rospy.logdebug(msg)
    calibration_distance = callback_args
    if msg.pose.position.x >= calibration_distance:
        global calibration_done
        calibration_done = True


print "hjfgfhg"
calibration_done = False
rospy.init_node("capra_motor_calibrator")
cmd_vel_publisher = rospy.Publisher("/cmd_vel", Twist, queue_size=10)
rospy.Service("~calibrate", Calibrate, calibrate_service)
rospy.spin()
