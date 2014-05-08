#!/usr/bin/env python

#include <ros/ros.h>
#include <tf/transform_broadcaster.h>

#int main(int argc, char** argv){
#  ros::init(argc, argv, "robot_tf_publisher");
#  ros::NodeHandle n;
#
#  ros::Rate r(100);
#
#  tf::TransformBroadcaster broadcaster;
#
#  while(n.ok()){
#    broadcaster.sendTransform(
#      tf::StampedTransform(
#        tf::Transform(tf::Quaternion(0, 0, 0, 1), tf::Vector3(0.1, 0.0, 0.2)),
#        ros::Time::now(),"base_link", "base_laser"));
#    r.sleep();
#  }
#}



import roslib
roslib.load_manifest('transformations')
import rospy

import tf
from tf.broadcaster import TransformBroadcaster
from nav_msgs.msg import Odometry

broadcaster = TransformBroadcaster()
position = (0, 0, 0)
orientation = (0, 0, 0, 1)

def handle_odom(msg):
    pose = msg.pose.pose
    global position
    global orientation
    position = (pose.position.x, pose.position.y, 0)
    orientation = (pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w)

if __name__ == '__main__':
    rospy.init_node('tf_broadcaster')
    rospy.Subscriber('/capra_smartmotor/odom',
                     Odometry,
                     handle_odom)

    while not rospy.is_shutdown():
        broadcaster.sendTransform(position, orientation, rospy.Time.now(), "base_link", "odom")
        #Changer les valeurs, c'est de la scrap
        broadcaster.sendTransform((0.0, 0.0, 0.2), 
                                  (0, 0, 0, 1),
                                  rospy.Time.now(),
                                  "base_link",
                                  "laser")
        rospy.sleep(0.1)
    rospy.spin()