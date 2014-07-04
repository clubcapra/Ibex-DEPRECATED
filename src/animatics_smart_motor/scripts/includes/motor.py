from abstract_motor import AbstractMotor
from commands import *
from utils.motor_utils import MotorUtils


class Motor(AbstractMotor):

    encoder_count = 0
    position = 0

    def __init__(self, id, reverse, serial_com):
        super(Motor, self).__init__(id, serial_com)
        self.reverse = reverse

    def initialize(self):
        self.set_address(self.id)
        self.set_echo(True)
        self.sleep()

    def set_address(self, id):
        return self.broadcast_command(SetAddress(id))

    def set_speed(self, speed):
        if self.reverse:
            speed = -speed
        return self.send_command(SetSpeed(speed))

    def set_encoder_count(self, encoder_count):
        if self.reverse:
            encoder_count = -encoder_count
        self.encoder_count = encoder_count
        self.set_position(MotorUtils.counts_to_distance(encoder_count))

    def set_position(self, position):
        self.position = position

    def reset(self):
        self.encoder_count = 0
        self.position = 0
        self.temperature = 0
        self.amps = 0
        self.status = None