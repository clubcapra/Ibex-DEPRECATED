#!/usr/bin/env python

import roslib
roslib.load_manifest('animatics_smart_motor')
import rospy
from includes.motor_controller import MotorController
from includes.config import Config
from geometry_msgs.msg import Twist


requested_vel = None
requested_vel_time = 0
last_vel = Twist()
motor_controller = None


def publish_odometry(position):
    print position.x, position.y


def cmd_vel_callback(msg):
    global requested_vel, requested_vel_time
    requested_vel = msg
    requested_vel_time = rospy.get_time()


def velocity_timer(event):
    global requested_vel, requested_vel_time, last_vel, motor_controller
    if rospy.get_time() - requested_vel_time > Config.get_watchdog_timeout():
        if last_vel.linear.x != 0 or last_vel.angular.z != 0:
            last_vel = Twist()
            motor_controller.set_velocity(0, 0)
    else:
        if last_vel.linear.x != requested_vel.linear.x or last_vel.angular.z != requested_vel.angular.z:
            last_vel = requested_vel
            motor_controller.set_velocity(last_vel.linear.x, last_vel.angular.z)


if __name__ == "__main__":
    rospy.init_node('animatics_smart_motor')

    motor_controller = MotorController()

    rospy.Timer(rospy.Duration.from_sec(50.0/1000), velocity_timer)
    rospy.Subscriber("/cmd_vel", Twist, cmd_vel_callback)

    error_count = 0
    max_timeout_count = Config.get_max_timeout_count()
    connected = False

    rospy.loginfo("Connecting to the motors...")
    while not rospy.is_shutdown():
        if connected:
            rospy.sleep(0.01)
            if motor_controller.update():
                error_count = 0
                publish_odometry(motor_controller.position)
            else:
                error_count += 1

            if error_count > max_timeout_count:
                rospy.logerr("Lost connection to the motors. Reconnecting...")
                motor_controller.disconnect()
                connected = False
                rospy.sleep(0.1)
        else:
            connected = motor_controller.initialize()
            if not connected:
                motor_controller.disconnect()
                rospy.sleep(0.5)
            else:
                rospy.loginfo("Connected to the motors.")




