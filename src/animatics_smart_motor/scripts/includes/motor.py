from abstract_motor import AbstractMotor
from commands import *
from utils.motor_utils import MotorUtils
import rospy


class Motor(AbstractMotor):

    encoder_count = 0
    position = 0
    speed_ratio = 1.0

    def __init__(self, id, reverse, serial_com, speed_ratio=1.0, position_ratio=1.0):
        super(Motor, self).__init__(id, serial_com)
        self.reverse = reverse
        self.speed_ratio = speed_ratio
        self.position_ratio = position_ratio

    def initialize(self):
        self.set_address(self.id)
        self.set_echo(True)
        self.sleep()

    def set_address(self, id):
        return self.broadcast_command(SetAddress(id))

    def set_speed(self, speed):
        if self.reverse:
            speed = -speed
        speed *= self.speed_ratio
        return self.send_command(SetSpeed(speed))

    def set_status(self, status):
        if status.is_error():
            rospy.logwarn("Motor %i: %s" % (self.id, str(status)))
            self.reset_flags()

    def set_encoder_count(self, encoder_count):
        if self.reverse:
            encoder_count = -encoder_count
        self.encoder_count = encoder_count
        self.set_position(MotorUtils.counts_to_distance(encoder_count) * self.position_ratio)

    def set_position(self, position):
        self.position = position

    def reset(self):
        #self.encoder_count = 0
        #self.position = 0
        self.temperature = 0
        self.amps = 0
        self.status = None