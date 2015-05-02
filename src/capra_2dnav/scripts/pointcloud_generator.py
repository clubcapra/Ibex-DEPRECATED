#! /usr/bin/env python


import rospy
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import PointCloud2
import tf

class PointcloudGenerator:

    def __init__(self):

        rospy.init_node('pointcloud_generator')
        pub_cloud = rospy.Publisher('/cloud_in', PointCloud2, queue_size=10)

        s = rospy.get_param('~size', 26)
        r = rospy.Rate(10)
        pcloud = PointCloud2()

        cloud = [[s, s, 0], [-s, -s, 0]]
        print cloud

        while not rospy.is_shutdown():

            pcloud = pc2.create_cloud_xyz32(pcloud.header, cloud)
            pcloud.header.frame_id = 'odom'
            pub_cloud.publish(pcloud)
            r.sleep()

if __name__ == "__main__":
    try:
        s = PointcloudGenerator()
    except rospy.ROSInterruptException:
        pass
