#!/usr/bin/env python
# coding=utf-8

import roslib
roslib.load_manifest('capra_camera')
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
import cv2
from includes.OutputGrabber import OutputGrabber
from dynamic_reconfigure.server import Server
from capra_camera.cfg import CameraConfig
import camera


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
        self.parameter_handlers = { 'acquisition_mode': self.set_acquisition_mode,
                                    'pixel_format': self.set_pixel_format,
                                    # ROI
                                    'region_x': self.set_region_x,
                                    'region_y': self.set_region_y,
                                    'width': self.set_width,
                                    'height': self.set_height,
                                    # Exposure
                                    'exposure_auto_adjust_tol': self.set_exposure_auto_adjust_tol,
                                    'exposure_auto_alg': self.set_exposure_auto_alg,
                                    'exposure_auto_min': self.set_exposure_auto_min,
                                    'exposure_auto_max': self.set_exposure_auto_max,
                                    'exposure_auto_outliers': self.set_exposure_auto_outliers,
                                    'exposure_auto_rate': self.set_exposure_auto_rate,
                                    'exposure_auto_target': self.set_exposure_auto_target,
                                    'exposure_mode': self.set_exposure_mode,
                                    'exposure_value': self.set_exposure_value,
                                    # Gain
                                    'gain_auto_adjust_tol': self.set_gain_auto_adjust_tol,
                                    'gain_auto_min': self.set_gain_auto_min,
                                    'gain_auto_max': self.set_gain_auto_max,
                                    'gain_auto_outliers': self.set_gain_auto_outliers,
                                    'gain_auto_rate': self.set_gain_auto_rate,
                                    'gain_auto_target': self.set_gain_auto_target,
                                    'gain_mode': self.set_gain_mode,
                                    'gain_value': self.set_gain_value,
                                    # White balance
                                    'white_balance_auto_adjust_tol': self.set_white_balance_auto_adjust_tol,
                                    'white_balance_auto_rate': self.set_white_balance_auto_rate,
                                    'white_balance_mode': self.set_white_balance_mode,
                                    'white_balance_blue': self.set_white_balance_blue,
                                    'white_balance_red': self.set_white_balance_red,

                                    'gamma': self.set_gamma,
                                    'hue': self.set_hue,
                                    'saturation': self.set_saturation
        }
        self.parameter_server = Server(CameraConfig, self._parameter_callback)

        # Ros topic and topic rate.
        self.image_pub = rospy.Publisher("~image_uncompressed", Image, queue_size=10)
        rate = rospy.Rate(20)

        while not rospy.is_shutdown():
            self.image_pub.publish(self._get_last_image())
            rate.sleep()

    def _handle_parameter(self, parameter, value):
        if not parameter in self.parameter_values:
            self.parameter_values[parameter] = None
        if self.parameter_values[parameter] != value:
            self.parameter_values[parameter] = value
            try:
                self.parameter_handlers[parameter](value)
            except Exception as e:
                rospy.logwarn(e.message)

    def _parameter_callback(self, config, level):
        print config

        # Parametres prioritaires
        if 'white_balance_mode' in config:
            self._handle_parameter('white_balance_mode', config['white_balance_mode'])

        if 'gain_mode' in config:
            self._handle_parameter('gain_mode', config['gain_mode'])

        if 'exposure_mode' in config:
            self._handle_parameter('exposure_mode', config['exposure_mode'])

        # Les autres parametres
        for parameter, value in config.items():
            # Skip parametres prioritaires
            if parameter in ['white_balance_mode', 'gain_mode', 'exposure_mode']:
                continue
            if parameter in self.parameter_handlers:
                self._handle_parameter(parameter, value)

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
            self.camera.setAcquisitionMode(camera.AcquisitionMode(value))

    def set_exposure_auto_adjust_tol(self, value):
        rospy.loginfo("Setting exposure auto adjust tol value: %d", value)
        self.camera.setExposureAutoMode(camera.ExposureAutoMode.ExposureAutoAdjustTol, value)

    def set_exposure_auto_alg(self, value):
        rospy.loginfo("Setting exposure auto alg value: %d", value)
        self.camera.setExposureAutoAlgMode(camera.ExposureAutoAlgMode(value))

    def set_exposure_auto_min(self, value):
        rospy.loginfo("Setting exposure auto min value: %d", value)
        self.camera.setExposureAutoMode(camera.ExposureAutoMode.ExposureAutoMin, value)

    def set_exposure_auto_max(self, value):
        rospy.loginfo("Setting exposure auto max value: %d", value)
        self.camera.setExposureAutoMode(camera.ExposureAutoMode.ExposureAutoMax, value)

    def set_exposure_auto_outliers(self, value):
        rospy.loginfo("Setting exposure auto outliers value: %d", value)
        self.camera.setExposureAutoMode(camera.ExposureAutoMode.ExposureAutoOutliers, value)

    def set_exposure_auto_rate(self, value):
        rospy.loginfo("Setting exposure auto rate value: %d", value)
        self.camera.setExposureAutoMode(camera.ExposureAutoMode.ExposureAutoRate, value)

    def set_exposure_auto_target(self, value):
        rospy.loginfo("Setting exposure auto target value: %d", value)
        self.camera.setExposureAutoMode(camera.ExposureAutoMode.ExposureAutoTarget, value)

    def set_exposure_mode(self, value):
        name = self._get_enum_name(camera.ExposureMode, value)
        if name:
            rospy.loginfo("Setting exposure mode: %s", name)
            self.camera.setExposureMode(camera.ExposureMode(value))

    def set_exposure_value(self, value):
        rospy.loginfo("Setting exposure value: %d", value)
        self.camera.setExposureValue(value)

    def set_gain_auto_adjust_tol(self, value):
        rospy.loginfo("Setting gain auto adjust tol value: %d", value)
        self.camera.setGainAutoMode(camera.GainAutoMode.GainAutoAdjustTol, value)

    def set_gain_auto_min(self, value):
        rospy.loginfo("Setting gain auto min value: %d", value)
        self.camera.setGainAutoMode(camera.GainAutoMode.GainAutoMin, value)

    def set_gain_auto_max(self, value):
        rospy.loginfo("Setting gain auto max value: %d", value)
        self.camera.setGainAutoMode(camera.GainAutoMode.GainAutoMax, value)

    def set_gain_auto_outliers(self, value):
        rospy.loginfo("Setting gain auto outliers value: %d", value)
        self.camera.setGainAutoMode(camera.GainAutoMode.GainAutoOutliers, value)

    def set_gain_auto_rate(self, value):
        rospy.loginfo("Setting gain auto rate value: %d", value)
        self.camera.setGainAutoMode(camera.GainAutoMode.GainAutoRate, value)

    def set_gain_auto_target(self, value):
        rospy.loginfo("Setting gain auto target value: %d", value)
        self.camera.setGainAutoMode(camera.GainAutoMode.GainAutoTarget, value)

    def set_gain_mode(self, value):
        name = self._get_enum_name(camera.GainMode, value)
        if name:
            rospy.loginfo("Setting gain mode: %s", name)
            self.camera.setGainMode(camera.GainMode(value))

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

    def set_white_balance_auto_adjust_tol(self, value):
        rospy.loginfo("Setting white balance auto adjust tol value: %d", value)

        self.camera.setExposureAutoAlgMode(camera.ExposureAutoAlgMode(value))

    def set_white_balance_auto_rate(self, value):
        rospy.loginfo("Setting white balance auto rate: %d", value)
        self.camera.setWhitebalAutoMode(camera.WhitebalAutoMode.WhitebalAutoRate, value)

    def set_white_balance_mode(self, value):
        name = self._get_enum_name(camera.WhitebalMode, value)
        if name:
            rospy.loginfo("Setting white balance mode: %s", name)
            self.camera.setWhitebalMode(camera.WhitebalMode(value))

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
            self.camera.setPixelFormat(camera.PixelFormat(value))

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
