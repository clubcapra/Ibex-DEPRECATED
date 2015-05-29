#!/usr/bin/env python

import rospy
from interactive_markers.interactive_marker_server import *
from interactive_markers.menu_handler import *
from visualization_msgs.msg import *


class MarkerManager():

    def __init__(self):
        self.markers = {}
        self.server = InteractiveMarkerServer("goal_marker_server")

    def process_feedback(self, feedback):
        p = feedback.pose.position
        rospy.loginfo("%s is now at (%f, %f, %f)" % (feedback.marker_name, p.x, p.y, p.z))

    def check_marker(self, name):
        rospy.loginfo("Checking if marker %s exists" % name)
        return name in self.markers

    def update_marker(self, name, x, y):
        rospy.loginfo("Updating marker %s" % name)
        if self.check_marker(name):
            marker = self.markers[name]
            marker.pose.position = x
            marker.pose.position = y
        else:
            rospy.logerr("Marker %s not found" % name)
        self.server.applyChanges()

    # name should be goal id
    def create_marker(self, frame='odom', name=None, callback=None):
        if not name:
            now = rospy.get_rostime()
            name = "%s_%i_%i" % (rospy.get_name(), now.secs, now.nsecs)
        if not callback:
            callback = self.process_feedback

        int_marker = InteractiveMarker()
        int_marker.header.frame_id = frame
        int_marker.name = name
        int_marker.description = name

        # create a grey box for the marker
        box_marker = Marker()
        box_marker.type = Marker.CUBE
        box_marker.scale.x = 0.45
        box_marker.scale.y = 0.45
        box_marker.scale.z = 0.45
        box_marker.color.r = 0.0
        box_marker.color.g = 0.5
        box_marker.color.b = 0.5
        box_marker.color.a = 1.0

        # create a non-interactive control which contains the box
        box_control = InteractiveMarkerControl()
        box_control.always_visible = True
        box_control.markers.append(box_marker)

        # add the control to the interactive marker
        int_marker.controls.append(box_control)

        # create a control which will move the box
        # this control does not contain any markers,
        # which will cause RViz to insert two arrows
        control = InteractiveMarkerControl()
        control.orientation.w = 1;
        control.orientation.x = 0;
        control.orientation.y = 1;
        control.orientation.z = 0;
        control.name = "move_x"
        control.interaction_mode = InteractiveMarkerControl.MOVE_PLANE
        int_marker.controls.append(control);

        self.markers[name] = int_marker

        # add the interactive marker to our collection &
        # tell the server to call processFeedback() when feedback arrives for it
        self.server.insert(int_marker, callback)

        rospy.loginfo("Created marker %s" % name)

        # 'commit' changes and send to all clients
        self.server.applyChanges()

        return int_marker