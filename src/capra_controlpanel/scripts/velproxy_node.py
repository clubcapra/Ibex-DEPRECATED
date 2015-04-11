#!/usr/bin/env python

import rospy
from capra_controlpanel.msg import RobotButtons
from sensor_msgs.msg import Joy
from geometry_msgs.msg import Twist

SWITCH_STATE_BUTTON = 8

class velproxy_node:

    def __init__(self):
        rospy.init_node('capra_velproxy', log_level=rospy.INFO)
        
        self.computer_topic = rospy.get_param('computer_topic', 'cmd_vel_computer')
        self.remote_topic = rospy.get_param('remote_topic', 'cmd_vel_remote')
        self.mapping = {'AUTO': self.computer_topic, 'MAN': self.remote_topic}
        self.state = self.remote_topic
        self.cmd_vel = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

        rospy.Subscriber('/capra_controlpanel/buttons', RobotButtons, self.handle_robot_buttons)
        rospy.Subscriber('/joy', Joy, self.handle_joy)

        for topic in [self.computer_topic, self.remote_topic]:
            rospy.Subscriber(topic, Twist, self.create_cmd_vel_handler(topic))

        rospy.spin()

    def handle_robot_buttons(self, msg):
        new_state = self.mapping[msg.mode]

        if self.state != new_state:
            rospy.loginfo('In state %s, accepting topic: %s', msg.mode, new_state)
            self.state = new_state

    def create_cmd_vel_handler(self, topic):
        def handle_cmd_vel(msg):
            if topic == self.state:
                rospy.logdebug('sending %s', str(msg))
                self.cmd_vel.publish(msg)

        return handle_cmd_vel

    def handle_joy(self, msg):
        if msg.buttons[SWITCH_STATE_BUTTON] == 1:
            if self.state == self.computer_topic:
                self.state = self.remote_topic
                rospy.loginfo('In state MAN, accepting topic: %s', self.state)
            else:
                self.state = self.computer_topic
                rospy.loginfo('In state AUTO, accepting topic: %s', self.state)


if __name__ == '__main__':
    try:
        velproxy_node()
    except rospy.ROSInterruptException:
        pass
