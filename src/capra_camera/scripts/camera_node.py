#!/usr/bin/env python
# coding=utf-8

import roslib
roslib.load_manifest('capra_camera')
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
import cv2
from includes.OutputGrabber import OutputGrabber


class CameraNode:
    def __init__(self):
        # Loading library.
        rospy.init_node('capra_camera')
        if not self._load_camera():
            rospy.logerr("Cannot open PvCamera. Missing camera library.")
            return

        # CvBridge to convert the opencv image to a ros image.
        self.bridge = CvBridge()

        # Initialize camera.
        rospy.loginfo("Initializing camera")
        initialized = False
        error_printed = False
        while not initialized and not rospy.is_shutdown():
            initialized = self._initialize_camera()
            if not initialized and not error_printed:
                error_printed = True
                rospy.logerr("Could not initialize camera. Retrying...")
        rospy.loginfo("Camera initialized.")

        # Ros topic and topic rate.
        self.image_pub = rospy.Publisher("~image_uncompressed", Image, queue_size=10)
        rate = rospy.Rate(20)

        while not rospy.is_shutdown():
            self.image_pub.publish(self._get_last_image())
            rate.sleep()

    def _get_last_image(self):
        image = self.images[self.camera.getFrame()]
        # Utiliser l'image full size cause parfois des barres dans l'image. c'est peut-être causé par le fait que le
        # publish envoie l'image et qu'un process asynchrone de ROS utilise termine l'envoi de l'image APRÈS qu'on
        # ait callé un getFrame de nouveau. Le getFrame bloque l'image jusqu'au prochain call getFrame, mais dans le
        # cas décrit, l'image serait débloquée avant que ROS ait terminé de la publier. Il faudrait donc en faire une
        # copie et publier cette copie pour être sur qu'elle ne se fera pas overwritée.
        small = cv2.resize(image, (0,0), fx=0.5, fy=0.5)
        return self.bridge.cv2_to_imgmsg(small, "bgr8")

    def _load_camera(self):
        try:
            import camera
            with OutputGrabber():
                self.camera = camera.Camera()
            return True
        except:
            return False

    def _initialize_camera(self):
        try:
            with OutputGrabber():
                self.camera.initialize()
            self.camera.start()
            self.images = self.camera.getCam()
            return True
        except RuntimeError:
            return False

node = CameraNode()