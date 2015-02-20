#! /usr/bin/env python

import roslib; roslib.load_manifest('capra_lidar')
import rospy
import csv
from sensor_msgs.msg import LaserScan
import time
import math

rf_data = None
sg_data = None
new_data = False

def deg2rad(deg):
    return deg * math.pi / 180

angle_min = deg2rad(-135)
angle_max = deg2rad(135)
angle_increment = deg2rad(0.5) 
last_scan_time = None

def rf_callback(data):
    global rf_data
    global new_data
    rf_data = data
    new_data = True
    
def sg_callback(data):
    global sg_data
    global new_data
    sg_data = data
    new_data = True

def get_most_recent_timestamp(rf, sg):
    # Timestamp (on prend le plus recent)
    stamp = 0
    if rf:
        stamp = rf.header.stamp
    if sg:
        if sg.header.stamp > stamp:
            stamp = sg.header.stamp
    return stamp

def merge_scans(rf, sg):
    rf.ranges = list(rf.ranges)
    for i in range(40):
        rf.ranges[len(rf.ranges)-i-1] = 0

    if not sg:
        rf.header.frame_id = 'laser'
        return rf
    else:
        global angle_min
        global angle_max
        global angle_increment
        global last_scan_time
        if not last_scan_time:
            last_scan_time = time.time()

        scan = LaserScan()
        scan.header.frame_id = 'laser'
        scan.header.stamp = get_most_recent_timestamp(rf, sg)    
        scan.angle_min = angle_min
        scan.angle_max = angle_max
        scan.angle_increment = angle_increment
        scan.scan_time = time.time() - last_scan_time
        scan.time_increment = scan.scan_time / 541
        scan.range_min = rf.range_min
        scan.range_max = rf.range_max
        scan.ranges = rf.ranges
        for i in range(180*2):
            if sg.ranges[i] < scan.ranges[90 + i] or scan.ranges[90 + i] == 0:
                scan.ranges[90 + i] = sg.ranges[i]

    return scan

rospy.init_node('laser_scan_merger', anonymous=True)
pub = rospy.Publisher('/base_scan', LaserScan)
rospy.Subscriber("/scan", LaserScan, rf_callback)
rospy.Subscriber("/VisionScan", LaserScan, sg_callback)


while not rospy.is_shutdown():
    if new_data:
        scan = merge_scans(rf_data, sg_data)
        pub.publish(scan)
        new_data = False
    time.sleep(0.001)

rospy.spin()

