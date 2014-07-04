import roslib
roslib.load_manifest('animatics_smart_motor')
import rospy
from includes.motor_controller import MotorController
from includes.commands import *
from includes.config import Config

rospy.init_node('animatics_smart_motor')

motor_controller = MotorController()

error_count = 0
max_timeout_count = Config.get_max_timeout_count()
connected = False

while not rospy.is_shutdown():
    if connected:
        rospy.sleep(0.01)
        if motor_controller.update():
            error_count = 0
            #print motor_controller.position.x, motor_controller.position.y
        else:
            error_count += 1

        if error_count > max_timeout_count:
            rospy.logerr("Lost connection to the motors. Reconnecting...")
            motor_controller.disconnect()
            connected = False
            rospy.sleep(0.1)
    else:
        connected = motor_controller.initialize()
        if not connected:
            motor_controller.disconnect()
            rospy.sleep(0.5)
        else:
            rospy.loginfo("Connected to the motors.")
            motor_controller.set_velocity(0.3, 0.1)




