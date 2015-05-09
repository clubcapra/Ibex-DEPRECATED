#!/usr/bin/env python

import rospy
import rosnode
import subprocess
from capra_controlpanel.msg import RobotButtons
from animatics_smart_motor.msg import MotorsConnected


class EStopWatcher:
    estop_on = True
    connected = False

    def __init__(self):
        rospy.init_node('estop_watcher', log_level=rospy.INFO)
        rospy.Subscriber('/capra_controlpanel/buttons', RobotButtons, self.handle_robot_buttons)
        rospy.Subscriber('/animatics_smartmotor/connected', MotorsConnected, self.handle_connected)
        disconnected_count = 0
        while True:
            if not self.estop_on and not self.connected:
                disconnected_count += 1
                if disconnected_count > 3:
                    disconnected_count = 0
                    self.restart_motor_node()
                    rospy.sleep(5)
            rospy.sleep(1)

    def restart_motor_node(self):
        rospy.logwarn("Restarting motor node...")
        rospy.sleep(0.5)  # Aucune idee si c'est necessaire...
        rosnode.kill_nodes(['animatics_smart_motor'])
        subprocess.Popen('rosrun animatics_smart_motor smart_motor_node.py', shell=True)

    def handle_robot_buttons(self, msg):
        self.estop_on = msg.estopremote or msg.estopmanual

    def handle_connected(self, msg):
        self.connected = msg.connected

if __name__ == '__main__':
    try:
        EStopWatcher()
    except rospy.ROSInterruptException:
        pass
