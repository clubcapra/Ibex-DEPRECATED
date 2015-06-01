#! /usr/bin/env python


import rospy
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import PointCloud2
import tf

class PointcloudGenerator:

    def __init__(self):

        rospy.init_node('pointcloud_generator')
        pub_cloud = rospy.Publisher("~/cloud", PointCloud2, queue_size=10)

        r = rospy.Rate(10)
        pcloud = PointCloud2()
        cloud = [[1.0,-0.5,0],[2.0,-0.5,0],[3.0,-0.5,0],
                 [1.0,0.5, 0],[2.0,0.5, 0],[3.0, 0.5,0]]

        while not rospy.is_shutdown():

            pcloud = pc2.create_cloud_xyz32(pcloud.header, cloud)
            pcloud.header.frame_id = "base_footprint"
            pub_cloud.publish(pcloud)
            r.sleep()

if __name__ == "__main__":
    try:
        s = PointcloudGenerator()
    except rospy.ROSInterruptException:
        pass
