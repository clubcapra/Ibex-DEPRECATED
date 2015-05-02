#! /usr/bin/env python


import rospy
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import PointCloud2
from std_msgs.msg import Bool
from math import *
import numpy as np
import tf

class PointcloudGenerator:

    def __init__(self):

        rospy.init_node('pointcloud_generator')
        rospy.wait_for_service('/octomap_server/reset')
        rospy.sleep(0.2)

        self.pub_cloud = rospy.Publisher("/cloud_in", PointCloud2, queue_size=10)
        rospy.Subscriber("/obstacle_generator/generate_circle", Bool, self.circle_callback)
        rospy.Subscriber("/obstacle_generator/generate_bar", Bool, self.bar_callback)

        self.tf_listener = tf.TransformListener()
        self.br = tf.TransformBroadcaster()

        rospy.sleep(2.0)
        self.send_circle()

        rospy.spin()

    def send_circle(self):

        radius = 3.0
        cloud = []

        for i in np.arange(pi/4, 2 * pi - pi/4, pi/270.0, dtype=float):
            cloud.append([radius * cos(i), radius * sin(i), 0.0])

        self.send_cloud(cloud)

    def send_bar(self):
        l = 8.0
        d = -1.0
        cloud = []
        for i in np.arange(-l/2.0, l/2.0, 0.1, dtype=float):
            cloud.append([d, i, 0])

        self.send_cloud(cloud)

    def send_cloud(self, cloud):
        ref_frame = '/base_footprint'
        obstacle_frame = "/obs"

        (trans, rotQ) = self.tf_listener.lookupTransform("/odom", ref_frame, rospy.Time(0))
        self.br.sendTransform(trans,rotQ,rospy.Time.now(), obstacle_frame, "/odom")

        pcloud = PointCloud2()
        count = 50
        rospy.loginfo("Publishing obstacle {} times and exiting".format(count))
        i = 0
        r = rospy.Rate(10)
        while not rospy.is_shutdown() and i < count:
            pcloud = pc2.create_cloud_xyz32(pcloud.header, cloud)
            pcloud.header.frame_id = obstacle_frame
            self.pub_cloud.publish(pcloud)
            i += 1
            r.sleep()


    def circle_callback(self, msg):
        rospy.loginfo("generating circle")
        self.send_circle()

    def bar_callback(self, msg):
        rospy.loginfo("generating bar")
        self.send_bar()

if __name__ == "__main__":
    try:
        s = PointcloudGenerator()
    except rospy.ROSInterruptException:
        pass





