#! /usr/bin/env python
# coding=utf-8

import rospy
from ai_util import *
from move_base_msgs.msg import MoveBaseActionGoal
from std_msgs.msg import Bool
from octomap_msgs.srv import BoundingBoxQuery
from std_srvs.srv import Empty
from geometry_msgs.msg import Point
from capra_msgs.srv import GenerateObstacle
from capra_ai.msg import GoalWithPriority
import dynamic_reconfigure.client
import tf

class StateAi(object):

    def __init__(self, name):
        rospy.init_node(name)

        self.clear_octomap_service = rospy.ServiceProxy('/octomap_server/clear_bbx', BoundingBoxQuery)
        self.reset_octomap_service = rospy.ServiceProxy('/octomap_server/reset', Empty)
        self.generate_obstacle_service = rospy.ServiceProxy('/obstacle_generator', GenerateObstacle)
        rospy.Subscriber("/goal_manager/current", GoalWithPriority, self.goal_callback)
        rospy.Subscriber("/goal_manager/last_goal_reached", Bool, self.last_goal_callback)
        self.pub_circle = rospy.Publisher("/obstacle_generator/generate_circle", Bool, queue_size=10)
        self.pub_bar = rospy.Publisher("/obstacle_generator/generate_bar", Bool, queue_size=10)
        self.tf_listener = tf.TransformListener()

        self.goal_count = 0

        rospy.sleep(2.0)
        self.save_start_pos()
        self.on_start()

        rospy.spin()

    def save_start_pos(self):
        self.start_pos = self.get_pos()[0]
        rospy.loginfo("Saved start position: ({}, {})".format(self.start_pos[0], self.start_pos[1]))

    def get_pos(self):
        (trans, rot0) = self.tf_listener.lookupTransform("/odom", "/base_footprint", rospy.Time(0))
        return trans, rot0

    def goal_state(self, goal_msg):
        return None

    def goal_callback(self, msg):
        self.goal_count += 1
        self.on_goal_changed(msg)

    def last_goal_callback(self, msg):
        if msg.data == True:
            self.on_last_goal_reached(msg)

    def on_start(self):
        return None

    def on_goal_changed(self, msg):
        return None

    def on_last_goal_reached(self, msg):
        return None

    def generate_circle(self, radius, start_rad, end_rad, step_rad):
        return self.generate_obstacle('circle', (radius, start_rad, end_rad, step_rad))

    def generate_bar(self, length, distance):
        return self.generate_obstacle('bar', (length, distance))

    def generate_obstacle(self, type, params):
        return self.generate_obstacle_service(type, params)


    def clear_octomap(self, center, width, height):
        rospy.loginfo("Clearing octomap. The box is {}m (x) by {}m (y) around ({}, {})".format(width,height,self.start_pos[0], self.start_pos[1]))
        min = Point()
        max = Point()

        min.x = center[0] - width/2.0
        max.x = center[0] + width/2.0

        min.y = center[1] - height/2.0
        max.y = center[1] + height/2.0

        # tweak Z to clear only certain parts of the map (only obstales, only lines, etc)
        min.z = -5.0
        max.z = 5.0

        self.clear_octomap_service(min, max)

    def reset_octomap(self):
        self.reset_octomap_service()
        rospy.loginfo("Octomap reset")

    def set_max_vel_x(self, velocity):
        client = dynamic_reconfigure.client.Client("/move_base/TrajectoryPlannerROS")
        params = { 'max_vel_x' : velocity}
        config = client.update_configuration(params)
        rospy.loginfo("Max vel x set to %s", str(velocity))


if __name__ == "__main__":
    try:
        a = StateAi()
    except rospy.ROSInterruptException:
        pass
