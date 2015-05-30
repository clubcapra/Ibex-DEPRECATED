#! /usr/bin/env python
# coding=utf-8

import rospy
from subprocess import call
from geometry_msgs.msg import Point

def stop_node(node_name):
    command = "rosnode kill " + node_name
    run(command)

def start_node(package, node_name, params = ""):
    command = "rosrun {0} {1} {2} _clear_params=true".format(package, node_name, params)
    run(command)

def launch(path):
    run("roslaunch {0}".format(path))

def launch(package, launchfile):
    run("roslaunch {0} {1}".format(package, launchfile))

def set_robot_speed(speed):
    run("rosrun dynamic_reconfigure dynparam set /move_base/TrajectoryPlannerROS max_vel_x {0}".format(speed))

def set_param(param, value):
    run("rosparam set {} {}".format(param, value))

def run(cmd):
    rospy.loginfo("Running command:{0}".format(cmd))
    call(cmd + " &", shell=True)


