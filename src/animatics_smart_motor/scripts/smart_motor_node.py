#!/usr/bin/env python

import roslib
roslib.load_manifest('animatics_smart_motor')
import rospy
from includes.motor_controller import MotorController
from animatics_smart_motor.msg import MotorsConnected
from includes.config import Config
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
import math


requested_vel = None
requested_vel_time = 0
last_vel = Twist()
motor_controller = None
connected_msg = MotorsConnected()
disconnected_msg = MotorsConnected()
connected_msg.connected = True
disconnected_msg.connected = False

def publish_odom(event):
    global motor_controller, od
    pos = motor_controller.position
    covariance = Config.get_covariance_matrix()

    odom = Odometry()
    odom.header.frame_id = "odom"
    odom.child_frame_id = "base_link"

    if rospy.get_time() - pos.position_time > 50.0/1000:
        odom.header.stamp = rospy.Time.now()
    else:
        odom.header.stamp = rospy.Time.from_sec(pos.position_time)

    odom.pose.pose.position.x = pos.x
    odom.pose.pose.position.y = pos.y

    odom.pose.pose.orientation.z = math.sin(pos.yaw / 2)
    odom.pose.pose.orientation.w = math.cos(pos.yaw / 2)
    odom.pose.covariance = covariance

    odom.twist.twist.linear.x = pos.linear_vel
    odom.twist.twist.angular.z = pos.angular_vel
    odom.twist.covariance = covariance

    odom_publisher.publish(odom)

    #print position.x, position.y


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

    rospy.Subscriber("/cmd_vel", Twist, cmd_vel_callback)
    odom_publisher = rospy.Publisher("/odom", Odometry, queue_size=10)
    connected_publisher = rospy.Publisher("~connected", MotorsConnected, queue_size=5, latch=True)
    rospy.Timer(rospy.Duration.from_sec(50.0/1000), velocity_timer)
    rospy.Timer(rospy.Duration.from_sec(1.0/Config.get_publish_rate()), publish_odom)

    error_count = 0
    max_timeout_count = Config.get_max_timeout_count()
    connected = False

    rospy.loginfo("Connecting to the motors...")
    while not rospy.is_shutdown():
        if connected:
            s = rospy.get_time()
            if motor_controller.update():
                error_count = 0
            else:
                error_count += 1

            if error_count > max_timeout_count:
                connected_publisher.publish(disconnected_msg)
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
                connected_publisher.publish(connected_msg)
                motor_controller.set_velocity(last_vel.linear.x, last_vel.angular.z)



