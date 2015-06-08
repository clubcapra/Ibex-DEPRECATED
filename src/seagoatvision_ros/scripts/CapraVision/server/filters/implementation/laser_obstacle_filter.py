import rospy
from sensor_msgs.msg import LaserScan
import numpy as np
from math import sin, cos, isnan
from CapraVision.server.filters.parameter import  Parameter
import cv2
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2


class LaserObstacleFilter:
    def __init__(self):
        self.bottomy = Parameter("Bottom Y", 0,734,73)
        self.resolution = Parameter("Resolution", 0, 500, 20)
        self.cloud = None

        rospy.Subscriber('/cloud_laser', PointCloud2, self.handle_cloud)

    def execute(self, image):
        if self.cloud is None:
            return image

        points = pc2.read_points(self.cloud)
        height, width = image.shape[:2]
        dw = width / 2.0
        dy = self.bottomy.get_current_value()

        resx, resy = width / 5.0, height / 5.0

        # pixels / m =  x / m
        # 

        # points = [[0, 0, 0], [0, -1, 0], [1, 0, 0], [0, 1, 0]]
        i = 0

        for p in points:
            x, y, z = p
            
            if isnan(x) or x ** 2 + y ** 2 > 5 ** 2: continue

            # print str((int(x * resx + dw), int(-y * resy + dy)))
            # cv2.rectangle(image, (int(x * resx + dw), int(-y * resy + dy)), (int(x * resx + dw + 5), int(-y * resy + dy + 5)), (255, 255, 0), -1)
            # cv2.rectangle(image, (int(x * resx + dw), int(-y * resy + dy)), (int(x * resx + dw + 5), int(-y * resy + dy + 5)), (255, 255, 0), -1)
            cv2.rectangle(image, (int(dw - y * resx), int(dy - x * resy + 1.255 * resy)), (int(dw - y * resx + 5), int(dy - x * resy + 5 + 1.255 * resy)), (255, i * 85 % 255, 0), -1)
            # print str( (int(x + dw), int(-y + dy)))

            i += 1

        return image
        
    def handle_cloud(self, msg):
        self.cloud = msg


        

            
