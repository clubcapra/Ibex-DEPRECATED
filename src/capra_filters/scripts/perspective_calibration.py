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
        self.square_size = rospy.get_param('~square_size', 0.1)
        self.samples = rospy.get_param('~samples', 100)
        self.debug = rospy.get_param('~debug', False)
        self.input = rospy.get_param('~input', '')
        self.output = rospy.get_param('~output', '')
        self.index = 0
        self.chessboard_size = (self.width, self.height)
        self.calibrating = True
        self.target_points = []
        self.matrix = np.ndarray((3, 3))
        self.attemps = 0

        offset_y = 0.7 * 20

        for i in range(self.height)[::-1]:
            for j in range(self.width):
                self.target_points.append([[100 - i * 20 * self.square_size + 2 * 20 * self.square_size, 200 - offset_y - j * 20 * self.square_size]])

        rospy.Subscriber('/image_raw', Image, self.handle_image)

        if self.debug:
            self.checkboard_pub = rospy.Publisher('/image_checkerboard', Image, queue_size=10)
            self.warped_pub = rospy.Publisher('/image_warped', Image, queue_size=10)

        while self.calibrating:
            if rospy.is_shutdown():
                return

        self.matrix = self.matrix / self.samples

        print template.format(*map(repr, self.matrix.flatten().tolist()) + [self.input, self.output])


    def handle_image(self, msg):
        cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")

        if self.index < self.samples:
            found, rect = cv2.findChessboardCorners(cv_image, self.chessboard_size)

            if found:
                self.attemps = 0
                target_points = np.array(self.target_points, dtype=np.float32)
                h, _ = cv2.findHomography(rect, np.array(target_points))

                print self.index

                if self.debug:

                    cv2.drawChessboardCorners(cv_image, self.chessboard_size, rect, found)
                    self.checkboard_pub.publish(self.bridge.cv2_to_imgmsg(cv_image, "bgr8"))

                    warped = cv2.warpPerspective(cv_image, h, (200, 200))

                    self.warped_pub.publish(self.bridge.cv2_to_imgmsg(warped, "bgr8"))

                else:
                    self.matrix += h
                    self.index += 1
            else:
                self.attemps += 1
        else:
            self.calibrating = False

        if self.attemps > 100:
            rospy.logwarn("No checkerboard found with 10 samples, the calibration is likely to fail.")


if __name__ == '__main__':
    PerspectiveCalibration()
