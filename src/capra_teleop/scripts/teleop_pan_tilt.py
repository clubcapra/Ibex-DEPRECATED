#!/usr/bin/env python 

PACKAGE_NAME = 'capra_teleop'

import roslib
roslib.load_manifest(PACKAGE_NAME)
import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import Joy
from lm_pantilt.srv import Pan, Tilt, Reset
from std_srvs.srv import Empty
import rospkg

FORWARD = 1
BACKWARDS = 2
SPINNING = 3
STOPPED = 4

buttons = {"left": "axes:0:+",
           "right": "axes:0:-",
           "accelerate": "axes:1:+",
           "deccelerate": "axes:1:-",
           "forward": "buttons:1",
           "backwards": "buttons:2",
           "spin_left": "buttons:4",
           "spin_right": "buttons:5",
           "save_point_cloud": "buttons:8",
           "pan_left": "buttons:6",
           "pan_right": "buttons:7",
           "tilt_up": "buttons:3",
           "tilt_down": "buttons:0"}

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

pan_angle = 0
max_pan = 90
min_pan = -90
pan_increment = 10

tilt_angle = 0
max_tilt = 50
min_tilt = -30
tilt_increment = 10

def process_input(msg):
    global FORWARD, BACKWARDS, SPINNING, STOPPED

    forward = get_button_value(msg, "forward") > 0
    backwards = get_button_value(msg, "backwards") > 0
    left = get_button_value(msg, "left") > 0
    right = get_button_value(msg, "right") > 0

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

    if get_button_value(msg, "save_point_cloud") > 0:
        save_point_cloud()

    global pan_increment, pan_angle, max_pan, min_pan
        
    pan_left = get_button_value(msg, "pan_left")
    pan_right = get_button_value(msg, "pan_right")
    
    if pan_left or pan_right:
        if pan_left:
            pan_angle += pan_increment
            if pan_angle > max_pan:
                pan_angle = max_pan
        else:
            pan_angle -= pan_increment
            if pan_angle < min_pan:
                pan_angle = min_pan
        pan(pan_angle)
        
    global tilt_increment, tilt_angle, max_tilt, min_tilt
    
    tilt_up = get_button_value(msg, "tilt_up")
    tilt_down = get_button_value(msg, "tilt_down")
    
    if tilt_up or tilt_down:
        if tilt_up:
            tilt_angle += tilt_increment
            if tilt_angle > max_tilt:
                tilt_angle = max_tilt
        else:
            tilt_angle -= tilt_increment
            if tilt_angle < min_tilt:
                tilt_angle = min_tilt
        tilt(tilt_angle)

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
    if has_new_input(msg):
        process_input(msg)
    last_joy_message = msg

def pan(angle):
    global pan_srv
    try:
        if not pan_srv:
            pan_srv = rospy.ServiceProxy("/lm_pantilt/pan", Pan)
        pan_srv(angle)
    except Exception as e:
        print e
        rospy.logwarn("Cannot pan")
           
def tilt(angle):
    global tilt_srv
    try:
        if not tilt_srv:
            tilt_srv = rospy.ServiceProxy("/lm_pantilt/tilt", Tilt)
        tilt_srv(angle)
    except:
        rospy.logwarn("Cannot tilt")
         
def save_point_cloud():
    try:
        rospy.ServiceProxy("/pointcloud_saver/save_pointcloud", Empty)()
    except Exception as e:
        print e
        rospy.logerr("Cannot save point cloud")
        
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

pan_srv = None
tilt_srv = None
try:
    rospy.ServiceProxy('/lm_pantilt/reset', Reset)()
except:
    pass
    
cmd_vel_publisher = rospy.Publisher("/cmd_vel", Twist, queue_size=10)
rospy.Timer(rospy.Duration.from_sec(15.0/1000), cmd_vel_timer)


while not rospy.is_shutdown():
    rospy.sleep(1)
