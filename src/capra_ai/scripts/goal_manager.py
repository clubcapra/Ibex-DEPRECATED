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
        self.counter = 0
        self.current_idx = -1
        rospy.Subscriber("~waypoint", PoseStamped, self.pose_received)  # receive goals from other nodes
        rospy.Subscriber("/clicked_point", PointStamped, self.point_received)  # rviz goals
        rospy.Subscriber("/move_base/status", GoalStatusArray, self.status_updated)  # track status of goals
        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=10)
        self.reached_pub = rospy.Publisher("~reached", PointCloud2, queue_size=1)
        self.future_pub = rospy.Publisher("~future", PointCloud2, queue_size=1)
        self.loop()

    def loop(self):
        rate = rospy.Rate(10)
        # wait for the first goal, because the publisher waits for a success to publish the next one
        self.waitforgoal()
        self.nextgoal()
        while not rospy.is_shutdown():
            points = [obj.goal.target_pose.pose.position for obj in self.goals]  # list of Point
            reached = self.pointcloud(points[:self.current_idx])
            future = self.pointcloud(points[self.current_idx:])
            self.reached_pub.publish(reached)
            self.future_pub.publish(future)
            rate.sleep()

    def waitforgoal(self):
        rate = rospy.Rate(10)
        while len(self.goals) == 0:
            rate.sleep()

    def nextgoal(self, idx = 0):
        # idx is current goal
        if len(self.goals) > idx and idx > self.current_idx:
            self.current_idx = idx
            self.goal_pub.publish(self.goals[idx])
            rospy.loginfo("Published goal # %i" % (idx + 1))

    def addwaypoint(self, pose):  # PoseStamped
        now = rospy.get_rostime()
        self.counter = self.counter + 1
        msg = MoveBaseActionGoal()
        msg.goal.target_pose = pose
        msg.goal_id.stamp = now
        # id format is "[node_name]_[goal_count]_[time]"
        msg.goal_id.id = "%s_%i_%i_%i" % (rospy.get_name(), self.counter, now.secs, now.nsecs)
        self.goals.append(msg)
        position = msg.goal.target_pose.pose.position
        rospy.loginfo("Received goal:\n\tx:%f\n\ty:%f" % (position.x, position.y))

    def index(self, goal_id):
        for idx, obj in enumerate(self.goals):
            if obj.goal_id.id == goal_id:
                return idx
        return -1

    def pointcloud(self, points):  # list of Point
        cloud = [[pt.x, pt.y, pt.z] for pt in points]
        pcl = PointCloud2()
        pcl = pc2.create_cloud_xyz32(pcl.header, cloud)
        pcl.header.frame_id = "odom"
        return pcl

    def status_updated(self, msg):  # GoalStatusArray
        intermediate_statuses = [GoalStatus.PENDING, GoalStatus.ACTIVE, GoalStatus.RECALLING, GoalStatus.PREEMPTING]
        for goal in msg.status_list:
            goal_idx = self.index(goal.goal_id.id)
            if goal.status == GoalStatus.SUCCEEDED:  # do a little dance to celebrate
                self.waitforgoal()
                self.nextgoal(goal_idx + 1)
            elif goal.status in intermediate_statuses:  # transitional state, so just wait
                pass
            else:  # the robot's dead
                rospy.logerr("Goal invalidated. Goal status number: %i" % goal.status)

    def pose_received(self, msg):  # PoseStamped
        self.addwaypoint(msg)

    def point_received(self, msg):  # PointStamped
        pose_msg = PoseStamped()
        pose_msg.header = msg.header
        pose_msg.pose.position = msg.point
        # x = y = 0.7, z = w = 0 -> doesn't work
        pose_msg.pose.orientation = Quaternion(w = 1)  # could be changed to the robot's current orientation
        self.addwaypoint(pose_msg)


if __name__ == '__main__':
    rospy.init_node('goal_manager')
    try:
        GoalManager()
    except rospy.ROSInterruptException: pass

