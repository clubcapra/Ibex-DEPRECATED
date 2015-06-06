#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class Practice(StateAi):

    def __init__(self):
         super(Practice, self).__init__("practice")

    def on_start(self):
        self.generate_circle(1.8, pi/4, 2 * pi - pi/4, pi/270.0, -1)

    def on_goal_changed(self, goal_msg):
        pass

    def on_last_goal_reached(self, msg):
        pass


if __name__ == "__main__":
    try:
        a = Practice()
    except rospy.ROSInterruptException:
        pass