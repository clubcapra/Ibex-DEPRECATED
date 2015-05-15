from abstract_motor import AbstractMotor
from io.serial_com import SerialCom
from config import Config
from motor import Motor
from commands import *
from threading import Event
from responses.report_actual_position_response import ReportActualPositionResponse
from responses.report_status_response import ReportStatusResponse
from position import Position


class MotorController(AbstractMotor):

    motors = []
    mode = SetMode.VELOCITY
    position_lock = Event()
    position = Position()

    def __init__(self):
        super(MotorController, self).__init__(0, SerialCom(Config.get_serial_port()))
        nb_motors = Config.get_nb_motors()
        for id in range(1, nb_motors + 1):
            self.motors.append(Motor(id, id > nb_motors / 2,
                                     self.serial_com,
                                     Config.get_speed_ratio()[id-1],
                                     Config.get_position_ratio()[id-1]))

        self.serial_com.add_listener(ReportActualPositionResponse, self._on_position_update)
        self.serial_com.add_listener(ReportStatusResponse, self._on_status_update)

    def initialize(self):
        if self.serial_com.connect():
            self.wake()
            self.set_echo(False)

            for m in self.motors:
                m.initialize()

            self.wake()

            self.serial_com.change_baudrate(Config.get_baudrate())

            self.disable_limits()
            self.reset_flags()
            self.reset_encoders()
            self.send_command(SetMode.VELOCITY)
            self.set_acceleration(Config.get_default_accel())

            return True
        else:
            return False

    def disconnect(self):
        self.serial_com.disconnect()
        #self.position = Position()
        for m in self.motors:
            m.reset()

    def _on_position_update(self, position):
        encoder_count = position.get_encoder_count()
        displacement = []
        for i in range(len(encoder_count)):
            last_position = self.motors[i].position
            self.motors[i].set_encoder_count(encoder_count[i])
            displacement.append(self.motors[i].position - last_position)

        left = displacement[len(displacement)/2]
        right = displacement[0]

        # Displacement error after E-Stop
        if abs(left) > 0.1 or abs(right) > 0.1:
            print "Err"
            left = 0.0
            right = 0.0

        self.position.move(left, right)

    def _on_status_update(self, status):
        s = status.get_status()
        for i in range(len(s)):
            self.motors[i].set_status(s[i])

        self.position_lock.set()

    def update(self):
        self.position_lock.clear()
        self.send_command(ReportActualPosition())
        self.send_command(ReportStatus())
        return self.position_lock.wait(0.05)

    def disable_limits(self):
        self.send_command(DisableLimits())

    def reset_encoders(self):
        self.send_command(ResetEncoders())

    def set_mode(self, mode):
        self.send_command(SetMode(mode))

    def set_velocity(self, linear_velocity, angular_velocity):
        width = Config.get_robot_width()
        left_speed = linear_velocity - angular_velocity * width / 2.0
        right_speed = linear_velocity + angular_velocity * width / 2.0

        self.set_individual_speed(left_speed, right_speed)
        self.start_move()

    def set_individual_speed(self, left_speed, right_speed):
        if self.mode != SetMode.VELOCITY:
            self.set_mode(SetMode.VELOCITY)

        for i in range(len(self.motors)):
            if i < len(self.motors) / 2:
                self.motors[i].set_speed(right_speed)
            else:
                self.motors[i].set_speed(left_speed)


