# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "capra_msgs: 3 messages, 11 services")

set(MSG_I_FLAGS "-Icapra_msgs:/home/capra/Ibex/src/capra_msgs/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(capra_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg" ""
)

get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv" NAME_WE)
add_custom_target(_capra_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_msgs" "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_msg_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_msg_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)

### Generating Services
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)
_generate_srv_cpp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
)

### Generating Module File
_generate_module_cpp(capra_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(capra_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(capra_msgs_generate_messages capra_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_cpp _capra_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_msgs_gencpp)
add_dependencies(capra_msgs_gencpp capra_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_msgs_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_msg_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_msg_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)

### Generating Services
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)
_generate_srv_lisp(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
)

### Generating Module File
_generate_module_lisp(capra_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(capra_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(capra_msgs_generate_messages capra_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_lisp _capra_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_msgs_genlisp)
add_dependencies(capra_msgs_genlisp capra_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_msgs_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_msg_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_msg_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)

### Generating Services
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)
_generate_srv_py(capra_msgs
  "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
)

### Generating Module File
_generate_module_py(capra_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(capra_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(capra_msgs_generate_messages capra_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StartAcquisition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/AiStatus.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/SetWheelSpeed.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ModuleToggle.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/GenerateObstacle.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/InitializeHardIronFieldCalibration.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ToggleLight.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/StopAcquisition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ComputeHardIronFieldCalibration.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/EStopStatus.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/AddGoal.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/ResetPosition.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/msg/SensorsTelemetry.msg" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/capra/Ibex/src/capra_msgs/srv/CollectHardIronFieldCalibrationData.srv" NAME_WE)
add_dependencies(capra_msgs_generate_messages_py _capra_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_msgs_genpy)
add_dependencies(capra_msgs_genpy capra_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
add_dependencies(capra_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
add_dependencies(capra_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(capra_msgs_generate_messages_py std_msgs_generate_messages_py)
add_dependencies(capra_msgs_generate_messages_py geometry_msgs_generate_messages_py)
