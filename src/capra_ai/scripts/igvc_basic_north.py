#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class IGVCBasicNorth(StateAi):

    def __init__(self):
         super(IGVCBasicNorth, self).__init__("igvc_basic_north")

    def on_start(self):
        self.generate_circle(7.0, pi/4, 2 * pi - pi/4, pi/270.0, 20)

    def on_goal_changed(self, goal_msg):
        rospy.loginfo("Targeting goal with priority: {}", goal_msg.priority)
        if goal_msg.priority == 306:
            self.clear_octomap(self.start_pos, 10, 10)

        if goal_msg.priority == 103: ## First GOAL
            pass

        if goal_msg.priority == 304: ## MiddlePoint
            pass

        if goal_msg.priority == 105: ## Last GOAL
            pass

        if goal_msg.priority == 302:
            self.generate_bar(8, 2, -1)





    def on_last_goal_reached(self, msg):
        rospy.loginfo("WE FINISHED THE BASIC COURSE !!! CONGRATS EVERYONE !!!")
        pass

if __name__ == "__main__":
    try:
        a = IGVCBasicNorth()
    except rospy.ROSInterruptException:
        pass