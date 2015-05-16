#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class IGVCBasicStateAI(StateAi):

    def __init__(self):
         super(IGVCBasicStateAI, self).__init__("igvc_basic_state_ai")

    def on_start(self):
        self.generate_circle(3.0, pi/4, 2 * pi - pi/4, pi/270.0)

    def on_goal_targeted(self, goal_msg):
        self.goal_count += 1
        rospy.loginfo("goal sent, count is now {}".format(self.goal_count))

        if self.goal_count == 2:
            self.clear_octomap(self.start_pos, 10, 10)

        if self.goal_count == 4:
            self.generate_bar(8, -1.0)

if __name__ == "__main__":
    try:
        a = IGVCBasicStateAI()
    except rospy.ROSInterruptException:
        pass