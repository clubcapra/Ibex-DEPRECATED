#!/usr/bin/env python

import rospy
from sensor_msgs.msg import LaserScan, Image
import numpy as np
from math import sin, cos, isnan, pi
import cv2
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2
from cv_bridge import CvBridge
from dynamic_reconfigure.server import Server
from capra_filters.cfg import ObstacleFilterConfig


class ObstacleFilter:
    def __init__(self):
        rospy.init_node('obstacle_filter', log_level=rospy.DEBUG)

        self.bottomy = 133
        self.realy = 258
        self.resolution = 20
        self.scan = None
        self.size = (0, 0)
        self.res = (0, 0)
        self.trans = [0, 0]
        self.x = 0
        self.bridge = CvBridge()
        self.pub = rospy.Publisher('/image_out', Image, queue_size=10)

        srv = Server(ObstacleFilterConfig, self.configure)

        rospy.Subscriber('/scan', LaserScan, self.handle_cloud)
        rospy.Subscriber('/image_raw', Image, self.execute)

        rospy.spin()

    def configure(self, config, level):
        self.bottomy = config.bottomy
        self.realy = config.realy
        self.x = config.x
        self.dn_d = config.dn_d

        return config

    def execute(self, msg):
        image = self.bridge.imgmsg_to_cv2(msg, "bgr8")
        height, width = image.shape[:2]
        self.trans[0] = width / 2 + self.x
        self.trans[1] = int(self.bottomy)
        self.res = width / 5.0, height / 5.0

        if self.scan is None:
            return image

        angles = np.arange(self.scan.angle_min, self.scan.angle_max, self.scan.angle_increment)

        current = []
        obstacles = []
        trans_real = np.array([self.trans[0], self.realy])

        for i in range(len(angles)):
            angle = angles[i]
            r = self.scan.ranges[i]

            if isnan(r) or r > 5:
                if len(current) > 0:
                    obstacles.append(current)
                    current = []
            else:
                    angles = np.arange(self.scan.angle_min, self.scan.angle_max, self.scan.angle_increment)

        current = []
        obstacles = []
        trans_real = np.array([self.trans[0], self.realy])

        for i in range(len(angles)):
            angle = angles[i]
            r = self.scan.ranges[i]

            if isnan(r) or r > 5:
                if len(current) > 0:
                    obstacles.append(current)
                    current = []
            else:
                current.append(i)

        if len(current) > 0:
            obstacles.append(current)

        for obstacle in obstacles:
            a, b = obstacle[0], obstacle[-1]

            # filter out obstacles that are ~5 degrees wide

            if isnan(self.scan.ranges[a]) or isnan(self.scan.ranges[b]): continue
            if abs(angles[a] - angles[b]) < 0.0872664626: continue

            laser_height = 0.44
            obstacle_height = 1
            ang = 0.17

            dn_d = self.dn_d
            dn_1 = sin(angles[a] + 2 * pi) * dn_d
            dn_2 = sin(angles[a] + 2 * pi) * dn_d

            p1 = np.array([cos(angles[a] - ang + dn_1) * self.scan.ranges[a], sin(angles[a] - ang + dn_1) * self.scan.ranges[a]])
            p2 = np.array([cos(angles[b] + ang + dn_2) * self.scan.ranges[b], sin(angles[b] + ang + dn_2) * self.scan.ranges[b]])

            if np.any(np.isnan(p1)): continue
            if np.any(np.isnan(p2)): continue

            p1_m = self.meters_to_pixels(*p1)
            p2_m = self.meters_to_pixels(*p2)

            cv2.rectangle(image, (self.trans[0], self.trans[1]), (self.trans[0] + 10, self.trans[1] + 10), (0, 0, 255))
            cv2.rectangle(image, (int(trans_real[0]), int(trans_real[1])), (int(trans_real[0] + 10), int(trans_real[1] + 10)), (0, 255, 255))

            d1 = p1_m - trans_real
            d2 = p2_m - trans_real

            k = 5
            m1 = d1 * k + p1_m
            m2 = d2 * k + p2_m

            cv2.fillPoly(image, [np.array([
                p1_m.astype(int),
                m1.astype(int),
                m2.astype(int),
                p2_m.astype(int)
            ])], (0, 0, 0))

            for obs in obstacle:
                angle, r = angles[obs], self.scan.ranges[obs]

                if isnan(r): continue

                x, y = cos(angle) * r, sin(angle) * r
                px, py = self.meters_to_pixels(x, y)

                cv2.rectangle(image, (px, py), (px + 5, py + 5), (0, 255, 0))

        out = self.bridge.cv2_to_imgmsg(image, "bgr8")
        out.header = msg.header
        self.pub.publish(out)

    def handle_cloud(self, msg):
        self.scan = msg

    def meters_to_pixels(self, x, y):
        return np.array([int(self.trans[0] - y * self.res[0]), int(self.trans[1] - x * self.res[1])])


if __name__ == '__main__':
    ObstacleFilter()
