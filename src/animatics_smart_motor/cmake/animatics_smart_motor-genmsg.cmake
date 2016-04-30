# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "animatics_smart_motor: 1 messages, 0 services")

set(MSG_I_FLAGS "-Ianimatics_smart_motor:/home/capra/Ibex/src/animatics_smart_motor/msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg;-Inav_msgs:/opt/ros/indigo/share/nav_msgs/cmake/../msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/indigo/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(animatics_smart_motor_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg" NAME_WE)
add_custom_target(_animatics_smart_motor_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "animatics_smart_motor" "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(animatics_smart_motor
  "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/animatics_smart_motor
)

### Generating Services

### Generating Module File
_generate_module_cpp(animatics_smart_motor
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/animatics_smart_motor
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(animatics_smart_motor_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(animatics_smart_motor_generate_messages animatics_smart_motor_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg" NAME_WE)
add_dependencies(animatics_smart_motor_generate_messages_cpp _animatics_smart_motor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(animatics_smart_motor_gencpp)
add_dependencies(animatics_smart_motor_gencpp animatics_smart_motor_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS animatics_smart_motor_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(animatics_smart_motor
  "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/animatics_smart_motor
)

### Generating Services

### Generating Module File
_generate_module_lisp(animatics_smart_motor
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/animatics_smart_motor
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(animatics_smart_motor_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(animatics_smart_motor_generate_messages animatics_smart_motor_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg" NAME_WE)
add_dependencies(animatics_smart_motor_generate_messages_lisp _animatics_smart_motor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(animatics_smart_motor_genlisp)
add_dependencies(animatics_smart_motor_genlisp animatics_smart_motor_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS animatics_smart_motor_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(animatics_smart_motor
  "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/animatics_smart_motor
)

### Generating Services

### Generating Module File
_generate_module_py(animatics_smart_motor
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/animatics_smart_motor
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(animatics_smart_motor_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(animatics_smart_motor_generate_messages animatics_smart_motor_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/animatics_smart_motor/msg/MotorsConnected.msg" NAME_WE)
add_dependencies(animatics_smart_motor_generate_messages_py _animatics_smart_motor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(animatics_smart_motor_genpy)
add_dependencies(animatics_smart_motor_genpy animatics_smart_motor_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS animatics_smart_motor_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/animatics_smart_motor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/animatics_smart_motor
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(animatics_smart_motor_generate_messages_cpp geometry_msgs_generate_messages_cpp)
add_dependencies(animatics_smart_motor_generate_messages_cpp nav_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/animatics_smart_motor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/animatics_smart_motor
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(animatics_smart_motor_generate_messages_lisp geometry_msgs_generate_messages_lisp)
add_dependencies(animatics_smart_motor_generate_messages_lisp nav_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/animatics_smart_motor)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/animatics_smart_motor\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/animatics_smart_motor
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(animatics_smart_motor_generate_messages_py geometry_msgs_generate_messages_py)
add_dependencies(animatics_smart_motor_generate_messages_py nav_msgs_generate_messages_py)
