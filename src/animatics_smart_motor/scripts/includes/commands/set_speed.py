import rospy
from command import *
from ..utils.motor_utils import MotorUtils
from ..config import Config


class SetSpeed(Command):
    def __init__(self, speed):
        super(SetSpeed, self).__init__()
        self.speed = speed
        
    def __str__(self):
        max_speed = Config.get_max_speed()

        if abs(self.speed) > max_speed:
            rospy.logwarn("Max speed = %f" % max_speed)
            speed = max_speed
        else:
            speed = self.speed

        return "VT=%i" % MotorUtils.rpm_to_counts(MotorUtils.ms_to_rpm(speed))



