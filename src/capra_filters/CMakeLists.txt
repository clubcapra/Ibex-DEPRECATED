cmake_minimum_required(VERSION 2.8.3)
project(capra_filters)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  rospy
  roscpp
  std_msgs
  nodelet
  dynamic_reconfigure
  cv_bridge
  image_transport
  message_generation
)

generate_dynamic_reconfigure_options(
  src/${PROJECT_NAME}/blur_filter.cfg
  src/${PROJECT_NAME}/rectangle.cfg
  src/${PROJECT_NAME}/section_filter.cfg
  src/${PROJECT_NAME}/perspective_calibration.cfg
  src/${PROJECT_NAME}/resize.cfg
  src/${PROJECT_NAME}/bgr2rgb.cfg
)

add_service_files(
  FILES
  SaveFilterchain.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

##################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
  INCLUDE_DIRS include
  LIBRARIES capra_filters
)

###########
## Build ##
###########

include_directories(include)

## Declare a C++ library
add_library(capra_filters
  src/${PROJECT_NAME}/blur_filter.cpp
  src/${PROJECT_NAME}/rectangle.cpp
  src/${PROJECT_NAME}/section_filter.cpp
  src/${PROJECT_NAME}/perspective_calibration.cpp
  src/${PROJECT_NAME}/resize.cpp
  src/${PROJECT_NAME}/bgr2rgb.cpp
)
target_link_libraries(capra_filters ${catkin_LIBRARIES})

## Add cmake target dependencies of the library
## as an example, code may need to be generated before libraries
## either from message generation or dynamic reconfigure
# add_dependencies(capra_filters ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
add_dependencies(capra_filters ${PROJECT_NAME}_gencfg)
