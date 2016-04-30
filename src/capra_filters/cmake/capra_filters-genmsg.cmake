# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "capra_filters: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(capra_filters_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv" NAME_WE)
add_custom_target(_capra_filters_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "capra_filters" "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(capra_filters
  "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_filters
)

### Generating Module File
_generate_module_cpp(capra_filters
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_filters
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(capra_filters_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(capra_filters_generate_messages capra_filters_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv" NAME_WE)
add_dependencies(capra_filters_generate_messages_cpp _capra_filters_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_filters_gencpp)
add_dependencies(capra_filters_gencpp capra_filters_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_filters_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(capra_filters
  "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_filters
)

### Generating Module File
_generate_module_lisp(capra_filters
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_filters
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(capra_filters_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(capra_filters_generate_messages capra_filters_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv" NAME_WE)
add_dependencies(capra_filters_generate_messages_lisp _capra_filters_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_filters_genlisp)
add_dependencies(capra_filters_genlisp capra_filters_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_filters_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(capra_filters
  "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_filters
)

### Generating Module File
_generate_module_py(capra_filters
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_filters
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(capra_filters_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(capra_filters_generate_messages capra_filters_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/capra/Ibex/src/capra_filters/srv/SaveFilterchain.srv" NAME_WE)
add_dependencies(capra_filters_generate_messages_py _capra_filters_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(capra_filters_genpy)
add_dependencies(capra_filters_genpy capra_filters_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS capra_filters_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_filters)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/capra_filters
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_filters_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_filters)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/capra_filters
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(capra_filters_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_filters)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_filters\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/capra_filters
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(capra_filters_generate_messages_py std_msgs_generate_messages_py)
