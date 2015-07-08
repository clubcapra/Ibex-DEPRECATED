#! /usr/bin/env python

from base_ai import BaseAI
import math
import numpy as np


class LazyAI(BaseAI):

    def __init__(self):
        super(LazyAI, self).__init__("lazy_ai")
        #Les angles ou le robot peut aller (A gauche seulement dans cet AI)
        self.priority_angles = [int(v.strip()) for v in self.get_param("~priority_angles", "0, 10, -10,  20, -20, 30, -30, 40, -40, 50, -50, 60, -60").split(",")]
        #La taille de la carte generee (en m). Le robot est au milieu.
        self.map_size = self.get_param("~map_size", 6.0)
        #La resolution de la carte generee
        self.map_resolution = self.get_param("~map_resolution", 0.01)
        #Le rayon du cercle de verification (pour savoir si le robot passe)
        self.robot_radius = self.get_param("~robot_radius", 0.7)
        #La distance par rapport au range finder ou le cercle est deplace
        self.displacement_check = self.get_param("~displacement_check", 0.6)
        #La vitesse du robot
        self.speed = self.get_param("~speed", 0.5)

        self.size = int(math.ceil(self.map_size / self.map_resolution))
        self.max_dist = self.map_size / 2.0
        self.robot_area = self.create_circle(int(self.robot_radius/self.map_resolution), (int(self.size/2.0), int(self.size/2.0)))

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

    def loop(self):
        m = np.zeros((self.size, self.size))
        cost = 0
        scan = self.get_scan()
        angle = scan.angle_min

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


ai = LazyAI()
ai.run()
