#!/usr/bin/env python
import csv
from capra_gps.srv import RotateRequest, Rotate
from enu.srv import ToENURequest, ToENUResponse, ToENU

from geometry_msgs.msg import Pose, PoseWithCovarianceStamped
from nav_msgs.msg import Odometry
from sensor_msgs.msg import Imu, NavSatFix
import math

import rospy
import tf


class WaypointOrientation:
    def __init__(self):
        rospy.init_node('waypoint_orientation')

        self.imu_datum = None
        self.imu_data = None
        self.enu_datum = None
        self.waypoints = list()
        self.sensitivity = rospy.get_param('~sensitivity', 1.5)
        self.next_waypoint = None
        self.position = None
        self.next_waypoint_publisher = rospy.Publisher("next_waypoint", Pose)
        #self.robot_pose_subscriber = rospy.Subscriber('/robot_pose_ekf/odom', PoseWithCovarianceStamped, self._kalman_listener)
        self.imu_datum_subscriber = rospy.Subscriber('/imu_datum', Imu, self._imu_datum_listener)
        self.imu_data_subscriber = rospy.Subscriber('/imu/data', Imu, self._imu_data_listener)
        self.enu_datum_subscriber = rospy.Subscriber('/gps/enu_datum', NavSatFix, self._enu_datum_listener)
        self.enu_subscriber = rospy.Subscriber('/gps/enu', Odometry, self._enu_listener)

        f = open(rospy.get_param('~file'), 'rt')
        try:
            reader = csv.reader(f)

            for waypoint in reader:
                for coord in waypoint:
                    self.waypoints.append([float(c.strip()) for c in coord.split(';')])
        finally:
            f.close()

    def publish_loop(self):
        r = rospy.Rate(10)
        while not rospy.is_shutdown():
            if self.waypoints is not None:
                if self.position is not None and self.imu_datum is not None and self.enu_datum is not None:
                    if self.next_waypoint is None or (self.position.pose.pose.position.x - self.next_waypoint.position.x) ** 2 + (self.position.pose.pose.position.y - self.next_waypoint.position.y) ** 2 < self.sensitivity ** 2:
                        if len(self.waypoints) == 0:
                            self.waypoints = None
                            return

                        waypoint = self.waypoints.pop(0)

                        to_enu = rospy.ServiceProxy('/gps/ToENU', ToENU)
                        request1 = ToENURequest()
                        request1.llh.latitude = waypoint[0]
                        request1.llh.longitude = waypoint[1]
                        request1.datum = self.enu_datum
                        response1 = to_enu(request1)

                        # rotate = rospy.ServiceProxy('/gps/rotate', Rotate)
                        # request2 = RotateRequest()
                        # request2.point.pose.pose.position.x = response1.
                        # request2.point.pose.pose.position.y = waypoint[1]
                        # response2 = rotate(request2)
                        
                        self.next_waypoint = Pose()
                        self.next_waypoint.position.x = response1.enu.x
                        self.next_waypoint.position.y = response1.enu.y


                    robot_orientation = self.imu_data.orientation
                    initial_orientation = self.imu_datum.orientation

                    r1, p1, y1 = tf.transformations.euler_from_quaternion((robot_orientation.x, robot_orientation.y, robot_orientation.z, robot_orientation.w))
                    r2, p2, y2 = tf.transformations.euler_from_quaternion((initial_orientation.x, initial_orientation.y, initial_orientation.z, initial_orientation.w))
                    imu_orientation = y1 + y2

                    print "imu_datum" + str(math.degrees(imu_orientation))


                    waypoint_orientation = tf.transformations.quaternion_from_euler(0, 0,  math.atan((self.next_waypoint.position.x - self.position.pose.pose.position.x) / ( self.next_waypoint.position.y - self.position.pose.pose.position.y)) - imu_orientation)

                    print "gps"+str(math.degrees(math.atan((self.next_waypoint.position.x - self.position.pose.pose.position.x) / ( self.next_waypoint.position.y - self.position.pose.pose.position.y))))

                    self.next_waypoint.orientation.x = waypoint_orientation[0]
                    self.next_waypoint.orientation.y = waypoint_orientation[1]
                    self.next_waypoint.orientation.z = waypoint_orientation[2]
                    self.next_waypoint.orientation.w = waypoint_orientation[3]
                    self.next_waypoint_publisher.publish(self.next_waypoint)
            r.sleep()

    # def _kalman_listener(self, msg):
    #     self.position = msg
        
    def _imu_datum_listener(self, msg):
        self.imu_datum = msg

    def _imu_data_listener(self, msg):
        self.imu_data = msg

    def _enu_datum_listener(self, msg):
        self.enu_datum = msg

    def _enu_listener(self, msg):
        self.position = msg

if __name__ == '__main__':
    er = WaypointOrientation()
    er.publish_loop()