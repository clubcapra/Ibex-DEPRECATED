#!/usr/bin/env python

import rospy
from sensor_msgs.msg import PointCloud2
import sensor_msgs.point_cloud2 as pc2
import math

class Point:
    def __init__(self, x, y, dist=None, angle=None):
        self.x = x
        self.y = y
        self.dist = dist
        self.angle = angle

        if self.dist is None:
            self.dist = x**2 + y**2

        if self.angle is None:
            self.angle = math.atan2(y, x)
        

class Obstacle:
    def __init__(self):
        self.points = []
        
        # span of the ostable
        self.min_angle = math.pi
        self.max_angle = -math.pi
        
        # farthest point of the obstacle
        self.max_dist = 0  
    
    def add_point(self, point):
        self.points.append(point)

        if point.angle < self.min_angle:
            self.min_angle = point.angle

        if point.angle > self.max_angle:
            self.max_angle = point.angle

        if point.dist > self.max_dist:
            self.max_dist = point.dist

    def is_empty(self):
        return len(self.points) == 0

    def is_behind(self, point):
        """
        Checks if the point is behind the obstacle.
        To be considered so, the point's distance must be greater than the
        farthest point of the obstacle (self.max_dist) and its angle must be 
        between self.min_angle and self.max_angle.
        """
        return point.angle > self.min_angle and point.angle < self.max_angle and point.dist > self.max_dist
        

class ClearFalseLines:
    def __init__(self):
        rospy.init_node('clear_false_lines', log_level=rospy.DEBUG)

        self.last_scan = None
        self.last_image = None
        self.cloud_in = rospy.Publisher('/cloud_in', PointCloud2, queue_size=10)
        self.max_range = 19 ** 2

        rospy.Subscriber('/cloud_scan', PointCloud2, self.handle_scan)
        rospy.Subscriber('/cloud_image', PointCloud2, self.handle_image)

        rospy.spin()

    def handle_scan(self, msg):
        self.last_scan = msg
        self.process()

    def handle_image(self, msg):
        self.last_image = msg
        self.process()

    def process(self):
        if self.last_scan is None or self.last_image is None:
            return

        last_image = self.last_image
        last_scan = self.last_scan

        scan_pc = pc2.read_points(last_scan)
        image_pc = pc2.read_points(last_image)

        scan_obstacles = []
        tmp = Obstacle()

        # Enumerate the point cloud from the laser scan to group points that belongs
        # to the same obstacle.
        for x, y, _ in scan_pc:
            dist = x ** 2 + y ** 2

            # If it's in range, the point is considered to be part of the current obstacle
            if dist < self.max_range:
                tmp.add_point(Point(x, y, dist))
            else:
                if not tmp.is_empty():
                    scan_obstacles.append(tmp)
                    tmp = Obstacle()

        if not tmp.is_empty():
            scan_obstacles.append(tmp)

        if len(scan_obstacles) == 0:
            self.cloud_in.publish(last_image)
        else:
            image_points = []

            for x, y, z, _ in image_pc:
                point = Point(x, y)

                for obs in scan_obstacles:
                    if not obs.is_behind(point):
                        image_points.append((x, y, z))

            msg = pc2.create_cloud_xyz32(last_image.header, image_points)
            self.cloud_in.publish(msg)
            
        self.cloud_in.publish(last_scan)

        self.last_scan = None
        self.last_image = None
        


if __name__ == "__main__":
    try:
        ClearFalseLines()
    except rospy.ROSInterruptException:
        pass
