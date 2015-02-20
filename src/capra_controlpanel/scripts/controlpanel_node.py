#!/usr/bin/env python

import rospy
import threading
from capra_controlpanel.msg import *
from capra_controlpanel.srv import *

import comm.communication
from comm.communication import Communication

flash_state = False

def handle_controlpanel_set(req):
    rospy.loginfo("got call SET with param " + req.name + " and " + str(req.state))
    cmd = "ON"
    if req.state is False:
        cmd = "OFF"

    send("SET " + req.name + " " + cmd)

    return True

def handle_controlpanel_flash(req):
    global flash_state

    rospy.loginfo("got call FLASH with param " + str(req.state))

    if req.state is True and  flash_state is False:
        flash_state = True
        flash_thread = threading.Thread(target = flash, args = (rospy.get_param('~flash_rate'),))
        flash_thread.start()

    if req.state is False and flash_state is True:
        flash_state = False

    return True

def flash(rate):
    global flash_state

    light_on = True

    while flash_state:

        if light_on is True:
            light_on = False
            send("SET LIGHTS OFF")
        else:
            light_on = True
            send("SET LIGHTS ON")

        sleep_time = 1.0/rate
        rospy.sleep(sleep_time)

def send(cmd):

    status, reply = comm.communication.instance.send_command(cmd)

    if not status:
        reply = "communication error"

    if reply is None:
        reply = ""
    else:
        rospy.logdebug("handle_controlpanel_set: sending response to client: '" + reply + "'")

    return reply


class ControlPanelServer:

    def __init__(self):

        rospy.init_node('capra_controlpanel')

        pub_robot_buttons = rospy.Publisher("~buttons", RobotButtons, queue_size=10)
        pub_robot_analog_values = rospy.Publisher("~analog_values", RobotAnalogValues, queue_size=10)

        ids = rospy.get_param('~sensor_ids')
        s_set = rospy.Service('capra_controlpanel/set', Set, handle_controlpanel_set)
        s_flash = rospy.Service('capra_controlpanel/flash', Flash, handle_controlpanel_flash)

        comm.communication.instance = Communication(ids, rospy.get_param('~serial_port'), 19200)
        success = comm.communication.instance.start()
        if not success:
            rospy.logfatal("Unable to start controlpanel node")
            sys.exit()
        else:
            rospy.loginfo("Controlpanel connected to serial port")
        comm.communication.stop_all = False

        rate = rospy.get_param('~publish_rate')
        r = rospy.Rate(rate)

        rospy.loginfo("Starting controlpanel. Message rate(hz): " + str(r))
        while not rospy.is_shutdown():

            #Read button data
            robot_buttons = RobotButtons()
            fields = robot_buttons.__slots__
            for field in fields:
                status, reply = comm.communication.instance.send_command("GET " + field)

                if status is False:
                    rospy.logerr("Error reading '" + field)
                else:
                    reply_value = reply.split(" ")[1]
                    if type(robot_buttons.__getattribute__(field)) is bool:
                        if "OFF" in reply:
                            robot_buttons.__setattr__(field, False)
                        else:
                            robot_buttons.__setattr__(field, True)
                    else:
                        robot_buttons.__setattr__(field, str(reply_value))

            rospy.loginfo(robot_buttons)
            pub_robot_buttons.publish(robot_buttons)

            #Read analog data
            robot_analog_values = RobotAnalogValues()
            fields = robot_analog_values.__slots__
            for field in fields:
                status, reply = comm.communication.instance.send_command("GET " + field)

                if status is False:
                    rospy.logerr( "Error reading '" + field )
                else:
                    robot_analog_values.__setattr__(field, float(reply.split(" ")[1]))

            rospy.loginfo(robot_analog_values)
            pub_robot_analog_values.publish(robot_analog_values)

            r.sleep()
        rospy.spin()

if __name__ == "__main__":
    try:
        ControlPanelServer()
    except rospy.ROSInterruptException:
        pass
