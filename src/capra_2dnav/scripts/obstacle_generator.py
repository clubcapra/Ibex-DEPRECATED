#! /usr/bin/env python


import rospy
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import PointCloud2
from capra_msgs.srv import GenerateObstacle
from std_msgs.msg import Bool
from math import *
import numpy as np
import threading
import tf

class PointcloudGenerator:
    obs_index = 0
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
            self.obstacle_handlers[req.type.lower()](req.params, req.duration)
            return []
        else:
            rospy.logerr("Unrecognized obstacle type {}".format(req.type))
            return []



    def send_circle(self, params, duration):
        # params [radius, start_rad, end_rad, step_rad]
        radius = params[0]
        start_rad = params[1]
        end_rad = params[2]
        step_rad = params[3]
        cloud = []

        for i in np.arange(start_rad, end_rad, step_rad, dtype=float): # original range ==> np.arange(pi/4, 2 * pi - pi/4, pi/270.0, dtype=float):
            cloud.append([radius * cos(i), radius * sin(i), 0.0])

        t = threading.Thread(target=self.send_cloud, args=(cloud, duration,))
        t.start()

    def send_bar(self, params, duration):
        # params [length, distance from robot]
        l = params[0]
        d = params[1]
        cloud = []
        for i in np.arange(-l/2.0, l/2.0, 0.1, dtype=float):
            cloud.append([d, i, 0])

        t = threading.Thread(target=self.send_cloud, args=(cloud, duration,))
        t.start()

    def send_cloud(self, cloud, duration):
        ref_frame = '/base_footprint'
        self.obs_index += 1
        obstacle_frame = "/obs{}".format(self.obs_index)

        (trans, rotQ) = self.tf_listener.lookupTransform("/odom", ref_frame, rospy.Time(0))


        pcloud = PointCloud2()
        rospy.loginfo("Publishing obstacle on frame {} for {}s and exiting".format(obstacle_frame, duration))
        r = rospy.Rate(10)
        start_time = rospy.get_time()

        while not rospy.is_shutdown() and (duration == -1 or (rospy.get_time() - start_time) <= duration):
            self.br.sendTransform(trans,rotQ,rospy.Time.now(), obstacle_frame, "/odom")
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





