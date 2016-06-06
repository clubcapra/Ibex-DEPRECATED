#!/usr/bin/env python

import rospy
from std_srvs.srv import Empty
from octomap_msgs.srv import BoundingBoxQuery
import tf
from geometry_msgs.msg import Point

rospy.init_node('clear_octomap')

listener = tf.TransformListener()
clear_bbx = rospy.ServiceProxy('/octomap_server/clear_bbx', BoundingBoxQuery)


def handle_request(req):
    try:
        ((x, y, z), rot) = listener.lookupTransform("/map", "/base_link", rospy.Time(0))

        clear_bbx(Point(x - 5, y - 5, z), Point(x + 5, y + 5, z))
    except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException) as e:
        pass



rospy.Service('/capra_2dnav/clear_octomap', Empty, handle_request)

rospy.spin()
