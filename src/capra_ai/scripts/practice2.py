#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class Practice2(StateAi):

    def __init__(self):
         super(Practice2, self).__init__("practice2")

    def on_start(self):
        #self.generate_circle(2.0, pi/4, 2 * pi - pi/4, pi/270.0, 30)
        pass

    def on_goal_changed(self, goal_msg):
       rospy.loginfo("Targeting goal with priority: {}".format(goal_msg.priority))



       if goal_msg.priority == 103: ## First GOAL
           self.clear_octomap(self.start_pos, 10, 10)

       if goal_msg.priority == 404: ## MiddlePoint
           pass

       if goal_msg.priority == 105: ## Last GOAL
           pass

       if goal_msg.priority == 406:
           self.generate_bar(8, -2.0, -1)



    def on_last_goal_reached(self, msg):
        pass


if __name__ == "__main__":
    try:
        a = Practice2()
    except rospy.ROSInterruptException:
        pass