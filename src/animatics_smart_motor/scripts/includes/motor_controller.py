from abstract_motor import AbstractMotor
from io.serial_com import SerialCom
from config import Config
from motor import Motor
from commands import *


class MotorController(AbstractMotor):

    motors = []
    mode = SetMode.VELOCITY

    def __init__(self):
        super(MotorController, self).__init__(0, SerialCom(Config.get_serial_port()))
        for id in range(1, Config.get_nb_motors() + 1):
            self.motors.append(Motor(id, self.serial_com))

    def initialize(self):
        if self.serial_com.connect():
            self.wake()
            self.set_echo(False)

            for m in self.motors:
                m.initialize()

            self.wake()
            self.disable_limits()
            self.reset_flags()
            self.reset_encoders()
            self.send_command(SetMode.VELOCITY)
            self.set_acceleration(Config.get_default_accel())

            return True
        else:
            return False

    def disable_limits(self):
        self.send_command(DisableLimits())

    def reset_encoders(self):
        self.send_command(ResetEncoders())

    def set_mode(self, mode):
        self.send_command(SetMode(mode))

    def set_velocity(self, linear_velocity, angular_velocity):
        width = Config.get_robot_width()
        left_speed = linear_velocity + angular_velocity * width / 2.0
        right_speed = linear_velocity - angular_velocity * width / 2.0

        self.set_individual_speed(-left_speed, right_speed)
        self.start_move()

    def set_individual_speed(self, left_speed, right_speed):
        if self.mode != SetMode.VELOCITY:
            self.set_mode(SetMode.VELOCITY)

        for i in range(len(self.motors)):
            if i < len(self.motors):
                self.motors[i].set_speed(right_speed)
            else:
                self.motors[i].set_speed(left_speed)
