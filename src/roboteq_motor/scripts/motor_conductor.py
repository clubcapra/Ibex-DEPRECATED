from motor import Motor
from swivel import Swivel
from config import Config


class MotorConductor:
    FRONT = "front"
    REAR = "rear"
    LEFT = "left"
    RIGHT = "right"
    SWIVEL = "swivel"

    def __init__(self):
        self.motor_front_left = Motor(MotorConductor.FRONT, MotorConductor.LEFT)
        self.motor_front_right = Motor(MotorConductor.FRONT, MotorConductor.RIGHT)
        self.motor_rear_left = Motor(MotorConductor.REAR, MotorConductor.LEFT)
        self.motor_rear_right = Motor(MotorConductor.REAR, MotorConductor.RIGHT)

        self.swivel = Swivel(MotorConductor.SWIVEL, MotorConductor.RIGHT)

    def get_motors(self):
        return [self.motor_front_left, self.motor_front_right, self.motor_rear_left, self.motor_rear_right]


    def set_velocity(self, linear_velocity, angular_velocity):
        width = Config.get_robot_width()

        # Calculate front motors velocity
        # Apply linear speed
        # On the left: substract arc velocity (rad * radius = arc)
        # On the right: add arc velocity (rad * radius = arc)
        # Considering radians increase counterclockwise and robot front is pointing toward x+
        # right wheel needs to travel more distance (and thus go faster) when the robot turns counterclockwise
        front_left_speed = linear_velocity - angular_velocity * width / 2.0
        front_right_speed = linear_velocity + angular_velocity * width / 2.0

        # Calculate rear motors velocity
        # Apply linear speed, angular component will probably be applied by the swivel
        #TODO: check this ^
        rear_left_speed = rear_right_speed = linear_velocity

        #TODO: The fact there's a gap of few nanoseconds (execution time) when applying velocity from a motor to the next may or may not be catastrophic.
        self.motor_front_left.set_velocity(front_left_speed)
        self.motor_front_right.set_velocity(front_right_speed)
        self.motor_rear_left.set_velocity(rear_left_speed)
        self.motor_rear_right.set_velocity(rear_right_speed)

        self.swivel.set_angle(0) #TODO



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