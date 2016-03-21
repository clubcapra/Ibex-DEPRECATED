import serial
from motor import Motor
from config import Config
import math
import rospy

class Swivel(Motor):
    def __init__(self, name):
        Motor.__init__(self, name, name)
        self.serial_com = serial.Serial(Config.get_swivel_encoder_port(),Config.get_swivel_encoder_baud())
        self._last_angle = 0

    def set_angle(self, angle):
        #Calculate required speed to set angle in 1 second
        relative_angle = angle - self.get_angle()

        



    def get_angle(self):
        try:
            self._last_measured_angle = math.radians(360 * (float(self.serial_com.readline())) / 4096)
        except:
            rospy.logerr("Failed to read swivel angle from encoders")

        return self._last_angle


    def get_axial_location(self):
        return [self.x_axial_location]