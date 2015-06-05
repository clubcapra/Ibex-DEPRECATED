#!/usr/bin/env python

import rospy
from geometry_msgs.msg import PoseStamped, PointStamped, Quaternion, PoseArray, Pose
from actionlib_msgs.msg import GoalStatusArray, GoalStatus, GoalID
from move_base_msgs.msg import MoveBaseActionGoal
from std_msgs.msg import Bool
from marker_manager import MarkerManager
from capra_ai.msg import GoalWithPriority
from capra_ai.srv import ClearGoalList, AddGoal
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2
import dynamic_reconfigure.client


class GoalManager():

    # provide the status name and text for detail
    status_list = ["pending", "active", "preempted", "succeeded", "aborted", "rejected", "preempting", "recalling", "recalled", "lost"]

    class GoalWrapper():
        def __init__(self, move_base_action_goal, goal_with_priority):
            self.move_base_action_goal = move_base_action_goal
            self.goal_with_priority = goal_with_priority

    def __init__(self):
        self.goals = []
        self.marker_manager = MarkerManager()
        self.current_idx = -1
        self.count = 0
        self.upd_count = 0
        self.loop_goals = bool(rospy.get_param("~loop", default = False))
        rospy.Subscriber("/clicked_point", PointStamped, self.point_received_callback)  # rviz goals
        rospy.Subscriber("~waypoint", GoalWithPriority, self.goal_received_callback)  # receive goals from other nodes
        rospy.Subscriber("/move_base/status", GoalStatusArray, self.status_updated_callback)  # track status of goals
        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=10)
        self.done_pub = rospy.Publisher("~last_goal_reached", Bool, queue_size=1)

        self.reached_pub = rospy.Publisher("~reached", PointCloud2, queue_size=1)
        self.future_pub = rospy.Publisher("~future", PointCloud2, queue_size=1)

        self.current_pub = rospy.Publisher("~current", GoalWithPriority, queue_size=1)
        rospy.Service("~clear", ClearGoalList, self.handle_clear_goal_list)
        rospy.Service("~add_goal", AddGoal, self.handle_add_goal)
        self.priority_to_precision = []
        self.priority_to_precision.append(0.1)  # [0,100[
        self.priority_to_precision.append(0.4)  # [100,200[
        self.priority_to_precision.append(1.0)  # [200,300[
        self.priority_to_precision.append(2.0)  # [300,400[
        self.priority_to_precision.append(4.0)  # [400,500[
        self.loop()

    def loop(self):
        rate = rospy.Rate(10)
        # wait for the first goal, because the publisher waits for a success to publish the next one
        # blocking
        self.wait_for_goal()
        self.next_goal()
        while not rospy.is_shutdown():
            # update rviz interactive markers
            if len(self.goals) > 0:
                self.publish_goals_pc()
                for goal in self.goals:
                    goal_id = goal.goal_with_priority.goal_id.id
                    position = goal.goal_with_priority.pose.position
                    if self.marker_manager.get_marker(goal_id) is not None:
                        self.marker_manager.create_marker(goal_id, 'odom')
                    self.marker_manager.update_marker(goal_id, position.x, position.y)
            rate.sleep()

    def wait_for_goal(self):
        rate = rospy.Rate(10)
        while len(self.goals) == 0 and not rospy.is_shutdown():
            rate.sleep()

    def next_goal(self, idx = 0):
        # idx is current goal
        if len(self.goals) > idx > self.current_idx:
            self.current_idx = idx
            self.goal_pub.publish(self.goals[idx].move_base_action_goal)
            self.update_reached_precision(self.goals[idx].goal_with_priority)
            self.current_pub.publish(self.goals[idx].goal_with_priority)
            rospy.loginfo("Published goal # %i" % (idx + 1))

    def add_waypoint(self, goal_with_priority, add_after_current = False):  # GoalWithPriority

        goal_id = self.new_goal_id()
        pose = goal_with_priority.pose
        goal_with_priority.goal_id = goal_id
        move_base_msg = MoveBaseActionGoal()
        move_base_msg.header.frame_id = 'odom'
        move_base_msg.goal.target_pose.header.frame_id = 'odom'
        move_base_msg.goal.target_pose.pose = pose
        move_base_msg.goal_id = goal_id
        goal = GoalManager.GoalWrapper(move_base_msg, goal_with_priority)
        goal.goal_with_priority = goal_with_priority
        if add_after_current:
            self.goals.insert(self.current_idx + 1, goal)
        else:
            self.goals.append(goal)
        rospy.loginfo("Received goal:\n\tx:%f\n\ty:%f" % (pose.position.x, pose.position.y))

    def get_index_of(self, goal_id):
        for idx, obj in enumerate(self.goals):
            if obj.move_base_action_goal.goal_id.id == goal_id:
                return idx
        return -1

    def update_reached_precision(self, goal_with_prirority):
        priority_idx = int(goal_with_prirority.priority / 100)
        precision = self.priority_to_precision[priority_idx]
        # http://wiki.ros.org/base_local_planner#Goal_Tolerance_Parameters
        client = dynamic_reconfigure.client.Client("/move_base/TrajectoryPlannerROS")
        params = { 'xy_goal_tolerance' : precision }
        config = client.update_configuration(params)
        rospy.loginfo("Goal xy tolerance set to %s", str(precision))

    def reset_goal_list(self):  # called when the base has reached the last goal and needs to loop
        # update goal ids
        # set current idx to -1
        for idx, msg in enumerate(self.goals):
            goal_id = self.new_goal_id()
            msg.move_base_action_goal.goal_id = goal_id
            msg.goal_with_priority.goal_id = goal_id
            rospy.loginfo("Goal # %i id is now %s" % (self.count, goal_id.id))
            self.goals[idx] = msg
        self.current_idx = -1
        
    def new_goal_id(self):
        now = rospy.get_rostime()
        new_id = "%s_%i_%i_%i" % (rospy.get_name(), self.count, now.secs, now.nsecs)
        self.count += 1
        goal_id = GoalID()
        goal_id.stamp = now
        goal_id.id = new_id
        return goal_id

    def status_updated_callback(self, msg):  # GoalStatusArray
        intermediate_statuses = [GoalStatus.PENDING, GoalStatus.ACTIVE, GoalStatus.RECALLING, GoalStatus.PREEMPTING]

        for goal in msg.status_list:
            #status = GoalManager.status_list[goal.status]
            #rospy.logerr("Goal %s. %s" % (status, goal.text))
            goal_idx = self.get_index_of(goal.goal_id.id)
            if goal.status == GoalStatus.SUCCEEDED:  # do a little dance to celebrate
                last_goal_reached = Bool()
                last_goal_reached.data = not self.loop_goals and goal_idx + 1 == len(self.goals)
                self.done_pub.publish(last_goal_reached)
                self.wait_for_goal()
                if goal_idx + 1 == len(self.goals):
                    if self.loop_goals:
                        rospy.loginfo("Now looping back to first goal")
                        self.reset_goal_list()
                        self.next_goal()
                else:
                    self.next_goal(goal_idx + 1)
            elif goal.status in intermediate_statuses:  # transitional state, so just wait
                pass
            else:  # the robot's dead
                status = GoalManager.status_list[goal.status]
                rospy.logerr("Goal %s. %s" % (status, goal.text))

    def goal_received_callback(self, goal_msg):  # GoalWithPriority
        rospy.loginfo("Received GoalWithPriority msg")
        self.add_waypoint(goal_msg)

    def point_received_callback(self, msg):  # PointStamped
        goal_msg = GoalWithPriority()
        goal_msg.pose = Pose()
        goal_msg.pose.position = msg.point
        goal_msg.pose.orientation = Quaternion(w = 1)
        goal_msg.priority = 0
        self.add_waypoint(goal_msg)

    def handle_clear_goal_list(self, req):
        if req.data:
            self.current_idx = -1
            del self.goals[:]
        return True
        
    def handle_add_goal(self, req):
        goal_id = self.new_goal_id()
        self.add_waypoint(req.goal_with_priority, req.add_after_current)
        return True

    def publish_goals_pc(self):
        current_goal = GoalWithPriority()
        current_goal.goal_id = self.goals[self.current_idx].move_base_action_goal.goal_id
        current_goal.pose = self.goals[self.current_idx].move_base_action_goal.goal.target_pose.pose
        points = [obj.move_base_action_goal.goal.target_pose.pose.position for obj in self.goals]  # list of Point
        reached = self.convert_to_pointcloud(points[:self.current_idx])
        future = self.convert_to_pointcloud(points[self.current_idx:])
        self.reached_pub.publish(reached)
        self.future_pub.publish(future)

    def convert_to_pointcloud(self, points):  # list of Point
        cloud = [[pt.x, pt.y, pt.z] for pt in points]
        pcl = PointCloud2()
        pcl = pc2.create_cloud_xyz32(pcl.header, cloud)
        pcl.header.frame_id = "odom"
        return pcl

if __name__ == '__main__':
    rospy.init_node('goal_manager')
    try:
        GoalManager()
    except rospy.ROSInterruptException:
        pass

