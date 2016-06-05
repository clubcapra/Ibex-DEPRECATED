#!/usr/bin/env python

import cv2
from cv_bridge import CvBridge, CvBridgeError
import rospy
from sensor_msgs.msg import Image

rospy.init_node('webcam_node')

bridge = CvBridge()

webcam = cv2.VideoCapture(0)
pub = rospy.Publisher("/webcam", Image, queue_size=10)

if webcam.isOpened(): # try to get the first frame
    rval, frame = webcam.read()
else:
    rval = False

while rval and not rospy.is_shutdown():
    msg = bridge.cv2_to_imgmsg(frame, encoding="bgr8")
    msg.header.stamp = rospy.Time.now()
    pub.publish(msg)
    val, frame = webcam.read()
