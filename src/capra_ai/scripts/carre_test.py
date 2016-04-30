#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class IGVCBasicNorth(StateAi):

    def __init__(self):
         super(IGVCBasicNorth, self).__init__("igvc_basic_north")

    def on_start(self):
        pass

    def on_goal_changed(self, goal_msg):
        rospy.loginfo("Targeting goal with priority: {}".format(goal_msg.priority))

        if goal_msg.priority == 101: ## First GOAL
            self.set_max_vel_x(0.2)

        if goal_msg.priority == 102: ## First GOAL
            self.set_max_vel_x(0.95)

        if goal_msg.priority == 103: ## First GOAL
            self.set_max_vel_x(0.2)

        if goal_msg.priority == 104: ## First GOAL
            self.set_max_vel_x(0.7)

    def on_last_goal_reached(self, msg):
        pass

if __name__ == "__main__":
    try:
        a = IGVCBasicNorth()
    except rospy.ROSInterruptException:
        pass