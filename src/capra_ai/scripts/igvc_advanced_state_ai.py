#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class IGVCAdvancedStateAI(StateAi):

    def __init__(self):
         super(IGVCAdvancedStateAI, self).__init__("igvc_advanced_state_ai")

    def on_start(self):
        self.generate_circle(7.0, pi/4, 2 * pi - pi/4, pi/270.0, 20)

    def on_goal_changed(self, goal_msg):
        rospy.loginfo(goal_msg.priority)
        if self.goal_count == 2:
            self.clear_octomap(self.start_pos, 10, 10)

        if self.goal_count == 4:
            self.generate_bar(8, -1.0, -1)

    def on_last_goal_reached(self, msg):
        pass


if __name__ == "__main__":
    try:
        a = IGVCAdvancedStateAI()
    except rospy.ROSInterruptException:
        pass