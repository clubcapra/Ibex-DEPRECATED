#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class Qualif2(StateAi):

    def __init__(self):
         super(Qualif2, self).__init__("qualif2")

    def on_start(self):
        pass

    def on_goal_changed(self, goal_msg):
        pass

    def on_last_goal_reached(self, msg):
        pass


if __name__ == "__main__":
    try:
        a = Qualif2()
    except rospy.ROSInterruptException:
        pass