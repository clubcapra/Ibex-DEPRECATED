cmake_minimum_required(VERSION 2.8.3)
project(capra_lidar)


find_package(catkin REQUIRED COMPONENTS
    roscpp
    rospy
    sensor_msgs
    std_msgs
    laser_geometry
    tf
    )

catkin_package()

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable( scan_to_cloud_hf_node
    src/scan_to_cloud_hf_node.cpp )

target_link_libraries(scan_to_cloud_hf_node ${catkin_LIBRARIES} )

add_dependencies(scan_to_cloud_hf_node ${catkin_EXPORTED_TARGETS})

#Install node
#install(TARGETS scan_to_cloud_hf_node
#    RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
#    )
