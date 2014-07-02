from abstract_motor import AbstractMotor
from commands import *


class Motor(AbstractMotor):

    def __init__(self, id, serial_com):
        super(Motor, self).__init__(id, serial_com)

    def initialize(self):
        self.set_address(self.id)
        self.set_echo(True)
        self.sleep()

    def set_address(self, id):
        return self.broadcast_command(SetAddress(id))

    def set_speed(self, speed):
        return self.send_command(SetSpeed(speed))