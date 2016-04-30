#!/usr/bin/env python

import rospy
from nav_msgs.msg import OccupancyGrid
import numpy as np

class BeaconLocator:
    def __init__(self):
        rospy.init_node('beacon_locator', log_level=rospy.DEBUG)

        map_topic = rospy.get_param('~map_topic', '/map')
        beacon_size = rospy.get_param('~beacon_size', 0.25)
        beacon_dist = rospy.get_param('~beacon_dist', 3)
        beacon_dist_tol = rospy.get_param('~beacon_tol', 0.10)
        update_rate = rospy.get_param('~update_rate', 1)
        
        self.map = None

        rospy.Subscriber(map_topic, OccupancyGrid, self.handle_map)

        timer = rospy.Rate(update_rate)
        while not rospy.is_shutdown():
            if self.map is not None:
                meta = self.map.info
                width, height = meta.width, meta.height
                data = np.mat(self.map.data).reshape(width, height, order='F') 
                
                

            timer.sleep()

    def handle_map(self, msg):
        self.map = msg
        
        pass


if __name__ == '__main__':
    try:
        BeaconLocator()
    except rospy.ROSInterruptException:
        pass
    
