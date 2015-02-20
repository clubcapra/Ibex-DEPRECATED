#!/usr/bin/env python 

PACKAGE_NAME = 'capra_teleop'

import roslib
roslib.load_manifest(PACKAGE_NAME)
import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import Joy
import rospkg
import socket

LINEAR_VEL = 0.1
ANGULAR_VEL = 0.1

def cmd_vel_timer(evt):
    global key, cmd_vel, LINEAR_VEL, ANGULAR_VEL
    msg = Twist()
    if key:
        key = key.lower()
        if key == 'w':
            print "avance"
            msg.linear.x = LINEAR_VEL
        elif key == "s":
            print "recule"
            msg.linear.x = -LINEAR_VEL
        elif key == "a":
            print "left"
            msg.angular.z = ANGULAR_VEL
        elif key == "d":
            print "right"
            msg.angular.z = -ANGULAR_VEL
    cmd_vel.publish(msg)
        
def watchdog_timer(evt):
    global key, last_update
    if rospy.get_time() - last_update > 0.5:
        key = ""

rospy.init_node(PACKAGE_NAME)
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(('', 1337))


cmd_vel = rospy.Publisher("/cmd_vel", Twist, queue_size=1)

rospy.Timer(rospy.Duration.from_sec(15.0/1000), cmd_vel_timer)
rospy.Timer(rospy.Duration.from_sec(0.1), watchdog_timer)

key = ""
last_update = 0

while not rospy.is_shutdown():
    key = s.recvfrom(1)[0]
    last_update = rospy.get_time()
    
    
