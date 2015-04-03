#!/usr/bin/env python

import roslib
roslib.load_manifest('capra_camera')
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
import cv2


rospy.init_node('capra_camera')

try:
    USE_PV_CAM = True
    import camera
except:
    USE_PV_CAM = False
    rospy.logerr("Cannot open PvCamera. Missing camera library.")
    
if USE_PV_CAM:

    cam = camera.Camera()
    cam.initialize()
    cam.start()
    images = cam.getCam()
    
    bridge = CvBridge()
    image_pub = rospy.Publisher("~image_uncompressed", Image, queue_size=10)
    small_pub = rospy.Publisher("~small_uncompressed", Image, queue_size=10)
    r = rospy.Rate(6)
    
    while not rospy.is_shutdown():
        img = images[cam.getFrame()]
        small = cv2.resize(img, (0,0), fx=0.5, fy=0.5)
        image_pub.publish(bridge.cv2_to_imgmsg(img, "bgr8"))
        small_pub.publish(bridge.cv2_to_imgmsg(small, "bgr8"))
        r.sleep()    