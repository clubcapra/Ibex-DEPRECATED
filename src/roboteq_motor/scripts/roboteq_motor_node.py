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



        rospy.Subscriber("roboteq_driver/front/left", Feedback, self.feedback_report_right)
        rospy.Subscriber("/right/feedback", Status, self.feedback_report_left)


        rospy.Timer(rospy.Duration.from_sec(50.0/1000), self.velocity_timer)
        rospy.Timer(rospy.Duration.from_sec(1.0/1000), self.publish_odom)






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

if __name__ == "__main__":
    try:
        motor = RoboteqMotorController()
    except rospy.ROSInterruptException:
        pass



