import math

class MotorConductor:
    def __init__(self):
        self.motors = dict()
        self.width=0

    def move(self, linear_velocity, angular_velocity):
        pass

    def measured_position(self):
        pass

    #Set the mode of the command
    #int8 MODE_STOPPED=-1
    #int8 MODE_VELOCITY=0 (DEFAULT)
    #int8 MODE_POSITION=1
    def set_motors_mode(self):
        return 0

    def disconnect(self):
        pass