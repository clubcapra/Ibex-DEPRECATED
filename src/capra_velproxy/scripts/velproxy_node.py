#!/usr/bin/env python

import rospy
from capra_controlpanel.msg import RobotButtons
from geometry_msgs.msg import Twist

PACKAGE_NAME = 'capra_velproxy'

# Names of the remapped topics
COMPUTER_TOPIC = 'cmd_vel_computer'
REMOTE_TOPIC = 'cmd_vel_remote'

# Possible states
COMPUTER = 0
REMOTE = 1

# Association between proxied topics and their state
MAPPING = {COMPUTER_TOPIC: COMPUTER, REMOTE_TOPIC: REMOTE}

# Node state
state = REMOTE


def velproxy_node():
    rospy.init_node(PACKAGE_NAME, log_level=rospy.DEBUG)

    cmd_vel = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

    def handle_robot_buttons(msg):
        global state

        if msg.mode == 'MAN':
            state = REMOTE
        else:
            state = COMPUTER

        rospy.loginfo('Now in state %s', state)

    def handle_cmd_vel(topic):
        def handle(msg):
            if MAPPING[topic] == state:
                cmd_vel.publish(msg)

        return handle

    rospy.Subscriber('/capra_controlpanel/buttons', RobotButtons, handle_robot_buttons)

    for topic in [COMPUTER_TOPIC, REMOTE_TOPIC]:
        rospy.Subscriber(topic, Twist, handle_cmd_vel(topic))

    rospy.spin()


if __name__ == '__main__':
    try:
        velproxy_node()
    except rospy.ROSInterruptException:
        pass
