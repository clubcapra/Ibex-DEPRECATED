#! /usr/bin/env python

#    Copyright (C) 2012  Club Capra - capra.etsmtl.ca
#
#    This file is part of CapraVision.
#    
#    CapraVision is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

import cv2
import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge

bridge = CvBridge()

def handle_image(req):
    global image

    raw_image = bridge.imgmsg_to_cv2(req, desired_encoding="passthrough")
    image = RosImage.TimestampedImage(raw_image, req.header.stamp)
    #print "got image"

class RosImage:
    """Return images from  a ros topic."""

    def __init__(self):
        self.topic = rospy.get_param('~image_input', "/image_raw")
        print self.topic
        self.timeout = rospy.get_param('~timeout', 1.0)
        rospy.Subscriber(self.topic, Image, handle_image)

        rospy.loginfo("Seagoat RosImage source subscribed to " + self.topic)

    def __iter__(self):
        return self

    def next(self):
        start = rospy.get_time()
        while 'image' not in globals():
            if rospy.get_time() - start > self.timeout:
                rospy.logwarn("Timed out waiting for image on topic " + self.topic)
                return None
            rospy.sleep(0.01)

        global image
        return image

    def close(self):
        pass

    class TimestampedImage:
        def __init__(self, img, stamp):
            self.image = img
            self.stamp = stamp

        def __getattr__(self, item):
            return getattr(self.image, item)
