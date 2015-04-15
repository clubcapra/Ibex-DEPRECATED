#! /usr/bin/env python
# coding=utf-8

import rospy
from ai_util import *

class StateAi:

    def __init__(self):
        rospy.init_node("state_ai")

        self.test_node()

        rospy.spin()

    def test_node(self):
        set_robot_speed(2.0)

if __name__ == "__main__":
    try:
        a = StateAi()
    except rospy.ROSInterruptException:
        pass
