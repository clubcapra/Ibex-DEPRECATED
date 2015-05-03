#!/usr/bin/env python

import rospy
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2

rospy.init_node('inflate_pointcloud')

res = 0.2
pub = rospy.Publisher(rospy.get_param('out_topic', 'cloud_in'), PointCloud2, queue_size=10)


def handle_pointcloud(msg):
    results = []
    points = pc2.read_points(msg)

    for x, y, z in points:
        results.extend([[x + res * i, y + res * j, z] for i in [-1, 0, 1] for j in [-1, 0, 1]])

    pub.publish(pc2.create_cloud_xyz32(msg.header, results))


rospy.Subscriber(rospy.get_param('in_topic', 'cloud_in_raw'), PointCloud2, handle_pointcloud)

rospy.spin()
