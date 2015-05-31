#!/usr/bin/env python

import rospy
from sensor_msgs.msg import LaserScan
from math import *

def scan_cb(msg):
    new_range = []
    new_intens = []
    for i in range(len(msg.ranges)):
        if msg.ranges[i] < 0.001 or isnan(msg.ranges[i]):
            new_range.append(19.0)
            new_intens.append(500.0)
        else:
            new_range.append(msg.ranges[i])
            new_intens.append(msg.intensities[i])
    msg.ranges = new_range
    msg.intensities = new_intens
    pub_scan.publish(msg)

if __name__ == "__main__":
    rospy.init_node('max_range')
    max_range = rospy.get_param("~max_range", 20)
    pub_scan = rospy.Publisher("/scan_out", LaserScan, queue_size=10)
    rospy.Subscriber("/scan_in", LaserScan, scan_cb)
    rospy.spin()