#! /usr/bin/env python

import roslib
roslib.load_manifest('microstrain_3dmgx1_imu')
import rospy
from microstrain_3dmgx2_imu.srv import Calibrate
from geometry_msgs.msg import Twist
import time
from thread import start_new_thread

CALIBRATION_TIME = 36


def send_vel_commands():
    global calibrated
    global pub
    while not calibrated and not rospy.is_shutdown():
        t = Twist()
        t.angular.z = 0.3
        pub.publish(t)
        time.sleep(0.1)

rospy.init_node('microstrain_3dmgx1_calibrator', anonymous=True)
rospy.wait_for_service('/microstrain_3dmgx1_node/calibrate')
pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
calibrated = False

raw_input("The robot is going to turn on itself. Please make sure there is some space around it. <enter>:")

start_new_thread(send_vel_commands, ())

rospy.ServiceProxy('/microstrain_3dmgx1_node/calibrate', Calibrate)(True, 0, CALIBRATION_TIME)

print "Calibrated!"
