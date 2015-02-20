cmake_minimum_required(VERSION 2.8.3)
project(capra_motor_calibrator)
find_package(catkin REQUIRED COMPONENTS
    rospy
    std_msgs
    message_generation
)
add_service_files(
    FILES
    CalibrateMotor.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs  # Or other packages containing msgs
)
catkin_package(
    CATKIN_DEPENDS
    message_runtime
)

