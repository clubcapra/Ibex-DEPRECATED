cmake_minimum_required(VERSION 2.8.3)
project(animatics_smart_motor)

find_package(catkin REQUIRED COMPONENTS
  message_generation
  geometry_msgs 
  nav_msgs
  rospy)

add_message_files(
  FILES
  MotorsConnected.msg
)

generate_messages(
  DEPENDENCIES
  geometry_msgs
  nav_msgs
)

catkin_package()

