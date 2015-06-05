#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class Qualif1(StateAi):

    def __init__(self):
         super(Qualif1, self).__init__("qualif1")

    def on_start(self):
        self.generate_circle(1.8, pi/4, 2 * pi - pi/4, pi/270.0, -1)

    def on_goal_changed(self, goal_msg):
        pass

    def on_last_goal_reached(self, msg):
        pass


if __name__ == "__main__":
    try:
        a = Qualif1()
    except rospy.ROSInterruptException:
        pass