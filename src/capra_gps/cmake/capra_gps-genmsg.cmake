# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "capra_gps: 0 messages, 2 services")

set(MSG_I_FLAGS "-Inav_msgs:/opt/ros/indigo/share/nav_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/indigo/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/indigo/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(capra_gps_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv" NAME_WE)
add_custom_target(_capra_gps_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_gps" "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv" "geometry_msgs/Point:geometry_msgs/PoseWithCovariance:geometry_msgs/TwistWithCovariance:geometry_msgs/Vector3:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Twist:nav_msgs/Odometry:geometry_msgs/Pose"
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv" NAME_WE)
add_custom_target(_capra_gps_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_gps" "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv" "sensor_msgs/NavSatFix:geometry_msgs/Quaternion:sensor_msgs/NavSatStatus:std_msgs/Header:geometry_msgs/Point:geometry_msgs/PoseStamped:geometry_msgs/Pose"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(capra_gps
  "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/indigo/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_gps
)
_generate_srv_cpp(capra_gps
  "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/sensor_msgs/cmake/../msg/NavSatFix.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/sensor_msgs/cmake/../msg/NavSatStatus.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_gps
)

### Generating Module File
_generate_module_cpp(capra_gps
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_gps
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(capra_gps_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(capra_gps_generate_messages capra_gps_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv" NAME_WE)
add_dependencies(capra_gps_generate_messages_cpp _capra_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv" NAME_WE)
add_dependencies(capra_gps_generate_messages_cpp _capra_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_gps_gencpp)
add_dependencies(capra_gps_gencpp capra_gps_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_gps_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(capra_gps
  "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/indigo/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_gps
)
_generate_srv_lisp(capra_gps
  "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/sensor_msgs/cmake/../msg/NavSatFix.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/sensor_msgs/cmake/../msg/NavSatStatus.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_gps
)

### Generating Module File
_generate_module_lisp(capra_gps
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_gps
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(capra_gps_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(capra_gps_generate_messages capra_gps_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv" NAME_WE)
add_dependencies(capra_gps_generate_messages_lisp _capra_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv" NAME_WE)
add_dependencies(capra_gps_generate_messages_lisp _capra_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_gps_genlisp)
add_dependencies(capra_gps_genlisp capra_gps_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_gps_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(capra_gps
  "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/indigo/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_gps
)
_generate_srv_py(capra_gps
  "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/sensor_msgs/cmake/../msg/NavSatFix.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/sensor_msgs/cmake/../msg/NavSatStatus.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_gps
)

### Generating Module File
_generate_module_py(capra_gps
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_gps
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(capra_gps_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(capra_gps_generate_messages capra_gps_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/Rotate.srv" NAME_WE)
add_dependencies(capra_gps_generate_messages_py _capra_gps_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_gps/srv/AddLatlongGoal.srv" NAME_WE)
add_dependencies(capra_gps_generate_messages_py _capra_gps_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_gps_genpy)
add_dependencies(capra_gps_genpy capra_gps_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_gps_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_gps)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_gps
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_gps_generate_messages_cpp nav_msgs_generate_messages_cpp)
add_dependencies(capra_gps_generate_messages_cpp sensor_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_gps)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_gps
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_gps_generate_messages_lisp nav_msgs_generate_messages_lisp)
add_dependencies(capra_gps_generate_messages_lisp sensor_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_gps)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_gps\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_gps
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(capra_gps_generate_messages_py nav_msgs_generate_messages_py)
add_dependencies(capra_gps_generate_messages_py sensor_msgs_generate_messages_py)
