#!/usr/bin/env python

import rospy
import roslib
import rosbag
import json
import math
import os


class PathWaypointGenerator():

    def __init__(self, topics=['/odom']):
        rospy.init_node("capra_ai")
        self.topics = topics
        self.path = rospy.get_param("~input_bag_file")
        self.precision = rospy.get_param("~waypoint_interval")
        self.json_output = rospy.get_param("~output_json_location")



    def generate(self):
        bag = rosbag.Bag(self.path)
        waypoints = self.get_waypoints(bag, self.precision)
        bag.close()
        jsonf = os.path.splitext(os.path.basename(self.path))[0] + '.json'
        with open(os.path.join(self.json_output, jsonf), 'w') as fw:
            json.dump(waypoints, fw)

    def distance_between(self, x1, x2, y1, y2):
        return math.sqrt((x1 - x2)**2 + (y1 - y2)**2)

    def get_waypoints(self, bag, precision):
        supplies = bag.read_messages(topics=self.topics)
        waypoints = []
        try:
            topic, msg, t = supplies.next()
            p = msg.pose.pose.position
            previous = p
            waypoints.append({'x':p.x, 'y': p.y, 'gps':0, 'priorite':0})
        except StopIteration:
            return waypoints

        for topic, msg, t in supplies:
            p = msg.pose.pose.position
            lp = waypoints[-1]
            if self.distance_between(lp['x'], p.x, lp['y'], p.y) >= precision:
                waypoints.append({'x':p.x, 'y': p.y, 'gps':0, 'priorite':0})

        return waypoints




if __name__ == "__main__":
    g = PathWaypointGenerator()
    g.generate()