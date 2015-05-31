#!/usr/bin/env python

import rospy
from sensor_msgs.msg import LaserScan


def scan_cb(msg):
    for i in range(len(msg.ranges)):
        if msg.ranges[i] == 0:
            msg.ranges[i] = max_range
    pub_scan.publish(msg)

if __name__ == "__main__":
    rospy.init_node('max_range')
    max_range = rospy.get_param("~max_range", 20)
    pub_scan = rospy.Publisher("/scan_out", LaserScan, queue_size=10)
    rospy.Subscriber("/scan_in", LaserScan, scan_cb)
    rospy.spin()