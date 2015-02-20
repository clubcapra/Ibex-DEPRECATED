#! /usr/bin/env python
import roslib
roslib.load_manifest('capra_lidar')
import rospy
from threading import Event
from sensor_msgs.msg import Imu
from geometry_msgs.msg import Pose2D
from tf.transformations import quaternion_from_euler


def callback(data):
    global angle, evt
    angle = data.theta
    evt.set()


evt = Event()
angle = 0.0
rospy.init_node('fake_imu', anonymous=True)
pub = rospy.Publisher('/imu_data', Imu, queue_size=10)
rospy.Subscriber("/pose2D", Pose2D, callback)

while not rospy.is_shutdown():
    evt.wait(timeout=1.0/60)
    evt.clear()
    imu = Imu()
    quat = quaternion_from_euler(0, 0, angle)
    imu.orientation.z = quat[2]
    imu.orientation.w = quat[3]
    imu.orientation_covariance = [0, 0, 0,
                                  0, 0, 0,
                                  0, 0, 0.0001225]

    imu.header.stamp = rospy.Time.now()
    imu.header.frame_id = "/base_footprint"
    pub.publish(imu)
