#!/bin/bash
export ROS_IP=$(ip addr | awk '/inet/ && /wlan0/{sub(/\/.*$/,"",$2); print $2}')
echo $IBEX_HOME
roslaunch $IBEX_HOME/launch/autonomous_demo_cones.launch
