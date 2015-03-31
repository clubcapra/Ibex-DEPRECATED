#!/usr/bin/env python

import rospy
from geometry_msgs.msg import PoseStamped, PointStamped


class RVizGoalPublisher():

    def __init__(self):
        self.waypoints = {}
        rospy.Subscriber("/clicked_point", PointStamped, self.waypoint_received)
        self.markerpub = rospy.Publisher("/goal_manager/waypoint", PoseStamped, queue_size=10)

    def loop(self):
        rate = rospy.Rate(30)
        while not rospy.is_shutdown():
            # if list contains a message (posestamped), publish on /goal_manager/waypoint
            rate.sleep()

    def waypoint_received(self, msg):  # msg is PointStamped
        pose = PoseStamped()
        # convert pointstamped to posestamped
        # use default quaternion for orientation
        # add to self.waypoints


if __name__ == '__main__':
    rospy.init_node('goal_manager')
    try:
        RVizGoalPublisher()
    except rospy.ROSInterruptException: pass