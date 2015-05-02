#! /usr/bin/env python
# coding=utf-8

import rospy
from ai_util import *
from move_base_msgs.msg import MoveBaseActionGoal
from std_msgs.msg import Bool
from octomap_msgs.srv import BoundingBoxQuery
from std_srvs.srv import Empty
from geometry_msgs.msg import Point
import tf

class StateAi:

    def __init__(self):
        rospy.init_node("state_ai")

        self.clear_octomap_service = rospy.ServiceProxy('/octomap_server/clear_bbx', BoundingBoxQuery)
        self.reset_octomap_service = rospy.ServiceProxy('/octomap_server/reset', Empty)
        rospy.Subscriber("/move_base/goal", MoveBaseActionGoal, self.goal_callback)
        self.pub_circle = rospy.Publisher("/obstacle_generator/generate_circle", Bool, queue_size=10)
        self.pub_bar = rospy.Publisher("/obstacle_generator/generate_bar", Bool, queue_size=10)
        self.tf_listener = tf.TransformListener()

        self.goal_count = 0

        rospy.sleep(2.0)
        self.save_start_pos()

        rospy.spin()

    def save_start_pos(self):
        (trans, rotQ) = self.tf_listener.lookupTransform("/odom", "/base_footprint", rospy.Time(0))
        self.start_pos = trans
        rospy.loginfo("Saved start position: ({}, {})".format(self.start_pos[0], self.start_pos[1]))

    def goal_callback(self, msg):
        self.goal_count += 1
        rospy.loginfo("goal sent, count is now {}".format(self.goal_count))

        if self.goal_count == 2:
            self.clear_octomap(10, 10)
            #self.reset_octomap_service()

        if self.goal_count == 4:
            self.pub_bar.publish(Bool(True))

    def clear_octomap(self, w, h):
        rospy.loginfo("Clearing octomap. The box is {}m (x) by {}m (y) around ({}, {})".format(w,h,self.start_pos[0], self.start_pos[1]))
        min = Point()
        max = Point()

        min.x = self.start_pos[0] - w/2.0
        max.x = self.start_pos[0] + w/2.0

        min.y = self.start_pos[1] - h/2.0
        max.y = self.start_pos[1] + h/2.0

        # tweak Z to clear only certain parts of the map (only obstales, only lines, etc)
        min.z = -5.0
        max.z = 5.0

        self.clear_octomap_service(min, max)

if __name__ == "__main__":
    try:
        a = StateAi()
    except rospy.ROSInterruptException:
        pass
