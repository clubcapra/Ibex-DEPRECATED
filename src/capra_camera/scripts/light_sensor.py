#!/usr/bin/python

import rospy
import serial
from std_msgs.msg import Float32


class LightSensor:
    def __init__(self):
        port = rospy.get_param("~serial_port", "/dev/ttyACM0")
        baud_rate = rospy.get_param("~serial_baud", 9600)
        done = False
        serial_port = serial.Serial(port, baud_rate)
        publisher = rospy.Publisher("/light_sensor", Float32, queue_size=10)

        while not done:
            value = float(serial_port.readline())
            publisher.publish(Float32(value))


if __name__ == "__main__":
    rospy.init_node("light_sensor")
    sensor = LightSensor()
