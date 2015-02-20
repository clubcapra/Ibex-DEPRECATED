#!/usr/bin/env python

import roslib
roslib.load_manifest('capra_camera')
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
import cv2
import sys

rospy.init_node('capra_camera')

rate = rospy.Rate(20)

file = sys.argv[1]
img = cv2.imread(file)
bridge = CvBridge()
msg = bridge.cv2_to_imgmsg(img, encoding="passthrough")
image_pub = rospy.Publisher("~image_uncompressed", Image, queue_size=10)

while not rospy.is_shutdown():
    image_pub.publish(msg)
    rate.sleep()    