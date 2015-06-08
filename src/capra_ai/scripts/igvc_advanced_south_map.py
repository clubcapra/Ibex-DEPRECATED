#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool

class IGVCAdvancedSouthMap(StateAi):

    def __init__(self):
         super(IGVCAdvancedSouthMap, self).__init__("igvc_advanced_south_map")

    def on_start(self):
        #self.generate_circle(2.0, pi/4, 2 * pi - pi/4, pi/270.0, 120)
        pass

    def on_goal_changed(self, goal_msg):
        rospy.loginfo("Targeting goal with priority: {}".format(goal_msg.priority))

        if goal_msg.priority == 122:
            self.set_max_vel_x(1.05)

        if goal_msg.priority == 501:
            self.set_max_vel_x(0.85)
            self.generate_bar(5, -2.0, -1)






    def on_last_goal_reached(self, msg):
        rospy.loginfo("WE FINISHED THE ADVANCED COURSE !!! CONGRATS EVERYONE !!!")
        pass

if __name__ == "__main__":
    try:
        a = IGVCAdvancedSouthMap()
    except rospy.ROSInterruptException:
        pass