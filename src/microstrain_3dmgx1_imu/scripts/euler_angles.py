#! /usr/bin/env python

import roslib; 
roslib.load_manifest('microstrain_3dmgx1_imu')
import rospy
from nav_msgs.msg import Odometry
from sensor_msgs.msg import Imu
from geometry_msgs.msg import PoseWithCovarianceStamped
import tf
import time
import math

yodom = 0
yimu = 0
yekf = 0

def callback(data):
    o = data.pose.pose.orientation
    r,p,y = tf.transformations.euler_from_quaternion([o.x, o.y, o.z, o.w])
    global yodom
    yodom = y

def callback2(data):
    o = data.orientation  
    r,p,y = tf.transformations.euler_from_quaternion([o.x, o.y, o.z, o.w])
    global yimu
    yimu = y
    
def callback3(data):
    o = data.pose.pose.orientation
    r,p,y = tf.transformations.euler_from_quaternion([o.x, o.y, o.z, o.w])
    global yekf
    yekf = y
    
def listener():

    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("/odom", Odometry, callback)
    rospy.Subscriber("/imu_data", Imu, callback2)
    rospy.Subscriber("/robot_pose_ekf/odom", PoseWithCovarianceStamped, callback3)
    
    while not rospy.is_shutdown():
        print "%f : %f : %f" % (round(yodom * 180 / math.pi) , round(yimu * 180 / math.pi), round(yekf*180 / math.pi))
        time.sleep(0.05)
    
    rospy.spin()
        
if __name__ == '__main__':
    listener()
