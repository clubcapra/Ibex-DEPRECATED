cmake_minimum_required(VERSION 2.8.3)
project(capra_motor_calibrator)
find_package(catkin REQUIRED COMPONENTS
    rospy
)
add_service_files(
    FILES
    CalibrateMotor.srv
)

catkin_package(
    CATKIN_DEPENDS
)
