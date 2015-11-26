#!/usr/bin/env python

import roslib
roslib.load_manifest('roboteq_motor')
import rospy
from roboteq_msgs.msg import Feedback, Command, Status

import math

class RoboteqMotor:
    def __init__(self):
        rospy.init_node("roboteq_motor")
        rospy.Subscriber("/left/feedback", Feedback, self.feedback_report_right)
        rospy.Subscriber("/right/feedback", Status, self.feedback_report_left)
        self.front_left = rospy.Publisher("/roboteq_driver/front/left", Command, queue_size=10)
        self.front_right = rospy.Publisher("roboteq_driver/front/right", Command, queue_size=10)
        self.rear_left = rospy.Publisher("roboteq_driver/rear/left", Command, queue_size=10)
        self.rear_right = rospy.Publisher("roboteq_driver/rear/right", Command, queue_size=10)


        while not rospy.is_shutdown():
            self.run()



    def run(self):
        motorCommand = Command()
        motorCommand.setpoint = 100.0
        motorCommand.mode = Command.MODE_VELOCITY
        self.front_left.publish(motorCommand)
        self.front_right.publish(motorCommand)
        self.rear_left.publish(motorCommand)
        self.rear_right.publish(motorCommand)




    def feedback_report_right(self, feedback):
        rospy.loginfo("RIGHT v,p {},{}".format(feedback.measured_velocity, feedback.measured_position))

    def feedback_report_left(self, feedback):
        rospy.loginfo("LEFT v,p {},{}".format(feedback.measured_velocity, feedback.measured_position))



if __name__ == "__main__":
    try:
        motor = RoboteqMotor()
    except rospy.ROSInterruptException:
        rospy.logerr('RoboteqMotor: Core interruption')



