from motor import Motor



class MotorConductor:
    FRONT = "front"
    REAR = "rear"
    LEFT = "left"
    RIGHT = "right"

    def __init__(self):
        self.motor_front_left = Motor(MotorConductor.FRONT, MotorConductor.LEFT)
        self.motor_front_right = Motor(MotorConductor.FRONT, MotorConductor.RIGHT)
        self.motor_rear_left = Motor(MotorConductor.REAR, MotorConductor.LEFT)
        self.motor_rear_right = Motor(MotorConductor.REAR, MotorConductor.RIGHT)

        #TODO: __init__ swivel

    def get_motors(self):
        return [self.motor_front_left, self.motor_front_right, self.motor_rear_left, self.motor_rear_right]


    def set_velocity(self, linear_velocity, angular_velocity):
        #TODO: Mathemagie
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