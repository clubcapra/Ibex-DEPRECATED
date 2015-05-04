#!/usr/bin/env python 

PACKAGE_NAME = 'capra_teleop'

import roslib
roslib.load_manifest(PACKAGE_NAME)
import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import Joy
import rospkg
import subprocess

try:
    import pygame
    pygame.init()
    rospack = rospkg.RosPack()
    pygame.mixer.music.load(rospack.get_path(PACKAGE_NAME) + "/horn.wav")
    pygame_loaded = True
except ImportError, e:
    pygame_loaded = False
    if e.message != 'No module named pygame':
        raise

FORWARD = 1
BACKWARDS = 2
SPINNING = 3
STOPPED = 4


if '046d:c21a' in subprocess.check_output(['lsusb']):
    buttons = {"left": "axes:0:+",
               "right": "axes:0:-",
               "accelerate": "axes:1:+",
               "deccelerate": "axes:1:-",
               "forward": "buttons:1",
               "backwards": "buttons:2",
               "spin_left": "buttons:4",
               "spin_right": "buttons:5",
               "horn": "buttons:8"}
else:
    buttons = {"left": "axes:6:+",
               "right": "axes:6:-",
               "accelerate": "axes:7:+",
               "deccelerate": "axes:7:-",
               "forward": "buttons:0",
               "backwards": "buttons:1",
               "spin_left": "buttons:4",
               "spin_right": "buttons:5",
               "horn": "buttons:8"}

linear_increment = 0.1
max_linear_vel = 2.0
min_linear_vel = -1.0
default_linear_vel = 0.3

angular_increment = 0.1
max_angular_vel = 0.8

spin_speed = 1.0

last_joy_message = None
linear_vel = 0.0
angular_vel = 0.0
last_angular_acceleration = 0
rotating = False
state = STOPPED


def process_input(msg):
    global FORWARD, BACKWARDS, SPINNING, STOPPED

    forward = get_button_value(msg, "forward") > 0
    backwards = get_button_value(msg, "backwards") > 0
    left = get_button_value(msg, "left") > 0
    right = get_button_value(msg, "right") > 0
    #rospy.loginfo(msg)

    if forward or backwards:
        if forward:
            change_state(FORWARD)
        elif backwards:
            change_state(BACKWARDS)
            #Inverser la direction si on recule
            tmpleft = left
            left = right
            right = tmpleft

        if get_button_value(msg, "accelerate") > 0:
            increment_linear_vel()
        elif get_button_value(msg, "deccelerate") > 0:
            decrement_linear_vel()

        if backwards and linear_vel > 0 or forward and linear_vel < 0:
            reset_linear_vel()

        if left:
            start_rotation(True)
        elif right:
            start_rotation(False)
        else:
            stop_rotation()
    else:
        spin_left = get_button_value(msg, "spin_left") > 0
        spin_right = get_button_value(msg, "spin_right") > 0
        if spin_left or spin_right:
            change_state(SPINNING)
            start_rotation(spin_left, True)
        else:
            change_state(STOPPED)

    if get_button_value(msg, "horn") > 0:
        start_horn()


def change_state(new_state):
    global linear_vel, default_linear_vel, state
    if state != new_state:
        if new_state == FORWARD:
            linear_vel = default_linear_vel
        elif new_state == BACKWARDS:
            linear_vel = -default_linear_vel
        else:
            linear_vel = 0
            stop_rotation()
        state = new_state


def increment_linear_vel():
    global linear_vel, linear_increment, max_linear_vel
    if linear_vel + linear_increment > max_linear_vel:
        linear_vel = max_linear_vel
    else:
        linear_vel = linear_vel + linear_increment
    if abs(linear_vel) < linear_increment:
        linear_vel = 0.0


def decrement_linear_vel():
    global linear_vel, linear_increment, min_linear_vel
    if linear_vel - linear_increment < min_linear_vel:
        linear_vel = min_linear_vel
    else:
        linear_vel = linear_vel - linear_increment
    if abs(linear_vel) < linear_increment:
        linear_vel = 0.0


def start_rotation(left, spin=False):
    global angular_increment, angular_vel, rotating, spin_speed

    if spin:
        angular_vel = (1.0 if left else -1.0) * spin_speed
    else:
        if left and angular_vel <= 0.0:
            angular_vel = angular_increment
        elif not left and angular_vel >= 0.0:
            angular_vel = -angular_increment

    rotating = True


def stop_rotation():
    global angular_vel, rotating
    angular_vel = 0.0
    rotating = False


def accelerate_rotation():
    global angular_vel, angular_increment, max_angular_vel, last_angular_acceleration, rotating

    diff = rospy.get_time() - last_angular_acceleration
    absvel = abs(angular_vel)

    if diff > 0.1 and rotating and max_angular_vel - absvel > 0.01:
        angular_vel += angular_increment * (absvel / angular_vel)
        last_angular_acceleration = rospy.get_time()


def reset_linear_vel():
    global linear_vel
    linear_vel = 0.0


def start_horn():
    if pygame_loaded:
        pygame.mixer.music.play()


def has_new_input(msg):
    global last_joy_message
    if last_joy_message:
        for i in range(len(msg.buttons)):
            if msg.buttons[i] != last_joy_message.buttons[i]:
                return True
        for i in range(len(msg.axes)):
            if msg.axes[i] != last_joy_message.axes[i]:
                return True
    else:
        return True

    return False


def get_button_value(msg, name):
    global buttons
    split = buttons[name].split(":")
    val = getattr(msg, split[0])[int(split[1])]
    if len(split) == 2:
        return val
    else:
        if split[2] == "+" and val > 0:
            return 1
        elif split[2] == "-" and val < 0:
            return 1
        else:
            return 0


def joy_callback(msg):
    global last_joy_message
    #rospy.loginfo("joy callback: " + str(msg))
    #if has_new_input(msg):
    process_input(msg)
    last_joy_message = msg


def cmd_vel_timer(event):
    global linear_vel, angular_vel, cmd_vel_publisher, state, FORWARD, BACKWARDS

    if state == FORWARD or state == BACKWARDS:
        accelerate_rotation()

    msg = Twist()
    msg.linear.x = linear_vel
    msg.angular.z = angular_vel

    cmd_vel_publisher.publish(msg)


rospy.init_node(PACKAGE_NAME)

rospy.Subscriber("/joy", Joy, joy_callback)
cmd_vel_publisher = rospy.Publisher("/cmd_vel", Twist, queue_size=1)
rospy.Timer(rospy.Duration.from_sec(15.0/1000), cmd_vel_timer)


while not rospy.is_shutdown():
    rospy.sleep(1)
