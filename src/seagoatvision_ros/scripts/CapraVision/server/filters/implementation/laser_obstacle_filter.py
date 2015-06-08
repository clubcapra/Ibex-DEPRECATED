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
        self.scan = None
        self.size = (0, 0)
        self.res = (0, 0)
        self.trans = [0, 0]

        rospy.Subscriber('/scan_5m', LaserScan, self.handle_cloud)

    def execute(self, image):
        height, width = image.shape[:2]
        self.trans[0] = width / 2.0
        self.trans[1] = self.bottomy.get_current_value()
        self.res = width / 5.0, height / 5.0

        if self.scan is None:
            return image

        angles = np.arange(self.scan.angle_min, self.scan.angle_max, self.scan.angle_increment)

        current = []
        obstacles = []
        min_angle, max_angle = 1231324, -3212134

        for i in range(len(angles)):
            angle = angles[i]
            r = self.scan.ranges[i]

            if isnan(r):
                if len(current) > 0:
                    obstacles.append(current)
                    current = []
                    min_angle, max_angle = 1231324, -3212134
            else:
                current.append(i)

        if len(current) > 0:
            obstacles.append(current)
            

        for obstacle in obstacles:
            a, b = obstacle[0], obstacle[-1]

            print ('(%f, %f)' % (angles[a], self.scan.ranges[a]))

            p1 = cos(angles[a]) * self.scan.ranges[a], sin(angles[a]) * self.scan.ranges[a]
            p2 = cos(angles[b]) * self.scan.ranges[b] - 0.440, sin(angles[b]) * self.scan.ranges[b] 
            #  0.440 :: height of laser

            if not (isnan(p1[0]) or isnan(p1[1]) or isnan(p2[0]) or isnan(p2[1])):
                p1_pix = self.meters_to_pixels(*p1)
                p2_pix = self.meters_to_pixels(*p2)

                cv2.rectangle(image, p1_pix, (p2_pix[0], p2_pix[1] + 5), (255, 0, 0), -1)

        return image
        
    def handle_cloud(self, msg):
        self.scan = msg

    def meters_to_pixels(self, x, y):
        return (int(self.trans[0] - y * self.res[0]), int(self.trans[1] - x * self.res[1] + 1.255 * self.res[1]))

        


