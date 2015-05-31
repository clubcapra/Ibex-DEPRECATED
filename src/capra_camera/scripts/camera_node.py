#!/usr/bin/env python
# coding=utf-8
from camera import AcquisitionMode

import roslib
roslib.load_manifest('capra_camera')
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
import cv2
from includes.OutputGrabber import OutputGrabber
from dynamic_reconfigure.server import Server
from capra_camera.cfg import CameraConfig
import camera # TODO: Remove

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

        # Parameters
        self.parameter_values = {}
        self.parameter_handlers = {'acquisition_mode': self.set_acquisition_mode,
                                   'exposure_auto_alg_mode': self.set_exposure_auto_alg_mode,
                                   'exposure_value': self.set_exposure_value,
                                   'exposure_auto_mode': self.set_exposure_auto_mode,
                                   'exposure_mode': self.set_exposure_mode,
                                   'gain_auto_mode': self.set_gain_auto_mode,
                                   'gain_mode': self.set_gain_mode,
                                   'gain_value': self.set_gain_value,
                                   'gamma': self.set_gamma,
                                   'hue': self.set_hue,
                                   'saturation': self.set_saturation,
                                   'white_balance_auto_mode': self.set_white_balance_auto_mode,
                                   'white_balance_mode': self.set_white_balance_mode,
                                   'white_balance_blue': self.set_white_balance_blue,
                                   'white_balance_red': self.set_white_balance_red,
                                   'region_x': self.set_region_x,
                                   'region_y': self.set_region_y,
                                   'width': self.set_width,
                                   'height': self.set_height,
                                   'pixel_format': self.set_pixel_format
                                }
        self.parameter_server = Server(CameraConfig, self._parameter_callback)

        # Ros topic and topic rate.
        self.image_pub = rospy.Publisher("~image_uncompressed", Image, queue_size=10)
        rate = rospy.Rate(20)

        while not rospy.is_shutdown():
            self.image_pub.publish(self._get_last_image())
            rate.sleep()

    def _parameter_callback(self, config, level):
        print config
        # for parameter, value in config.items():
        #     if parameter in self.parameter_handlers:
        #         if not parameter in self.parameter_values:
        #             self.parameter_values[parameter] = None
        #         if self.parameter_values[parameter] != value:
        #             self.parameter_handlers[parameter](value)

        return config

    def _get_enum_name(self, enum, int_value):
        if hasattr(enum, "names"):
            names = [name for name, value in enum.names.items() if value == int_value]
            if len(names) > 0:
                return names[0]
        return None

    def set_acquisition_mode(self, value):
        name = self._get_enum_name(camera.AcquisitionMode, value)
        if name:
            rospy.loginfo("Setting acquisition mode: %s", name)
            self.camera.setAcquisitionMode(value)

    def set_exposure_auto_alg_mode(self, value):
        name = self._get_enum_name(camera.ExposureAutoAlgMode, value)
        if name:
            rospy.loginfo("Setting exposure auto alg mode: %s", name)
            self.camera.setExposureAutoAlgMode(value)

    def set_exposure_value(self, value):
        rospy.loginfo("Setting exposure value: %d", value)
        self.camera.setExposureValue(value)

    def set_exposure_auto_mode(self, value):
        name = self._get_enum_name(camera.ExposureAutoMode, value)
        if name:
            rospy.loginfo("Setting exposure auto mode: %s", name)
            # TODO: MARCHE PAS
            rospy.logwarn("Attention, marche pas encore...")
            #self.camera.setExposureAutoMode(value)

    def set_exposure_mode(self, value):
        name = self._get_enum_name(camera.ExposureMode, value)
        if name:
            rospy.loginfo("Setting exposure mode: %s", name)
            self.camera.setExposureMode(value)

    def set_gain_auto_mode(self, value):
        name = self._get_enum_name(camera.GainAutoMode, value)
        if name:
            rospy.loginfo("Setting gain auto mode: %s", name)
            # TODO: MARCHE PAS
            rospy.logwarn("Attention, marche pas encore...")
            #self.camera.setGainAutoMode(value)

    def set_gain_mode(self, value):
        name = self._get_enum_name(camera.GainMode, value)
        if name:
            rospy.loginfo("Setting gain mode: %s", name)
            self.camera.setGainMode(value)

    def set_gain_value(self, value):
        rospy.loginfo("Setting gain value: %d", value)
        self.camera.setGainValue(value)

    def set_gamma(self, value):
        rospy.loginfo("Setting gamma: %d", value)
        self.camera.setGamma(value)

    def set_hue(self, value):
        rospy.loginfo("Setting hue: %d", value)
        self.camera.setHue(value)

    def set_saturation(self, value):
        rospy.loginfo("Setting saturation: %d", value)
        self.camera.setSaturation(value)

    def set_white_balance_auto_mode(self, value):
        name = self._get_enum_name(camera.WhitebalAutoMode, value)
        if name:
            rospy.loginfo("Setting white balance auto mode: %s", name)
            # TODO: MARCHE PAS
            rospy.logwarn("Attention, marche pas encore...")
            #self.camera.setWhitebalAutoMode(value)

    def set_white_balance_mode(self, value):
        name = self._get_enum_name(camera.WhitebalMode, value)
        if name:
            rospy.loginfo("Setting white balance mode: %s", name)
            self.camera.setWhitebalMode(value)

    def set_white_balance_blue(self, value):
        rospy.loginfo("Setting white balance blue: %d", value)
        self.camera.setWhitebalValueBlue(value)

    def set_white_balance_red(self, value):
        rospy.loginfo("Setting white balance red: %d", value)
        self.camera.setWhitebalValueRed(value)

    def set_region_x(self, value):
        rospy.loginfo("Setting region x: %d", value)
        self.camera.setRegionX(value)

    def set_region_y(self, value):
        rospy.loginfo("Setting region y: %d", value)
        self.camera.setRegionY(value)

    def set_width(self, value):
        rospy.loginfo("Setting width: %d", value)
        self.camera.setWidth(value)

    def set_height(self, value):
        rospy.loginfo("Setting height: %d", value)
        self.camera.setHeight(value)

    def set_pixel_format(self, value):
        name = self._get_enum_name(camera.PixelFormat, value)
        if name:
            rospy.loginfo("Setting pixel format: %s", name)
            self.camera.setPixelFormat(value)

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
