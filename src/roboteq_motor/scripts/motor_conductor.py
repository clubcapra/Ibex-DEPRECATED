from motor import Motor
from swivel import Swivel
from config import Config
import numpy as np
import math

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

        for ndx, motor in enumerate(self.get_motors()):
            motor.gear_ratio = Config.get_gear_ratio()
            motor.wheel_diameter = Config.get_wheel_diameter()
            motor.position_ratio = Config.get_position_ratio()[ndx]
            motor.speed_ratio = Config.get_speed_ratio()[ndx]

        self.swivel = Swivel(MotorConductor.SWIVEL)

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
        rear_left_speed = rear_right_speed = linear_velocity

        self.motor_front_left.set_velocity(front_left_speed)
        self.motor_front_right.set_velocity(front_right_speed)
        self.motor_rear_left.set_velocity(rear_left_speed)
        self.motor_rear_right.set_velocity(rear_right_speed)

        #Calculate swivel angle. This may look like mathemagie, it is. See also: I have no idea what I'm doing

        xy_vel_vector = np.array([linear_velocity, 0])
        xyz_vel_vector = np.array([linear_velocity, 0, angular_velocity])

        norm_xy = np.linalg.norm(xy_vel_vector)
        norm_xyz = np.linalg.norm(xyz_vel_vector)

        if norm_xyz != 0: # If the robot doesn't move, we don't care about setting the angle
            angle = math.acos(norm_xy/norm_xyz)
            angle *= np.sign(angular_velocity)
            self.swivel.set_angle(angle)


    def measured_position(self):
        pass


    #Set the mode of the command
    #int8 MODE_STOPPED=-1
    #int8 MODE_VELOCITY=0 (DEFAULT)
    #int8 MODE_POSITION=1
    def set_motors_mode(self, mode):
        for motor in self.get_motors():
            motor.set_mode(mode)

    def set_swivel_mode(self, mode):
        self.swivel.set_mode(mode)
