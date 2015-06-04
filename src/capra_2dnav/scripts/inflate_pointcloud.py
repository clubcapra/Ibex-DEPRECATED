1#!/usr/bin/env python

import rospy
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2
import math
import operator

rospy.init_node('inflate_pointcloud')

pub = rospy.Publisher(rospy.get_param('out_topic', 'cloud_in'), PointCloud2, queue_size=10)
n = rospy.get_param('count', 5)
res = 0.2
angle = math.pi * 2 / n
deltas = [[math.cos(angle * i) * res, math.sin(angle * i) * res, 0] for i in range(0, n)]

def handle_pointcloud(msg):
    results = []
    points = pc2.read_points(msg)
    
    for x, y, z in points:
        results.extend([[x + a, y + b, z + c] for a, b, c in deltas])

    pub.publish(pc2.create_cloud_xyz32(msg.header, results))


rospy.Subscriber(rospy.get_param('in_topic', 'cloud_in_raw'), PointCloud2, handle_pointcloud)

rospy.spin()
