#!/usr/bin/env python

import rospy
import json
import os
import datetime
import threading
import copy
from sensor_msgs.msg import NavSatFix

class GpsWaypointGenerator():

    def __init__(self):
        rospy.init_node("gps_waypoint_generator",  anonymous=True)
        self.currentData = None
        self.lock = threading.Lock()
        self.path = rospy.get_param("~output_location")
        self.waypoints = list()
        self.file = None


        if os.path.isdir(self.path): #If it's a path to a directory
            self.path = os.path.join(self.path, datetime.datetime.now().strftime("%Y%m%d%H%M") + "-gps.json") #We provide a file name


        if not os.path.exists(self.path): #If the file doesn't exist
            with open(self.path, 'w') as c: # We create it
                pass

        self.gps_subscriber = rospy.Subscriber("/gps/fix", NavSatFix, self.callback)




    def callback(self, data):
        self.lock.acquire()
        self.currentData = data
        self.lock.release()


    def keep(self):

        self.lock.acquire()
        data = copy.copy(self.currentData)
        self.currentData = None
        self.lock.release()

        if data == None:
            rospy.loginfo("No GPS data")
            return

        self.waypoints.append({'x': data.latitude, 'y': data.longitude, 'gps':1, 'priorite':0})
        self.file.seek(0)
        self.file.write(json.dumps(self.waypoints))
        self.file.truncate()



    def start(self):
        # Read and parse JSON waypoints already stored in a previous session
        self.file = open(self.path, 'r+')
        rawjson = self.file.read().strip()
        if len(rawjson) != 0:
            waypoints = json.loads(rawjson)

        while not rospy.is_shutdown():
            cmd = raw_input("Press [ENTER] (or Q + [ENTER] to exit): ")
            if cmd.upper() == "Q":
                break

            self.keep()
            rospy.sleep(1.)

if __name__ == "__main__":
    try:
        g = GpsWaypointGenerator()
        g.start()
    except rospy.ROSInterruptException:
        pass