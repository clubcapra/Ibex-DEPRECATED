#!/usr/bin/env python

import cv2
import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
import numpy as np

template = """
<launch>
  <arg name="nodelet_manager_name" />
  <node pkg="nodelet" ns="capra_filters" name="perspective_calibration" type="nodelet" args="load capra_filters/warp_perspective /$(arg nodelet_manager_name)">
    <param name="a" value="{}" />
    <param name="b" value="{}" />
    <param name="c" value="{}" />
    <param name="d" value="{}" />
    <param name="e" value="{}" />
    <param name="f" value="{}" />
    <param name="g" value="{}" />
    <param name="h" value="{}" />
    <param name="i" value="{}" />
    <param name="input" value="{}" />
    <param name="output" value="{}" />
    <param name="type" value="capra_filters/warp_perspective" />
  </node>
</launch>
"""

class PerspectiveCalibration():
    def __init__(self):
        rospy.init_node('perspective_calibration')

        self.bridge = CvBridge()
        self.width = rospy.get_param('~width', 8)
        self.height = rospy.get_param('~height', 5)
        self.samples = rospy.get_param('~samples', 10)
        self.input = rospy.get_param('~input', '')
        self.output = rospy.get_param('~output', '')
        self.index = 0
        self.chessboard_size = (self.width, self.height)
        self.calibrating = True
        self.target_points = []
        self.matrix = np.ndarray((3, 3))

        offset_y = 1 * 20

        for i in range(5):
            for j in range(8):
                self.target_points.append([[100 - i * 20 * 0.1 + 2 * 20 * 0.1, 200 - offset_y - j * 20 * 0.1]])

        rospy.Subscriber('/image_raw', Image, self.handle_image)

        while self.calibrating:
            if rospy.is_shutdown():
                return

        self.matrix = self.matrix / self.samples

        print template.format(*map(repr, self.matrix.flatten().tolist()) + [self.input, self.output])


    def handle_image(self, msg):
        cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")

        if self.index < self.samples:
            found, rect = cv2.findChessboardCorners(cv_image, self.chessboard_size)

            if found and self.index < self.samples:

                target_points = np.array(self.target_points, dtype=np.float32)
                h, _ = cv2.findHomography(rect, np.array(target_points))

                self.matrix += h
                self.index += 1
        else:
            self.calibrating = False


if __name__ == '__main__':
    PerspectiveCalibration()
