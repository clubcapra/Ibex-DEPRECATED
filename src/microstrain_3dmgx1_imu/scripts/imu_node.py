#!/usr/bin/env python

import roslib
roslib.load_manifest('microstrain_3dmgx1_imu')
import rospy
from includes.config import Config
from includes.imu3dmgx1 import imu3dmgx1
from sensor_msgs.msg import Imu
from microstrain_3dmgx1_imu.srv import Calibrate


def publish_imu_data():
    global imu, imu_publisher

    imu_data = Imu()

    imu_data.header.frame_id = "imu"
    imu_data.header.stamp = rospy.Time.from_sec(imu.last_update_time)

    # imu 3dmgx1 reports using the North-East-Down (NED) convention
    # so we need to convert to East-North-Up (ENU) coordinates according to ROS REP103
    # see http://answers.ros.org/question/626/quaternion-from-imu-interpreted-incorrectly-by-ros
    q = imu.orientation
    imu_data.orientation.w = q[0]
    imu_data.orientation.x = q[2]
    imu_data.orientation.y = q[1]
    imu_data.orientation.z = -q[3]
    imu_data.orientation_covariance = Config.get_orientation_covariance()

    av = imu.angular_velocity
    imu_data.angular_velocity.x = av[1]
    imu_data.angular_velocity.y = av[0]
    imu_data.angular_velocity.z = -av[2]
    imu_data.angular_velocity_covariance = Config.get_angular_velocity_covariance()

    la = imu.linear_acceleration
    imu_data.linear_acceleration.x = la[1]
    imu_data.linear_acceleration.y = la[0]
    imu_data.linear_acceleration.z = - la[2]
    imu_data.linear_acceleration_covariance = Config.get_linear_acceleration_covariance()

    imu_publisher.publish(imu_data)


def calibrate(req):
    global imu, calibrating
    calibrating = True
    rospy.loginfo("Starting calibration...")
    imu.calibrate(req.is_2d, req.magnitude_z, req.calibration_time)
    rospy.loginfo("The IMU is now calibrated!")
    calibrating = False
    return []


if __name__ == "__main__":
    rospy.init_node('microstrain_3dmgx1_node')

    imu = imu3dmgx1(Config.get_serial_port(), Config.get_baudrate())

    imu_publisher = rospy.Publisher("/imu_data", Imu, queue_size=10)
    calibration_service = rospy.Service('~calibrate', Calibrate, calibrate)
    calibrating = False
    r = rospy.Rate(Config.get_publish_rate())

    while not rospy.is_shutdown():
        if imu.connected:
            try:
                if not calibrating:
                    imu.update()
                    publish_imu_data()
                    r.sleep()
                else:
                    rospy.sleep(1)
            except Exception as ex:
                rospy.logerr(ex.message)
        else:
            imu.connect()
            if not imu.connected:
                rospy.sleep(0.1)
