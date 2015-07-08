#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class ResPhase1(StateAi):

    def __init__(self):
         super(ResPhase1, self).__init__("res_phase_1")

    def on_start(self):
        self.generate_circle(2.0, pi/4, 2 * pi - pi/4, pi/270.0, 120)
        pass


    def on_goal_changed(self, goal_msg):
        rospy.loginfo("Targeting goal with priority: {}".format(goal_msg.priority))


    def on_last_goal_reached(self, msg):
        pass

if __name__ == "__main__":
    try:
        a = ResPhase1()
    except rospy.ROSInterruptException:
        pass