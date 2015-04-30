#!/usr/bin/env python

import rospy
from geometry_msgs.msg import PoseStamped, PointStamped, Quaternion, PoseArray, Pose
from actionlib_msgs.msg import GoalStatusArray, GoalStatus
from move_base_msgs.msg import MoveBaseActionGoal
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2


class GoalManager():

    def __init__(self):
        self.goals = []
        self.current_idx = -1
        self.count = 0
        self.loop_goals = bool(rospy.get_param("~loop", default=False))
        rospy.Subscriber("~waypoint", PoseStamped, self.pose_received_callback)  # receive goals from other nodes
        rospy.Subscriber("/clicked_point", PointStamped, self.point_received_callback)  # rviz goals
        rospy.Subscriber("/move_base/status", GoalStatusArray, self.status_updated_callback)  # track status of goals
        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=10)
        self.reached_pub = rospy.Publisher("~reached", PointCloud2, queue_size=1)
        self.future_pub = rospy.Publisher("~future", PointCloud2, queue_size=1)
        self.loop()

    def loop(self):
        rate = rospy.Rate(10)
        # wait for the first goal, because the publisher waits for a success to publish the next one
        # blocking
        self.wait_for_goal()
        self.next_goal()
        while not rospy.is_shutdown():
            points = [obj.goal.target_pose.pose.position for obj in self.goals]  # list of Point
            reached = self.convert_to_pointcloud(points[:self.current_idx])
            future = self.convert_to_pointcloud(points[self.current_idx:])
            self.reached_pub.publish(reached)
            self.future_pub.publish(future)
            rate.sleep()

    def wait_for_goal(self):
        rate = rospy.Rate(10)
        while len(self.goals) == 0 and not rospy.is_shutdown():
            rate.sleep()

    def next_goal(self, idx = 0):
        # idx is current goal
        if len(self.goals) > idx and idx > self.current_idx:
            # update goal id
            self.current_idx = idx
            self.goal_pub.publish(self.goals[idx])
            rospy.loginfo("Published goal # %i" % (idx + 1))

    def add_waypoint(self, pose):  # PoseStamped
        now = rospy.get_rostime()
        self.count = self.count + 1
        msg = MoveBaseActionGoal()
        msg.goal.target_pose = pose
        msg.goal_id.stamp = now
        msg.goal_id.id = "%s_%i_%i_%i" % (rospy.get_name(), self.count, now.secs, now.nsecs)
        self.goals.append(msg)
        position = msg.goal.target_pose.pose.position
        rospy.loginfo("Received goal:\n\tx:%f\n\ty:%f" % (position.x, position.y))

    def get_index_of(self, goal_id):
        for idx, obj in enumerate(self.goals):
            if obj.goal_id.id == goal_id:
                return idx
        return -1

    def convert_to_pointcloud(self, points):  # list of Point
        cloud = [[pt.x, pt.y, pt.z] for pt in points]
        pcl = PointCloud2()
        pcl = pc2.create_cloud_xyz32(pcl.header, cloud)
        pcl.header.frame_id = "odom"
        return pcl

    def reset_goal_list(self):
        # update goal ids
        # set current idx to -1
        for idx, msg in enumerate(self.goals):
            now = rospy.get_rostime()
            self.count = self.count + 1
            msg.goal_id.stamp = now
            msg.goal_id.id = "%s_%i_%i_%i" % (rospy.get_name(), self.count, now.secs, now.nsecs)
            rospy.loginfo("Goal # %i id is now %s" % (self.count, msg.goal_id.id))
            self.goals[idx] = msg
        self.current_idx = -1

    def status_updated_callback(self, msg):  # GoalStatusArray
        intermediate_statuses = [GoalStatus.PENDING, GoalStatus.ACTIVE, GoalStatus.RECALLING, GoalStatus.PREEMPTING]
        for goal in msg.status_list:
            goal_idx = self.get_index_of(goal.goal_id.id)
            if goal.status == GoalStatus.SUCCEEDED:  # do a little dance to celebrate
                self.wait_for_goal()
                if self.loop_goals and goal_idx + 1 == len(self.goals):
                    rospy.loginfo("Now looping back to first goal")
                    self.reset_goal_list()
                    self.next_goal()
                else:
                    self.next_goal(goal_idx + 1)
            elif goal.status in intermediate_statuses:  # transitional state, so just wait
                pass
            else:  # the robot's dead
                rospy.logerr("Goal invalidated. %s" % goal.text)

    def pose_received_callback(self, msg):  # PoseStamped
        self.add_waypoint(msg)

    def point_received_callback(self, msg):  # PointStamped
        pose_msg = PoseStamped()
        pose_msg.header = msg.header
        pose_msg.pose.position = msg.point
        # x = y = 0.7, z = w = 0 -> doesn't work
        pose_msg.pose.orientation = Quaternion(w = 1)  # could be changed to the robot's current orientation
        self.add_waypoint(pose_msg)


if __name__ == '__main__':
    rospy.init_node('goal_manager')
    try:
        GoalManager()
    except rospy.ROSInterruptException:
        pass

