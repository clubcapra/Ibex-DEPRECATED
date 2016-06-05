#!/usr/bin/env python

import rospy
import tf
import math
from geometry_msgs.msg import PointStamped, Quaternion, Pose, Point
from actionlib_msgs.msg import GoalStatus, GoalID
from move_base_msgs.msg import MoveBaseActionGoal, MoveBaseActionFeedback, MoveBaseActionResult
from std_msgs.msg import Bool
from marker_manager import MarkerManager
from capra_ai.msg import GoalWithPriority
from capra_ai.srv import ClearGoalList, AddGoal, CancelGoal
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2
import dynamic_reconfigure.client


class GoalManager():

    # provide the status name and text for detail
    status_list = ["pending", "active", "preempted", "succeeded", "aborted", "rejected", "preempting", "recalling",
                   "recalled", "lost"]

    # common format for all goals
    class GoalWrapper():
        def __init__(self, move_base_action_goal, goal_with_priority, need_tf = False):
            self.move_base_action_goal = move_base_action_goal
            self.goal_with_priority = goal_with_priority
            self.need_tf = need_tf

    # define topics on which to receive waypoints
    # define publishers
    # start utility services
    # define priority to precision map
    def __init__(self):
        self.goals = []
        self.marker_manager = MarkerManager()
        self.current_idx = -1
        self.count = 0
        self.upd_count = 0
        self.loop_goals = bool(rospy.get_param("~loop", default=False))

        self.tf_listener = tf.TransformListener()

        rospy.Subscriber("/clicked_point", PointStamped, self.point_received_callback)  # rviz goals
        rospy.Subscriber("~waypoint", GoalWithPriority, self.goal_received_callback)  # no transform
        rospy.Subscriber("~tf_waypoint", GoalWithPriority, self.tf_goal_received_callback)  # needs transform
        rospy.Subscriber("/move_base/feedback", MoveBaseActionFeedback, self.feedback_received_callback)
        rospy.Subscriber("/move_base/result", MoveBaseActionResult, self.result_received_callback)

        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=10)
        self.done_pub = rospy.Publisher("~last_goal_reached", Bool, queue_size=1)
        self.current_pub = rospy.Publisher("~current", GoalWithPriority, queue_size=1)
        self.reached_pub = rospy.Publisher("~reached", PointCloud2, queue_size=1)
        self.future_pub = rospy.Publisher("~future", PointCloud2, queue_size=1)

        rospy.Service("~clear", ClearGoalList, self.handle_clear_goal_list)
        rospy.Service("~add_goal", AddGoal, self.handle_add_goal)
        rospy.Service("~cancel_goal", CancelGoal, self.handle_cancel_goal)

        self.priority_to_precision = []
        d = 1.3
        self.priority_to_precision.append(d)  # [0,100[
        self.priority_to_precision.append(d)  # [100,200[
        self.priority_to_precision.append(d)  # [200,300[
        self.priority_to_precision.append(d)  # [300,400[
        self.priority_to_precision.append(d)  # [400,500[

        self.loop()

    # send first goal on reception
    # publish all goals in a pointcloud
    # publish interactive markers
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

    # if list is empty, block until it is not
    def wait_for_goal(self):
        rate = rospy.Rate(10)
        while len(self.goals) == 0 and not rospy.is_shutdown():
            rate.sleep()

    # send next goal to move base
    # update goal tolerance
    # transform its frame if necessary
    def next_goal(self, idx = 0):
        # idx is current goal
        if len(self.goals) > idx > self.current_idx:
            self.current_idx = idx
            if self.goals[idx].need_tf:
                self.tf_listener.waitForTransform("/odom", "/base_footprint", rospy.Time(), rospy.Duration(6.0))
                t = self.tf_listener.getLatestCommonTime("/odom", "/base_footprint")
                (trans, rot) = self.tf_listener.lookupTransform("/odom", "/base_footprint", t)
                erot = tf.transformations.euler_from_quaternion(rot)
                distance = self.goals[idx].goal_with_priority.pose.position.x
                yaw = erot[2]
                dx = math.cos(yaw) * distance + trans[0]
                dy = math.sin(yaw) * distance + trans[1]
                pos = Point(x = dx, y = dy)
                self.goals[idx].goal_with_priority.pose.position = pos
                self.goals[idx].move_base_action_goal.goal.target_pose.pose.position = pos
                rospy.loginfo("Goal was transformed, new pos is ( %f, %f ) with yaw of %f" % (dx, dy, yaw))
            self.goal_pub.publish(self.goals[idx].move_base_action_goal)
            self.update_reached_precision(self.goals[idx].goal_with_priority)
            rospy.sleep(0.05)
            self.current_pub.publish(self.goals[idx].goal_with_priority)
            rospy.loginfo("Published goal # %i" % (idx + 1))

    # prepare goal for sending
    def add_waypoint(self, goal_with_priority, add_after_current = False, need_tf = False):  # GoalWithPriority
        goal_id = self.new_goal_id()
        pose = goal_with_priority.pose
        goal_with_priority.goal_id = goal_id
        move_base_msg = MoveBaseActionGoal()
        move_base_msg.header.frame_id = 'odom'
        move_base_msg.goal.target_pose.header.frame_id = 'odom'
        move_base_msg.goal.target_pose.pose = pose
        move_base_msg.goal_id = goal_id
        goal = GoalManager.GoalWrapper(move_base_msg, goal_with_priority, need_tf = need_tf)
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

    # if precision has changed since last goal, change it with dynamic_reconfigure
    def update_reached_precision(self, goal_with_prirority):
        return
        tolerance_param = 'xy_goal_tolerance'
        priority_idx = int(goal_with_prirority.priority / 100)
        precision = self.priority_to_precision[priority_idx]
        # http://wiki.ros.org/base_local_planner#Goal_Tolerance_Parameters
        client = dynamic_reconfigure.client.Client("/move_base/TrajectoryPlannerROS")
        old_config = client.get_configuration(0.05)
        if old_config is None or old_config[tolerance_param] != precision:
            params = { tolerance_param : precision }
            new_config = client.update_configuration(params)
            rospy.loginfo("Goal xy tolerance set to %s", str(precision))
        else:
            rospy.loginfo("Goal tolerance not updated")

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

    # generate a new id
    # format is [node name]_[goal number]_[time]
    def new_goal_id(self):
        now = rospy.get_rostime()
        new_id = "%s_%i_%i_%i" % (rospy.get_name(), self.count, now.secs, now.nsecs)
        self.count += 1
        goal_id = GoalID()
        goal_id.stamp = now
        goal_id.id = new_id
        return goal_id

    # status updates for all goals
    def status_updated_callback(self, msg):  # GoalStatusArray
        intermediate_statuses = [GoalStatus.PENDING, GoalStatus.ACTIVE, GoalStatus.RECALLING, GoalStatus.PREEMPTING]
        for goal in msg.status_list:
            # status = GoalManager.status_list[goal.status]
            # rospy.logerr("Goal %s. %s" % (status, goal.text))
            goal_idx = self.get_index_of(goal.goal_id.id)
            if goal.status == GoalStatus.SUCCEEDED:  # do a little dance to celebrate
                rospy.loginfo("Goal %s reached!" % goal.goal_id.id)
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
            elif goal.status == GoalStatus.PREEMPTED:
                rospy.logwarn("Goal %s was preempted. %s" % (goal.goal_id.id, goal.text))
            else:  # the robot's dead
                status = GoalManager.status_list[goal.status]
                rospy.logerr("Goal %s %s. %s" % (goal.goal_id.id, status, goal.text))

    def result_received_callback(self, msg):  # MoveBaseActionResult
        current_goal = self.goals[self.current_idx].goal_with_priority
        if current_goal.goal_id.id == msg.status.goal_id.id:
            rospy.loginfo("Goal %s %s. %s" % (msg.status.goal_id.id, GoalManager.status_list[msg.status.status],
                                             msg.status.text))
            self.wait_for_goal()
            self.next_goal(self.current_idx + 1)

    def feedback_received_callback(self, msg):  # MoveBaseActionFeedback
        current_pos = msg.feedback.base_position.pose.position
        current_goal = self.goals[self.current_idx].goal_with_priority
        if current_goal.goal_id.id == msg.status.goal_id.id:
            goal_pos = current_goal.pose.position
            priority_idx = int(current_goal.priority / 100)
            precision = self.priority_to_precision[priority_idx]
            distance = ((goal_pos.x - current_pos.x) ** 2 + (goal_pos.y - current_pos.y) ** 2) ** 0.5
            if distance <= precision:
                rospy.loginfo("Goal has been reached!")
                self.wait_for_goal()
                self.next_goal(self.current_idx + 1)

    def goal_received_callback(self, goal_msg):  # GoalWithPriority
        rospy.loginfo("Received GoalWithPriority msg")
        self.add_waypoint(goal_msg)

    def point_received_callback(self, msg):  # PointStamped
        goal_msg = GoalWithPriority()
        goal_msg.pose = Pose()
        goal_msg.pose.position = msg.point
        goal_msg.pose.orientation = Quaternion(w = 1.0)
        goal_msg.priority = 0
        self.add_waypoint(goal_msg)

    def tf_goal_received_callback(self, goal_msg):  #GoalWithPriority
        rospy.loginfo("Received GoalWithPriority msg with need_tf=true")
        self.add_waypoint(goal_msg, need_tf = True)

    def handle_clear_goal_list(self, req):
        if req.data:
            self.current_idx = -1
            del self.goals[:]
        return True
        
    def handle_add_goal(self, req):
        self.add_waypoint(req.goal_with_priority, req.add_after_current)
        return True

    def handle_cancel_goal(self, req):
        if req.cancel:
            self.next_goal(self.current_idx + 1)
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

