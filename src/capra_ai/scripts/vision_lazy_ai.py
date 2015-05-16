#! /usr/bin/env python

from base_ai import BaseAI
import math
from sensor_msgs.msg import PointCloud2
import numpy as np
import rospy
import sensor_msgs.point_cloud2 as pc2


class VisionLazyAI(BaseAI):
    _pointcloud = None
    def __init__(self):
        super(VisionLazyAI, self).__init__("vision_lazy_ai")

        rospy.Subscriber('/cloud_vision', PointCloud2, self._cloud_callback)

        self.set_frequency(self.get_param("~rate", 10))


        #Les angles ou le robot peut aller
        self.priority_angles = [int(v.strip()) for v in self.get_param("~priority_angles", "0, 5, -5, 10, -10, 20, -20, 30, -30, 40, -40, 50, -50, 60, -60").split(",")]
        #La taille de la carte generee (en m). Le robot est au milieu.
        self.map_size = self.get_param("~map_size", 6.0)
        #La resolution de la carte generee
        self.map_resolution = self.get_param("~map_resolution", 0.01)
        #Le rayon du cercle de verification (pour savoir si le robot passe)
        self.robot_radius = self.get_param("~robot_radius", 0.6)
        #La distance par rapport au range finder ou le cercle est deplace
        self.displacement_check = self.get_param("~displacement_check", 0.6)
        #La vitesse du robot
        self.speed = self.get_param("~speed", 0.8)

        self.size = int(math.ceil(self.map_size / self.map_resolution))
        self.max_dist = self.map_size / 2.0
        self.robot_area = self.create_circle(int(self.robot_radius/self.map_resolution), (int(self.size/2.0), int(self.size/2.0)))
        self.previous_time = rospy.get_time()

    @staticmethod
    def find_dist(dist, angle):
        x = dist * math.cos(angle)
        y = dist * math.sin(angle)

        return x, y

    @staticmethod
    def create_circle(radius, center):
        circle = []
        for x in range(-radius, 1):
            for y in range(-radius, 1):
                if x * x + y * y < radius * radius:
                    circle.append((x + center[0], y + center[1]))
                    circle.append((-x + center[0], y + center[1]))
                    circle.append((x + center[0], -y + center[1]))
                    circle.append((-x + center[0], -y + center[1]))
        return circle


    @staticmethod
    def calculate_sum(mat, circle, center):
        s = 0
        for p in circle:
            x = p[0] + center[0]
            y = p[1] + center[1]
            s += mat[x][y]
        return s

    def _cloud_callback(self, msg):
        self._pointcloud = msg




    @staticmethod
    def distance_to_point(x, y):
        return math.sqrt(x**2 + y**2)

    @staticmethod
    def find_angular_point(x, y):
        return math.atan2(x, y)

    def run(self):
        while not rospy.is_shutdown() and self._scan is None:
            rospy.sleep(0.1)

        while not rospy.is_shutdown() and self._pointcloud is None:
            rospy.sleep(0.1)

        while not rospy.is_shutdown():
            self.loop()
            self._rate.sleep()


    def loop(self):
        cost = 0
        scan = self.get_scan()
        angle = scan.angle_min
        m = np.zeros((self.size, self.size))



        for point in pc2.read_points(self._pointcloud):
            x, y = point[0], point[1]
            if self.distance_to_point(x, y) >= 3.0:
                continue

            mx = int((x + self.max_dist) / self.map_resolution)
            my = int((y + self.max_dist) / self.map_resolution)
            m[mx][my] = 1

        for p in scan.ranges:
            if p < 3.0:
                if not (p < 1.0 and abs(angle) > math.pi / 2):
                    px, py = self.find_dist(p, angle)
                    x = int((px + self.max_dist) / self.map_resolution)
                    y = int((py + self.max_dist) / self.map_resolution)
                    m[x][y] = 1

            angle += scan.angle_increment

        for angle in self.priority_angles:
            angle = math.radians(angle)
            disp_x = int((self.displacement_check * math.cos(angle))/self.map_resolution)
            disp_y = int((self.displacement_check * math.sin(angle))/self.map_resolution)
            cost = self.calculate_sum(m, self.robot_area, (disp_x, disp_y))
            if cost <= 1.0:
                break

        if cost <= 1:
            self.set_velocity(self.speed * math.cos(angle), self.speed * math.sin(angle))
        else:
            self.set_velocity(0, self.speed)



try:
    ai = VisionLazyAI()
    ai.run()
except rospy.ROSInterruptException:
    pass