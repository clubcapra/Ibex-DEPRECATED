import roslib
roslib.load_manifest('animatics_smart_motor')
import rospy
from includes.motor_controller import MotorController
import random
from includes.commands import *

rospy.init_node('animatics_smart_motor')

motor_controller = MotorController()
motor_controller.initialize()

while not rospy.is_shutdown():
    rospy.sleep(1)
    motor_controller.send_command(ReportActualPosition())

