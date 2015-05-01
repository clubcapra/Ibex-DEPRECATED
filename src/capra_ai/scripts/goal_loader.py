#!/usr/bin/env python

import json
import rospy
import os.path
from geometry_msgs.msg import PoseStamped, Quaternion
from sensor_msgs.msg import NavSatFix
from capra_gps.srv import AddLatlongGoal


class GoalLoader():

    def __init__(self):
        rospy.wait_for_service('/move_base/make_plan')
        rospy.sleep(2.0)  # wait for move_base to be ready
        self.msgs = []
        self.pub_topic = '/goal_manager/waypoint'
        self.pose_pub = rospy.Publisher(self.pub_topic, PoseStamped, queue_size=10)
        file_path = rospy.get_param("~file")
        rospy.loginfo("Fetching waypoint data from: %s" % file_path)

        if not os.path.isfile(file_path):
            rospy.logerr("File does not exist: " + file_path)
            exit()

        with open(file_path) as data_file:
            try:
                self.data = json.load(data_file)
            except:
                rospy.logerr("Unable to parse JSON file : " + file_path)
                exit()

        self.parse()
        self.send()
        while not rospy.is_shutdown():
            rospy.sleep(1.0)

    def parse(self):
        rospy.loginfo("Waiting for AddLatLongGoal service...")
        rospy.wait_for_service('/latlong_goal_node/AddLatlongGoal')
        rospy.loginfo("AddLatLongGoal service responded")
        self.latlong_service = rospy.ServiceProxy('/latlong_goal_node/AddLatlongGoal', AddLatlongGoal)
        rospy.loginfo("AddLatLongGoal service is up")
        for point in self.data:
            rospy.loginfo("Point is %s" % str(point))
            if point['gps'] == 1:
                pose_msg = self.convert_gps_to_pose(point)
                self.msgs.append(pose_msg)
            else:
                pose_msg = PoseStamped()
                pose_msg.header.frame_id = 'odom'
                pose_msg.pose.position.x = point['x']
                pose_msg.pose.position.y = point['y']
                pose_msg.pose.orientation = Quaternion(w = 1)
                self.msgs.append(pose_msg)

    def send(self):
        # publish on /goal_manager/waypoint in order of file
        rospy.loginfo("Publishing %i points on %s" % (len(self.msgs), self.pub_topic))
        for pose_msg in self.msgs:
            self.pose_pub.publish(pose_msg)

    def convert_gps_to_pose(self, coords):
        # create NavSatFix msg
        nav_msg = NavSatFix()
        nav_msg.header.stamp = rospy.get_rostime()
        nav_msg.header.frame_id = 'odom'
        # x is longitude, y is latitude
        nav_msg.longitude = coords['x']
        nav_msg.latitude = coords['y']
        # convert using /latlong_goal_node/AddLatLongGoal service
        # returns PoseStamped
        response = self.latlong_service(nav_msg)
        rospy.loginfo("Converted NavSatFix to PoseStamped -> (%f, %f)" % (response.goal_xy.pose.position.x,
                      response.goal_xy.pose.position.y))
        return response.goal_xy


if __name__ == '__main__':
    rospy.init_node('goal_loader')
    try:
        GoalLoader()
    except rospy.ROSInterruptException: pass
