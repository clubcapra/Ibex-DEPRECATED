#!/usr/bin/env python

import rospy
from tf.transformations import *

from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Quaternion, PoseStamped, Pose, Point
from nav_msgs.msg import Odometry

import math
import numpy as np
# LA NODE NE MARCHE PAS COMPLETEMENT. Le dev a ete arrete parce que ca causait un delai.

'''
This node removes measures that are too close on the extremes of the lidar view to avoid seeing the robot.
It also removes single points that don't have any neighbours
'''
def scan_cb(msg):

    new_scan = msg
    new_ranges = []

    proximity_angle_check = math.radians(30)
    poximity_limit = 0.2

    neighbour_min_dist = 1.0 #if a point does not have neighbours within that distance, we remove it

    for i in range(0, len(msg.ranges)):
        new_val = msg.range_max
        if i * msg.angle_increment < proximity_angle_check or msg.angle_max - (i * msg.angle_increment) < proximity_angle_check:
            new_val = get_filtered_dist(msg.ranges[i], poximity_limit, msg.range_max)
        else:
            new_val = msg.ranges[i]

        if i > 0 and i < len(msg.ranges)-1:
            if abs(msg.ranges[i] - msg.ranges[i-1]) > neighbour_min_dist or abs(msg.ranges[i] - msg.ranges[i+1])  > neighbour_min_dist:
                new_val = msg.range_max

        new_ranges.append(new_val)

    new_scan.ranges = new_ranges
    pub_scan.publish(new_scan)


def get_filtered_dist(ray_dist, limit, max):
    if ray_dist < limit:
        return max
    else:
        return ray_dist

if __name__ == "__main__":
    rospy.init_node('capra6_lidar_filter')
    global pub_scan
    pub_scan = rospy.Publisher("/scan_out", LaserScan, queue_size=10)
    rospy.Subscriber("/scan_in", LaserScan, scan_cb)
    rospy.spin()