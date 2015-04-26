#!/usr/bin/env python

import json
import rospy
from geometry_msgs.msg import PoseStamped, Quaternion
from sensor_msgs.msg import NavSatFix
from capra_gps.srv import AddLatlongGoal


class GoalLoader():

    def __init__(self):
        self.msgs = []
        file_path = rospy.get_param('file')
        with open(file_path) as data_file:
            self.data = json.load(data_file)
        self.parse()
        self.send()

    def parse(self):
        rospy.wait_for_service('/latlong_goal_node/AddLatLongGoal')
        convert_to_latlong = rospy.ServiceProxy('/latlong_goal_node/AddLatLongGoal', AddLatlongGoal)
        for point in self.data:
            if point['gps'] == 1:
                pose_msg = self.gpstopose(point)
                self.msgs.append(pose_msg, convert_to_latlong)
            else:
                pose_msg = PoseStamped()
                pose_msg.pose.position.x = point['x']
                pose_msg.pose.position.y = point['y']
                pose_msg.pose.orientation = Quaternion(w = 1)
                self.msgs.append(pose_msg)

    def send(self):
        # publish on /goal_manager/waypoint in order of file
        self.pose_pub = rospy.Publisher('/goal_manager/waypoint', PoseStamped, queue_size = 10)
        for pose_msg in self.msgs:
            self.pose_pub.publish(pose_msg)

    def gpstopose(self, coords, convert_to_latlong):
        # create NavSatFix msg
        nav_msg = NavSatFix()
        nav_msg.header.stamp = rospy.get_rostime()
        nav_msg.header.frame_id = 'odom'
        # x is longitude, y is latitude
        nav_msg.longitude = coords['x']
        nav_msg.latitude = coords['y']
        # convert using /latlong_goal_node/AddLatLongGoal service
        # returns PoseStamped
        pose_msg = convert_to_latlong(nav_msg)
        return pose_msg


if __name__ == '__main__':
    rospy.init_node('goal_loader')
    try:
        GoalLoader()
    except rospy.ROSInterruptException: pass
