#!/usr/bin/env python

import roslib
roslib.load_manifest('roboteq_motor_controller')
import rospy
from roboteq_msgs.msg import Feedback, Command, Status
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from motor import Motor

import math

class RoboteqMotorController:
    def __init__(self):
        rospy.init_node("roboteq_motor_controller")

        self.requested_vel = None
        self.requested_vel_time = 0

        rospy.Subscriber("/cmd_vel", Twist, self.cmd_vel_callback)

        self.front_left_motor = Motor(rospy.Publisher("roboteq_driver/front/left", Command, queue_size=10))
        self.front_right_motor = Motor(rospy.Publisher("roboteq_driver/front/right", Command, queue_size=10))
        self.rear_left_motor = Motor(rospy.Publisher("roboteq_driver/rear/left", Command, queue_size=10))
        self.rear_right_motor = Motor(rospy.Publisher("roboteq_driver/rear/right", Command, queue_size=10))
        self.swivel = None

        rospy.Subscriber("roboteq_driver/front/left", Feedback, self.front_left_motor._feedback_callback())
        rospy.Subscriber("roboteq_driver/front/right" ,Feedback, self.front_right_motor._feedback_callback())
        rospy.Subscriber("roboteq_driver/rear/left", Feedback, self.rear_left_motor._feedback_callback())
        rospy.Subscriber("roboteq_driver/rear/right", Feedback, self.rear_right_motor._feedback_callback())

        rospy.Subscriber("roboteq_driver/front/left", Status, self.front_left_motor._status_callback())
        rospy.Subscriber("roboteq_driver/front/right", Status, self.front_right_motor._status_callback())
        rospy.Subscriber("roboteq_driver/rear/left", Status, self.rear_left_motor._status_callback())
        rospy.Subscriber("roboteq_driver/rear/right", Status, self.rear_right_motor._status_callback())

    def velocity_timer(self, event):
        self.front_left_motor.set_velocity(4)

        pass

    def cmd_vel_callback(self,msg):
        self.requested_vel = msg
        self.requested_vel_time = rospy.get_time()

    def publish_odom(self,event):
        pass

    def run(self):
        motorCommand = Command()
        motorCommand.setpoint = 100.0
        motorCommand.mode = Command.MODE_VELOCITY
        self.front_left.publish(motorCommand)
        self.front_right.publish(motorCommand)
        self.rear_left.publish(motorCommand)
        self.rear_right.publish(motorCommand)

    def get_motor_status(self):
        front_left_motor_status = self.front_left_motor.get_controller_status()
        front_right_motor_status = self.front_right_motor.get_controller_status()
        rear_left_motor_status = self.rear_left_motor.get_controller_status()
        rear_right_motor_status = self.rear_right_motor.get_controller_status()

        rospy.loginfo(front_left_motor_status)
        rospy.loginfo(front_right_motor_status)
        rospy.loginfo(rear_left_motor_status)
        rospy.loginfo(rear_right_motor_status)

if __name__ == "__main__":
    try:
        motor = RoboteqMotorController()
    except rospy.ROSInterruptException:
        pass

