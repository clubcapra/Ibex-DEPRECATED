# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "capra_ai: 1 messages, 3 services")

set(MSG_I_FLAGS "-Icapra_ai:/home/capra/Ibex/src/capra_ai/msg;-Icapra_msgs:/home/capra/Ibex/src/capra_msgs/msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg;-Inav_msgs:/opt/ros/indigo/share/nav_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/indigo/share/sensor_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/indigo/share/actionlib_msgs/cmake/../msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(capra_ai_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv" NAME_WE)
add_custom_target(_capra_ai_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_ai" "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv" NAME_WE)
add_custom_target(_capra_ai_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_ai" "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv" "capra_ai/GoalWithPriority:actionlib_msgs/GoalID:geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/Pose"
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg" NAME_WE)
add_custom_target(_capra_ai_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_ai" "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg" "geometry_msgs/Quaternion:actionlib_msgs/GoalID:geometry_msgs/Point:geometry_msgs/Pose"
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv" NAME_WE)
add_custom_target(_capra_ai_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_ai" "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(capra_ai
  "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_ai
)

### Generating Services
_generate_srv_cpp(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_ai
)
_generate_srv_cpp(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv"
  "${MSG_I_FLAGS}"
  "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg;/opt/ros/indigo/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_ai
)
_generate_srv_cpp(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_ai
)

### Generating Module File
_generate_module_cpp(capra_ai
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_ai
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(capra_ai_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(capra_ai_generate_messages capra_ai_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_cpp _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_cpp _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg" NAME_WE)
add_dependencies(capra_ai_generate_messages_cpp _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_cpp _capra_ai_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_ai_gencpp)
add_dependencies(capra_ai_gencpp capra_ai_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_ai_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(capra_ai
  "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_ai
)

### Generating Services
_generate_srv_lisp(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_ai
)
_generate_srv_lisp(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv"
  "${MSG_I_FLAGS}"
  "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg;/opt/ros/indigo/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_ai
)
_generate_srv_lisp(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_ai
)

### Generating Module File
_generate_module_lisp(capra_ai
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_ai
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(capra_ai_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(capra_ai_generate_messages capra_ai_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_lisp _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_lisp _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg" NAME_WE)
add_dependencies(capra_ai_generate_messages_lisp _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_lisp _capra_ai_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_ai_genlisp)
add_dependencies(capra_ai_genlisp capra_ai_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_ai_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(capra_ai
  "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai
)

### Generating Services
_generate_srv_py(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai
)
_generate_srv_py(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv"
  "${MSG_I_FLAGS}"
  "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg;/opt/ros/indigo/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai
)
_generate_srv_py(capra_ai
  "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai
)

### Generating Module File
_generate_module_py(capra_ai
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(capra_ai_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(capra_ai_generate_messages capra_ai_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/CancelGoal.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_py _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/AddGoal.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_py _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/msg/GoalWithPriority.msg" NAME_WE)
add_dependencies(capra_ai_generate_messages_py _capra_ai_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_ai/srv/ClearGoalList.srv" NAME_WE)
add_dependencies(capra_ai_generate_messages_py _capra_ai_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_ai_genpy)
add_dependencies(capra_ai_genpy capra_ai_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_ai_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_ai)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_ai
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_ai_generate_messages_cpp capra_msgs_generate_messages_cpp)
add_dependencies(capra_ai_generate_messages_cpp geometry_msgs_generate_messages_cpp)
add_dependencies(capra_ai_generate_messages_cpp nav_msgs_generate_messages_cpp)
add_dependencies(capra_ai_generate_messages_cpp sensor_msgs_generate_messages_cpp)
add_dependencies(capra_ai_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
add_dependencies(capra_ai_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_ai)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_ai
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_ai_generate_messages_lisp capra_msgs_generate_messages_lisp)
add_dependencies(capra_ai_generate_messages_lisp geometry_msgs_generate_messages_lisp)
add_dependencies(capra_ai_generate_messages_lisp nav_msgs_generate_messages_lisp)
add_dependencies(capra_ai_generate_messages_lisp sensor_msgs_generate_messages_lisp)
add_dependencies(capra_ai_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
add_dependencies(capra_ai_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_ai
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(capra_ai_generate_messages_py capra_msgs_generate_messages_py)
add_dependencies(capra_ai_generate_messages_py geometry_msgs_generate_messages_py)
add_dependencies(capra_ai_generate_messages_py nav_msgs_generate_messages_py)
add_dependencies(capra_ai_generate_messages_py sensor_msgs_generate_messages_py)
add_dependencies(capra_ai_generate_messages_py actionlib_msgs_generate_messages_py)
add_dependencies(capra_ai_generate_messages_py std_msgs_generate_messages_py)
