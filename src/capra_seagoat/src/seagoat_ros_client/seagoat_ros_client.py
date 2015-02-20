#! /usr/bin/env python

import rospy
import math
import numpy
import cv2
from cv_bridge import CvBridge

from sensor_msgs.msg import LaserScan
from sensor_msgs.msg import Image

from std_msgs.msg import Header
from multiprocessing import Pool
from multiprocessing import cpu_count


class Line:
    def __init__(self, points):
        assert isinstance(points, list)
        self.points = points


class SeaGoatRosClient:
    def __init__(self):

        self.publisher = rospy.Publisher('VisionScan', LaserScan)
        self.subscriber = rospy.Subscriber('ImageArray', Image, self.image_callback)
        rospy.init_node('SeaGoatRosClient')
        self.r = rospy.Rate(15)
        self.vision_raw_scan = numpy.array([[0, 0, 0, 0], [0, 0, 0, 0], [1, 1, 1, 1], [0, 0, 0, 0]])

        #Init lines intersect

        self.range_max = 0
        self.angle_max = math.radians(180.0)
        self.angle_increment = math.radians(0.5)
        self.number_lines = int(self.angle_max/self.angle_increment)+1

        self.init = False
        self.max_pixel_dist = 0
        self.pool = Pool(cpu_count()/2)
        self.resolution = 3.0
        self.image_height_centimeter = 300

        #self._init_lines()
        self.tasks = list()

        self.id = 0
        print self.vision_raw_scan

    def publish_loop(self):
        while not rospy.is_shutdown():
            vision_scan = self.convert_array_to_laser_scan(self.vision_raw_scan)
            if vision_scan is not None:
                self.publisher.publish(vision_scan)
            self.r.sleep()

    def convert_array_to_laser_scan(self, vision_raw_scan):

        if vision_raw_scan.size < 100:
            return None

        header = Header()
        header.frame_id = "vision_scan"
        #header.stamp = time()

        laser_scan = LaserScan()
        laser_scan.angle_min = 0.0
        laser_scan.angle_max = self.angle_max
        laser_scan.angle_increment = self.angle_increment
        laser_scan.range_min = 0.0
        laser_scan.range_max = self.range_max
        #laser_scan.ranges = [0]*360

        image_size = vision_raw_scan.shape

        if len(image_size) == 3:
            vision_raw_scan = cv2.cvtColor(vision_raw_scan, cv2.COLOR_BGR2GRAY)
            image_size = vision_raw_scan.shape

        if self.init is False:
            self._init_lines(image_size)
            self.init = True


        tasks = list()
        for line in range(self.number_lines):
            tasks.append((vision_raw_scan, self.lines[line]))

        laser_scan.ranges = self.pool.map(_getObstacle, tasks)

        #pool.close()
        laser_scan.header = header
        #laser_scan.scan_time = 1.0/5.0
        #laser_scan.time_increment = 1.0/5.0
        return laser_scan

    def image_callback(self, msg):
        image = CvBridge().imgmsg_to_cv2(msg)
        self.vision_raw_scan = numpy.asanyarray(image)
        #cv2.imshow("Image", image)
        #cv2.waitKey(10)

    def _init_lines(self, image_size):
        origin_x = int(image_size[1] / 2)
        origin_y = (image_size[0] - 1)-50

        current_angle = 0

        self.centimeter_by_pixel= float(self.image_height_centimeter)/float(image_size[0])
        self.max_points = int(math.sqrt(math.pow(image_size[0], 2) + math.pow(image_size[1], 2)))

        self.lines = numpy.ndarray((self.number_lines, self.max_points, 3), dtype=int)

        for line_id in range(self.number_lines):
            current_x = origin_x
            current_y = origin_y
            current_pixel_dist = 0

            line = self.lines[line_id]
            point_id = -1

            while current_x < image_size[1] and current_y < image_size[0] and current_x >= 0 and current_y >= 0:
                if (current_pixel_dist > 0):
                    point = line[point_id]
                    point[0] = current_x
                    point[1] = current_y
                    point[2] = int(current_pixel_dist*self.centimeter_by_pixel)
                    if point[2] > self.range_max:
                        self.range_max = point[2]

                current_pixel_dist += self.resolution
                current_x = int(current_pixel_dist * math.cos(current_angle)) + origin_x
                current_y = int(current_pixel_dist * math.sin(-1 * current_angle)) + origin_y
                point_id += 1

            if point_id < self.max_points:
                end_point = line[point_id]
                end_point[0] = -1
                end_point[1] = -1
                end_point[2] = -1

            #self.lines = self.lines + (line,)
            #self.tasks.append(list([self.vision_raw_scan, line]))
            current_angle += self.angle_increment

def _getObstacle(args):
    #line = lines[i]
    image = args[0]
    line = args[1]
    for point_id in range(len(line)):
        point = line[point_id]
        if point[0] == -1 and point[1] == -1 and point[2] == -1:
            break
        if image[point[1]][point[0]] > 0:
            return float(point[2])/100.0
    return 0.0


if __name__ == '__main__':
    sgrc = SeaGoatRosClient()
    sgrc.publish_loop()