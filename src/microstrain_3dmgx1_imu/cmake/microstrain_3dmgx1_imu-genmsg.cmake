# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "microstrain_3dmgx1_imu: 0 messages, 1 services")

set(MSG_I_FLAGS "-Isensor_msgs:/opt/ros/indigo/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(microstrain_3dmgx1_imu_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv" NAME_WE)
add_custom_target(_microstrain_3dmgx1_imu_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "microstrain_3dmgx1_imu" "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(microstrain_3dmgx1_imu
  "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/microstrain_3dmgx1_imu
)

### Generating Module File
_generate_module_cpp(microstrain_3dmgx1_imu
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/microstrain_3dmgx1_imu
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(microstrain_3dmgx1_imu_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(microstrain_3dmgx1_imu_generate_messages microstrain_3dmgx1_imu_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv" NAME_WE)
add_dependencies(microstrain_3dmgx1_imu_generate_messages_cpp _microstrain_3dmgx1_imu_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(microstrain_3dmgx1_imu_gencpp)
add_dependencies(microstrain_3dmgx1_imu_gencpp microstrain_3dmgx1_imu_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS microstrain_3dmgx1_imu_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(microstrain_3dmgx1_imu
  "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/microstrain_3dmgx1_imu
)

### Generating Module File
_generate_module_lisp(microstrain_3dmgx1_imu
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/microstrain_3dmgx1_imu
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(microstrain_3dmgx1_imu_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(microstrain_3dmgx1_imu_generate_messages microstrain_3dmgx1_imu_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv" NAME_WE)
add_dependencies(microstrain_3dmgx1_imu_generate_messages_lisp _microstrain_3dmgx1_imu_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(microstrain_3dmgx1_imu_genlisp)
add_dependencies(microstrain_3dmgx1_imu_genlisp microstrain_3dmgx1_imu_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS microstrain_3dmgx1_imu_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(microstrain_3dmgx1_imu
  "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/microstrain_3dmgx1_imu
)

### Generating Module File
_generate_module_py(microstrain_3dmgx1_imu
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/microstrain_3dmgx1_imu
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(microstrain_3dmgx1_imu_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(microstrain_3dmgx1_imu_generate_messages microstrain_3dmgx1_imu_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/microstrain_3dmgx1_imu/srv/Calibrate.srv" NAME_WE)
add_dependencies(microstrain_3dmgx1_imu_generate_messages_py _microstrain_3dmgx1_imu_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(microstrain_3dmgx1_imu_genpy)
add_dependencies(microstrain_3dmgx1_imu_genpy microstrain_3dmgx1_imu_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS microstrain_3dmgx1_imu_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/microstrain_3dmgx1_imu)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/microstrain_3dmgx1_imu
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(microstrain_3dmgx1_imu_generate_messages_cpp sensor_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/microstrain_3dmgx1_imu)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/microstrain_3dmgx1_imu
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(microstrain_3dmgx1_imu_generate_messages_lisp sensor_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/microstrain_3dmgx1_imu)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/microstrain_3dmgx1_imu\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/microstrain_3dmgx1_imu
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(microstrain_3dmgx1_imu_generate_messages_py sensor_msgs_generate_messages_py)
