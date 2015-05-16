#! /usr/bin/env python


import rospy
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import PointCloud2
from capra_msgs.srv import GenerateObstacle
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
        #rospy.Subscriber("/obstacle_generator/generate_circle", Bool, self.circle_callback)
       # rospy.Subscriber("/obstacle_generator/generate_bar", Bool, self.bar_callback)

        self.service = rospy.Service('/obstacle_generator', GenerateObstacle, self.handle_obstacle_generation)

        self.tf_listener = tf.TransformListener()
        self.br = tf.TransformBroadcaster()
        self.send_duration_in_seconds = rospy.get_param("~send_duration_in_seconds", 1)
        self.obstacle_handlers = {
            "circle": self.send_circle,
            "bar": self.send_bar
        }
        rospy.sleep(2.0)
        #self.send_circle()
        rospy.spin()

    def handle_obstacle_generation(self, req):
        if self.obstacle_handlers.has_key(req.type.lower()):
            rospy.loginfo("Handling obstacle generation request for {} with params {}".format(req.type, req.params))
            self.obstacle_handlers[req.type.lower()](req.params)
            return []
        else:
            rospy.logerr("Unrecognized obstacle type {}".format(req.type))
            return []


    def send_circle(self, params):
        # params [radius, start_rad, end_rad, step_rad]
        radius = params[0]
        start_rad = params[1]
        end_rad = params[2]
        step_rad = params[3]
        cloud = []

        for i in np.arange(start_rad, end_rad, step_rad, dtype=float): # original range ==> np.arange(pi/4, 2 * pi - pi/4, pi/270.0, dtype=float):
            cloud.append([radius * cos(i), radius * sin(i), 0.0])

        self.send_cloud(cloud)

    def send_bar(self, params):
        # params [length, distance from robot]
        l = params[0]
        d = params[1]
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
        rospy.loginfo("Publishing obstacle for {}s and exiting".format(self.send_duration_in_seconds))
        r = rospy.Rate(10)
        start_time = rospy.get_time()

        while not rospy.is_shutdown() and (rospy.get_time() - start_time) <= self.send_duration_in_seconds:
            pcloud = pc2.create_cloud_xyz32(pcloud.header, cloud)
            pcloud.header.frame_id = obstacle_frame
            self.pub_cloud.publish(pcloud)
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





