#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class LavoieBasicStateAI(StateAi):

    def __init__(self):
         super(LavoieBasicStateAI, self).__init__("lavoie_basic_state_ai")

    def on_start(self):
        self.generate_circle(3.0, pi/4, 2 * pi - pi/4, pi/270.0, 20)

    def on_goal_changed(self, goal_msg):
        rospy.loginfo(goal_msg.priority)


    def on_last_goal_reached(self, msg):
        pass


if __name__ == "__main__":
    try:
        a = LavoieBasicStateAI()
    except rospy.ROSInterruptException:
        pass