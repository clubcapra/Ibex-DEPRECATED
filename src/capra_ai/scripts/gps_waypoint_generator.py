#!/usr/bin/env python

import rospy
import json
import os
import datetime
import threading
from nav_msgs.msg import Odometry

class GpsWaypointGenerator():

    def __init__(self):
        rospy.init_node("gps_waypoint_generator",  anonymous=True)
        self.currentData = None
        self.lock = threading.Lock()
        self.path = rospy.get_param("~output_location")
        self.waypoints = list()
        self.file = None


        if os.path.isdir(self.path): #If it's a path to a directory
            self.path = os.path.join(self.path, datetime.datetime.now().strftime("%Y%m%d%H%M") + "-gps.json") #We generate a file name


        if not os.path.exists(self.path): #If the file doesn't exist
            with open(self.path, 'w') as c: # We create it
                pass

        self.gps_subscriber = rospy.Subscriber("/fix", Odometry, self.callback)




    def callback(self, data):
        rospy.loginfo("I heard %s", data.data)

        self.lock.acquire()
        self.currentData = data
        self.lock.release()


    def keep(self, data):
        if data == None:
            rospy.loginfo("No GPS data")
            return

        rospy.loginfo(data.data)
        self.waypoints.append({'x': 0, 'y': 0, 'gps':1, 'priorite':0}) # TODO: Put real values here.
        self.file.seek(0)
        self.write(json.dumps(self.waypoints))
        self.truncate()



    def start(self):

        # Read and parse JSON waypoints already stored in the file - from a previous session
        self.file = open(self.path, 'r+')
        rawjson = self.file.read().strip()
        if len(rawjson) != 0:
            waypoints = json.loads(rawjson)



        while True:
            cmd = raw_input("Press [ENTER] (or Q + [ENTER] to exit): ")
            if cmd.upper() == "Q":
                break

            self.lock.acquire()
            safe = self.currentData
            self.lock.release()

            self.keep(safe)




if __name__ == "__main__":
    g = GpsWaypointGenerator()
    g.start()