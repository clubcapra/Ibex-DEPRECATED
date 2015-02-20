cmake_minimum_required(VERSION 2.8.3)
project(microstrain_3dmgx1_imu)

find_package(catkin REQUIRED COMPONENTS
  message_generation
  rospy
  sensor_msgs
)

add_service_files(
  FILES
  Calibrate.srv
)

generate_messages(
  DEPENDENCIES
  sensor_msgs
)

catkin_package()

