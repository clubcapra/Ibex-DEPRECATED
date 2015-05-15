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
        rospy.Subscriber('/animatics_smart_motor/connected', MotorsConnected, self.handle_connected)
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
        rospy.sleep(2)
        subprocess.Popen('roslaunch animatics_smart_motor SmartMotor.launch', shell=True)

    def handle_robot_buttons(self, msg):
        last_state = self.estop_on
        self.estop_on = not msg.estopremote or not msg.estopmanual
        if last_state != self.estop_on:
            rospy.loginfo("EStop state: %s" % ("On" if self.estop_on else "Off"))

    def handle_connected(self, msg):
        last_state = self.connected
        self.connected = msg.connected
        if last_state != self.connected:
            rospy.loginfo("Motors state: %s" % ("Connected" if self.connected else "Disconnected"))

if __name__ == '__main__':
    try:
        EStopWatcher()
    except rospy.ROSInterruptException:
        pass
