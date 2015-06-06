#!/usr/bin/env python

import json
import rospy
import os.path
import re
from geometry_msgs.msg import PoseStamped, Quaternion
from sensor_msgs.msg import NavSatFix
from capra_gps.srv import AddLatlongGoal
from capra_ai.msg import GoalWithPriority


class GoalLoader():

    def __init__(self):
        rospy.wait_for_service('/move_base/make_plan')
        rospy.wait_for_service('/octomap_server/reset')
        rospy.sleep(2.0)  # wait for move_base to be ready
        self.msgs = []
        self.latlong_service = None
        self.pub_topic = '/goal_manager/waypoint'
        self.goal_pub = rospy.Publisher(self.pub_topic, GoalWithPriority, queue_size=10)
        self.tf_pub_topic = '/goal_manager/tf_waypoint'
        self.tf_goal_pub = rospy.Publisher(self.tf_pub_topic, GoalWithPriority, queue_size=10)
        rate = rospy.Rate(10)
        while self.goal_pub.get_num_connections() == 0:
            rate.sleep()
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
            if point['gps'] == 2:  # dms
                point['x'] = self.convert_dms_string_to_decimal(point['x'])
                point['y'] = self.convert_dms_string_to_decimal(point['y'])
                pose_msg = self.convert_gps_to_pose(point)
            elif point['gps'] == 1:  # decimal
                pose_msg = self.convert_gps_to_pose(point)
            else:  # decimal local
                pose_msg = PoseStamped()
                pose_msg.pose.position.x = point['x']
                pose_msg.pose.position.y = point['y']
                pose_msg.pose.orientation = Quaternion(w = 1.0)
            # goal_id will be filled in later on in the goal_manager
            # leave it blank
            goal_msg = GoalWithPriority()
            goal_msg.pose = pose_msg.pose
            goal_msg.priority = point['priorite']
            need_tf = point['gps'] == -1
            self.msgs.append((goal_msg, need_tf))

    def send(self):
        # publish on /goal_manager/waypoint in order of file
        rospy.loginfo("Publishing %i points on goal_manager waypoint topics" % len(self.msgs))
        for goal_tuple in self.msgs:
            goal_msg = goal_tuple[0]
            need_tf = goal_tuple[1]
            if need_tf:
                self.tf_goal_pub.publish(goal_msg)
                rospy.loginfo("Published goal on /goal_manager/tf_waypoint")
            else:
                self.goal_pub.publish(goal_msg)
                rospy.loginfo("Published goal on /goal_manager/waypoint")

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

    def convert_dms_to_decimal(self, degrees, minutes, seconds, is_negatif):
        return (degrees + (minutes+(seconds/60))/60) * (-1 if is_negatif else 1)

    def convert_decimal_to_dms(self, decimal):
        minutes_seconds = decimal % 1 * 60
        minutes = int(minutes_seconds)
        secondes = (minutes_seconds - minutes) * 60
        return int(decimal), minutes, secondes

    def convert_dms_string_to_decimal(self, dms_string):
        title = re.search('(\d{1,3}).(\d{1,2}).([\d\.]*).\s([NSEWO])', dms_string, re.IGNORECASE)
        degrees = int(title.group(1))
        minutes = int(title.group(2))
        seconds = float(title.group(3))
        orientation = title.group(4)

        if degrees < 0 or degrees >= 180:
            rospy.logerr("degrees field out of range, must be within [0, 180[")
            return
        if minutes < 0 or minutes >= 60:
            rospy.logerr("minutes field out of range, must be within [0, 60[")
            return
        if seconds < 0 or seconds >= 60:
            rospy.logerr("seconds field out of range, must be within [0, 60[")
            return
        return self.convert_dms_to_decimal(degrees, minutes, seconds, orientation in 'SWO')

if __name__ == '__main__':
    rospy.init_node('goal_loader')
    try:
        GoalLoader()
    except rospy.ROSInterruptException: pass
