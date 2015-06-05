#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class IGVCBasicSouth(StateAi):

    def __init__(self):
         super(IGVCBasicSouth, self).__init__("igvc_basic_south")

    def on_start(self):
        self.generate_circle(7.0, pi/4, 2 * pi - pi/4, pi/270.0, -1)

    def on_goal_changed(self, goal_msg):
        rospy.loginfo(goal_msg.priority)

    def on_last_goal_reached(self, msg):
        pass

if __name__ == "__main__":
    try:
        a = IGVCBasicSouth()
    except rospy.ROSInterruptException:
        pass