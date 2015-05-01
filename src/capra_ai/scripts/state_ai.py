#! /usr/bin/env python
# coding=utf-8

import rospy
from ai_util import *
from move_base_msgs.msg import MoveBaseActionGoal
from std_msgs.msg import Bool

class StateAi:

    def goal_callback(self, msg):
        self.goal_count += 1
        rospy.loginfo("goal sent, count is now {}".format(self.goal_count))

        if self.pause:
            rospy.sleep(2)
            set_robot_speed(1.8)
            self.pause = False

        if self.goal_count == 3:

            set_robot_speed(0.0)
            self.pub_generate(Bool(True))
            start_node("capra_2dnav", "obstacle_generator.py")
            self.pause = True


    def __init__(self):
        rospy.init_node("state_ai")

        rospy.Subscriber("/move_base/goal", MoveBaseActionGoal, self.goal_callback)
        self.pub_generate = rospy.Publisher("/obstacle_generator/generate_circle", Bool, queue_size=10)

        self.goal_count = 0
        self.pause = False

        rospy.spin()

        #def test_node(self):
        #    set_robot_speed(2.0)

if __name__ == "__main__":
    try:
        a = StateAi()
    except rospy.ROSInterruptException:
        pass
