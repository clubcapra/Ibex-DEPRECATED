#!/usr/bin/env python

import cv2
import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError


class PerspectiveCalibration():
    def __init__(self):
        rospy.init_node('perspective_calibration')

        self.bridge = CvBridge()
        self.width = rospy.get_param('~width', 8)
        self.height = rospy.get_param('~height', 5)
        self.chessboard_size = (self.width, self.height)

        rospy.Subscriber('/image_raw', Image, self.handle_image)
        self.pub = rospy.Publisher('/image_rect', Image, queue_size=10)

        rospy.spin()

    def handle_image(self, msg):
        cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")

        found, rect = cv2.findChessboardCorners(cv_image, self.chessboard_size)
        cv2.drawChessboardCorners(cv_image, self.chessboard_size, rect, found)

        self.pub.publish(self.bridge.cv2_to_imgmsg(cv_image, "bgr8"))


if __name__ == '__main__':
    PerspectiveCalibration()
