#! /usr/bin/env python
# coding=utf-8

import rospy
from ai_util import *
from move_base_msgs.msg import MoveBaseActionGoal
from std_msgs.msg import Bool
from octomap_msgs.srv import BoundingBoxQuery
from std_srvs.srv import Empty
from geometry_msgs.msg import Point
from geometry_msgs.msg import Pose
from geometry_msgs.msg import Quaternion
from capra_msgs.srv import GenerateObstacle
from capra_ai.srv import AddGoal
from capra_ai.msg import GoalWithPriority
import dynamic_reconfigure.client
from nav_msgs.msg import Odometry
import rospkg

import tf
import math

try:
    import pygame
    pygame.init()
    rospack = rospkg.RosPack()
    pygame.mixer.music.load(rospack.get_path("capra_ai") + "/scripts/capra_yeah.wav")
    pygame_loaded = True
except:
    pygame_loaded = False


class StateAi(object):

    def __init__(self, name, log_level=rospy.INFO, start=True):
        rospy.init_node(name, log_level=log_level)

        self.clear_octomap_service = rospy.ServiceProxy('/octomap_server/clear_bbx', BoundingBoxQuery)
        self.reset_octomap_service = rospy.ServiceProxy('/octomap_server/reset', Empty)
        is_sim = rospy.get_param("~is_simulation", False)
        self.is_ready = True
        rospy.wait_for_service('/obstacle_generator')
        rospy.wait_for_service('/goal_manager/add_goal', 5)
        rospy.wait_for_service('/move_base/make_plan', 5)
        if not is_sim:
            rospy.wait_for_message('/odometry/filtered', Odometry, timeout=None)
        rospy.sleep(0.02)
        self.generate_obstacle_service = rospy.ServiceProxy('/obstacle_generator', GenerateObstacle)
        self.send_goal_service = rospy.ServiceProxy('/goal_manager/add_goal', AddGoal)
        rospy.Subscriber("/goal_manager/current", GoalWithPriority, self.goal_callback)
        rospy.Subscriber("/goal_manager/last_goal_reached", Bool, self.last_goal_callback)

        self.tf_listener = tf.TransformListener()


        self.goal_count = 0

        self.tf_listener.waitForTransform("/odom", "/base_footprint", rospy.Time(), rospy.Duration(6.0))
        self.is_ready = True
        self.save_start_pos()
        rospy.loginfo("StateAi {} started.".format(name))

        if start:
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
        while not self.is_ready:
            rospy.sleep(0.1)
        self.goal_count += 1
        self.on_goal_changed(msg)

    def last_goal_callback(self, msg):
        while not self.is_ready:
            rospy.sleep(0.1)
        if msg.data == True:
            #rospy.loginfo("Last goal reached")
            self.on_last_goal_reached(msg)

    def send_goal_ahead(self, distance, priority=100,  add_after_current=False):
        (pos,rot) = self.get_pos()
        erot = tf.transformations.euler_from_quaternion(rot)
        dx = math.cos(erot[2]) * distance
        dy = math.sin(erot[2]) * distance
        self.send_goal(pos[0] + dx, pos[1] + dy, priority, add_after_current)


    def send_goal(self, x, y, priority=100,  add_after_current=False):
        goal = GoalWithPriority()
        goal.pose.position.x = x
        goal.pose.position.y = y
        goal.pose.position.z = 0
        goal.pose.orientation.w = 1
        goal.priority = priority
        self.send_goal_service(goal, add_after_current)


    def send_relative_goal(self, rx, ry, priority=100, add_after_current=False):
        current_trans = self.get_pos()[0]
        self.send_goal(current_trans[0] + rx, current_trans[1] + ry, priority, add_after_current)

    def on_start(self):
        return None

    def on_goal_changed(self, msg):
        return None

    def on_last_goal_reached(self, msg):
        return None

    def generate_circle(self, radius, start_rad, end_rad, step_rad, duration):
        self.generate_obstacle('circle', (radius, start_rad, end_rad, step_rad), duration)

    def generate_bar(self, length, distance, duration):
        self.generate_obstacle('bar', (length, distance), duration)

    def generate_obstacle(self, type, params, duration):
        self.generate_obstacle_service(type, params, duration)


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

    def debug(self, text):
        rospy.logdebug(text)

    def reset_octomap(self):
        rospy.loginfo("Resetting by clearing octomap.")
        min = Point()
        max = Point()

        min.x = -100
        max.x = 100

        min.y = -50
        max.y = 50

        # tweak Z to clear only certain parts of the map (only obstales, only lines, etc)
        min.z = -5.0
        max.z = 5.0

        self.clear_octomap_service(min, max)

    def set_max_vel_x(self, velocity):
        client = dynamic_reconfigure.client.Client("/move_base/TrajectoryPlannerROS")
        params = { 'max_vel_x' : velocity}
        config = client.update_configuration(params)
        rospy.loginfo("max_vel_x set to %s", str(velocity))


     #The weighting for how much the controller should stay close to the path it was given. default 0.6
    def pdist_scale(self, dist):
        client = dynamic_reconfigure.client.Client("/move_base/TrajectoryPlannerROS")
        params = { 'pdist_scale' : dist}
        config = client.update_configuration(params)
        rospy.loginfo("pdist_scale set to %s", str(dist))

    # The weighting for how much the controller should attempt to avoid obstacles.
    def occdist_scale(self, dist):
        client = dynamic_reconfigure.client.Client("/move_base/TrajectoryPlannerROS")
        params = { 'occdist_scale' : dist}
        config = client.update_configuration(params)
        rospy.loginfo("occdist_scale set to %s", str(dist))

    # The weighting for how much the controller should attempt to reach its local goal, also controls speed. default 0.8
    def gdist_scale(self, dist):
        client = dynamic_reconfigure.client.Client("/move_base/TrajectoryPlannerROS")
        params = { 'gdist_scale' : dist}
        config = client.update_configuration(params)
        rospy.loginfo("gdist_scale set to %s", str(dist))

    def play_song(self):
        if pygame_loaded:
            pygame.mixer.music.play()

if __name__ == "__main__":
    try:
        a = StateAi("state_ai")
    except rospy.ROSInterruptException:
        pass
