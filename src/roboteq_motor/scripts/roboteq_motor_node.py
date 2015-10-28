#!/usr/bin/env python

import roslib
roslib.load_manifest('roboteq_motor')
import rospy
from roboteq_msgs.msg import Feedback, Command, Status

import math

class RoboteqMotor:
    def __init__(self):
        rospy.init_node("roboteq_motor")
        rospy.Subscriber("/roboteq_driver/feedback", Feedback, self.feedback_report)
        rospy.Subscriber("/roboteq_driver/status", Status, self.status_report)
        self.commander = rospy.Publisher("/roboteq_driver/cmd", Command, queue_size=10)

        while True:
            self.run()
            rospy.sleep(10)


    def run(self):
        motorCommand = Command()
        motorCommand.setpoint = 100.0
        motorCommand.mode = Command.MODE_VELOCITY
        self.commander.publish(motorCommand)



    def status_report(self, status):

        rospy.loginfo("Reporting status, fault {} status {}".format(status.fault, status.status))

    def feedback_report(self, feedback):

        rospy.loginfo("Reporting feedback {}".format(feedback.motor_current))



if __name__ == "__main__":
    try:
        motor = RoboteqMotor()
    except rospy.ROSInterruptException:
        rospy.logerr('RoboteqMotor: Core interruption')



