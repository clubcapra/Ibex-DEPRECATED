#!/usr/bin/env python

import rospy
import os
import datetime
from sensor_msgs.msg import NavSatFix

class GpsPointRecorder():

    def __init__(self):
        rospy.init_node("gps_point_recorder",  anonymous=True)
        self.path = rospy.get_param("~output_location")
        self.interval = rospy.get_param("~record_interval", 2)

        if os.path.isdir(self.path): #If it's a path to a directory
            self.path = os.path.join(self.path, datetime.datetime.now().strftime("%Y-%m-%d-%H:%M:%S") + "-recorder-gps.txt") #We provide a file name
        else:
            rospy.logerr("Couldn't create gps point recorder log file.")

        self.fpoints = open(self.path, 'a')
        self.last_saved = rospy.get_time()

        self.gps_subscriber = rospy.Subscriber("/gps/fix", NavSatFix, self.callback)
        rospy.spin()

    def callback(self, data):
        if (rospy.get_time() - self.last_saved) < self.interval:
            return

        try:
            self.fpoints.write("{};{};100\n".format(data.longitude, data.latitude))
            self.fpoints.flush()
            self.last_saved = rospy.get_time()
        except IOError:
            rospy.logerr(IOError.message)


if __name__ == "__main__":
    try:
        a = GpsPointRecorder()
    except rospy.ROSInterruptException:
        pass