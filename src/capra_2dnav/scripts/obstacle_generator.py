#! /usr/bin/env python


import rospy
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import PointCloud2
from math import *
import numpy as np
import tf

class PointcloudGenerator:

    def __init__(self):

        rospy.init_node('pointcloud_generator')
        rospy.wait_for_service('/octomap_server/reset')
        rospy.sleep(0.2)

        pub_cloud = rospy.Publisher("/cloud_in", PointCloud2, queue_size=10)

        r = rospy.Rate(10)
        pcloud = PointCloud2()
        cloud = []

        radius = 3.0

        for i in np.arange(pi/4, 2 * pi - pi/4, pi/270.0, dtype=float):
            cloud.append([radius * cos(i), radius * sin(i), 0.0])

        count = 25
        rospy.loginfo("Publishing obstacle %d times and exiting".format(count))
        i = 0
        while not rospy.is_shutdown() and i < count:
            pcloud = pc2.create_cloud_xyz32(pcloud.header, cloud)
            pcloud.header.frame_id = "base_footprint"
            pub_cloud.publish(pcloud)
            i += 1
            r.sleep()

        rospy.loginfo("Exiting")

if __name__ == "__main__":
    try:
        s = PointcloudGenerator()
    except rospy.ROSInterruptException:
        pass
