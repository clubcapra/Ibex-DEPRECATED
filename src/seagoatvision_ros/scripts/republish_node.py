#! /usr/bin/env python


import rospy
import os
import rospy
from subprocess import call

class RepublishNode:

    def __init__(self):

        rospy.init_node('republish_node')
        #call(["rosrun", "image_transport republish"])

        topic_in = rospy.get_param('~in', "/image_raw")
        topic_out = rospy.get_param('~out', "~")
        command = "rosrun image_transport republish raw in:=" + topic_in + " out:=" + topic_out

        call(command, shell=True)

if __name__ == "__main__":
    try:
        s = RepublishNode()
    except rospy.ROSInterruptException:
        pass
