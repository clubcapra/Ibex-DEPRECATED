from commands import *

class AbstractMotor(object):
    def __init__(self, id, serial_com):
        self.id = id
        self.serial_com = serial_com

    def wake(self):
        return self.send_command(Wake())

    def set_echo(self, echo):
        return self.send_command(Echo(echo))

    def set_acceleration(self, acceleration):
        return self.send_command(SetAcceleration(acceleration))

    def start_move(self):
        return self.send_command(StartMove())

    def reset_flags(self):
        return self.send_command(ResetFlags())

    def sleep(self):
        return self.send_command(Sleep())

    def send_command(self, command):
        return self.serial_com.send_command(self.id, command)

    def broadcast_command(self, command):
        return self.serial_com.send_command(0, command)


