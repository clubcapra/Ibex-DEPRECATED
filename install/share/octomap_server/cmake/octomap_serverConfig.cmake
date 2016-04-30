# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list and remove existing duplicates from the list
# copied from catkin/cmake/list_append_deduplicate.cmake to keep pkgConfig
# self contained
macro(_list_append_deduplicate listname)
  if(NOT "${ARGN}" STREQUAL "")
    if(${listname})
      list(REMOVE_ITEM ${listname} ${ARGN})
    endif()
    list(APPEND ${listname} ${ARGN})
  endif()
endmacro()

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# pack a list of libraries with optional build configuration keywords
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_pack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  set(_argn ${ARGN})
  list(LENGTH _argn _count)
  set(_index 0)
  while(${_index} LESS ${_count})
    list(GET _argn ${_index} lib)
    if("${lib}" MATCHES "^(debug|optimized|general)$")
      math(EXPR _index "${_index} + 1")
      if(${_index} EQUAL ${_count})
        message(FATAL_ERROR "_pack_libraries_with_build_configuration() the list of libraries '${ARGN}' ends with '${lib}' which is a build configuration keyword and must be followed by a library")
      endif()
      list(GET _argn ${_index} library)
      list(APPEND ${VAR} "${lib}${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}${library}")
    else()
      list(APPEND ${VAR} "${lib}")
    endif()
    math(EXPR _index "${_index} + 1")
  endwhile()
endmacro()

# unpack a list of libraries with optional build configuration keyword prefixes
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_unpack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  foreach(lib ${ARGN})
    string(REGEX REPLACE "^(debug|optimized|general)${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}(.+)$" "\\1;\\2" lib "${lib}")
    list(APPEND ${VAR} "${lib}")
  endforeach()
endmacro()


if(octomap_server_CONFIG_INCLUDED)
  return()
endif()
set(octomap_server_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if("FALSE" STREQUAL "TRUE")
  set(octomap_server_SOURCE_PREFIX /home/capra/Ibex/src/octomap_mapping/octomap_server)
  set(octomap_server_DEVEL_PREFIX /home/capra/Ibex/devel)
  set(octomap_server_INSTALL_PREFIX "")
  set(octomap_server_PREFIX ${octomap_server_DEVEL_PREFIX})
else()
  set(octomap_server_SOURCE_PREFIX "")
  set(octomap_server_DEVEL_PREFIX "")
  set(octomap_server_INSTALL_PREFIX /home/capra/Ibex/install)
  set(octomap_server_PREFIX ${octomap_server_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'octomap_server' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(octomap_server_FOUND_CATKIN_PROJECT TRUE)

if(NOT "include;/usr/include/pcl-1.7;/usr/include/eigen3;/usr/include;/usr/include/ni;/usr/include/vtk-5.8 " STREQUAL " ")
  set(octomap_server_INCLUDE_DIRS "")
  set(_include_dirs "include;/usr/include/pcl-1.7;/usr/include/eigen3;/usr/include;/usr/include/ni;/usr/include/vtk-5.8")
  foreach(idir ${_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif("${idir} " STREQUAL "include ")
      get_filename_component(include "${octomap_server_DIR}/../../../include" ABSOLUTE)
      if(NOT IS_DIRECTORY ${include})
        message(FATAL_ERROR "Project 'octomap_server' specifies '${idir}' as an include dir, which is not found.  It does not exist in '${include}'.  Ask the maintainer 'Armin Hornung <hornunga@informatik.uni-freiburg.de>' to fix it.")
      endif()
    else()
      message(FATAL_ERROR "Project 'octomap_server' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in '/home/capra/Ibex/install/${idir}'.  Ask the maintainer 'Armin Hornung <hornunga@informatik.uni-freiburg.de>' to fix it.")
    endif()
    _list_append_unique(octomap_server_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "octomap_server;optimized;/usr/lib/libpcl_common.so;debug;/usr/lib/libpcl_common.so;optimized;/usr/lib/libpcl_kdtree.so;debug;/usr/lib/libpcl_kdtree.so;optimized;/usr/lib/libpcl_octree.so;debug;/usr/lib/libpcl_octree.so;optimized;/usr/lib/libpcl_search.so;debug;/usr/lib/libpcl_search.so;optimized;/usr/lib/libpcl_sample_consensus.so;debug;/usr/lib/libpcl_sample_consensus.so;optimized;/usr/lib/libpcl_io.so;debug;/usr/lib/libpcl_io.so;optimized;/usr/lib/libpcl_features.so;debug;/usr/lib/libpcl_features.so;optimized;/usr/lib/libpcl_segmentation.so;debug;/usr/lib/libpcl_segmentation.so;optimized;/usr/lib/libpcl_filters.so;debug;/usr/lib/libpcl_filters.so;/usr/lib/x86_64-linux-gnu/libboost_system.so;/usr/lib/x86_64-linux-gnu/libboost_filesystem.so;/usr/lib/x86_64-linux-gnu/libboost_thread.so;/usr/lib/x86_64-linux-gnu/libboost_date_time.so;/usr/lib/x86_64-linux-gnu/libboost_iostreams.so;/usr/lib/x86_64-linux-gnu/libboost_serialization.so;/usr/lib/x86_64-linux-gnu/libpthread.so;/usr/lib/libOpenNI.so;optimized;/usr/lib/x86_64-linux-gnu/libflann_cpp_s.a;debug;/usr/lib/x86_64-linux-gnu/libflann_cpp_s.a;/usr/lib/libvtkCommon.so.5.8.0;/usr/lib/libvtkRendering.so.5.8.0;/usr/lib/libvtkHybrid.so.5.8.0;/usr/lib/libvtkCharts.so.5.8.0")
foreach(library ${libraries})
  # keep build configuration keywords, target names and absolute libraries as-is
  if("${library}" MATCHES "^(debug|optimized|general)$")
    list(APPEND octomap_server_LIBRARIES ${library})
  elseif(TARGET ${library})
    list(APPEND octomap_server_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND octomap_server_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path /home/capra/Ibex/install/lib;/home/capra/Ibex/devel/lib;/opt/ros/indigo/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(octomap_server_LIBRARY_DIRS ${lib_path})
      list(APPEND octomap_server_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'octomap_server'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND octomap_server_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(octomap_server_EXPORTED_TARGETS "octomap_server_gencfg")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${octomap_server_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "roscpp;visualization_msgs;sensor_msgs;pcl_ros;pcl_conversions;nav_msgs;std_msgs;std_srvs;octomap_ros;octomap_msgs;dynamic_reconfigure;nodelet")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 octomap_server_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${octomap_server_dep}_FOUND)
      find_package(${octomap_server_dep} REQUIRED)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${octomap_server_dep} REQUIRED ${depend_list})
  endif()
  _list_append_unique(octomap_server_INCLUDE_DIRS ${${octomap_server_dep}_INCLUDE_DIRS})

  # merge build configuration keywords with library names to correctly deduplicate
  _pack_libraries_with_build_configuration(octomap_server_LIBRARIES ${octomap_server_LIBRARIES})
  _pack_libraries_with_build_configuration(_libraries ${${octomap_server_dep}_LIBRARIES})
  _list_append_deduplicate(octomap_server_LIBRARIES ${_libraries})
  # undo build configuration keyword merging after deduplication
  _unpack_libraries_with_build_configuration(octomap_server_LIBRARIES ${octomap_server_LIBRARIES})

  _list_append_unique(octomap_server_LIBRARY_DIRS ${${octomap_server_dep}_LIBRARY_DIRS})
  list(APPEND octomap_server_EXPORTED_TARGETS ${${octomap_server_dep}_EXPORTED_TARGETS})
endforeach()

set(pkg_cfg_extras "")
foreach(extra ${pkg_cfg_extras})
  if(NOT IS_ABSOLUTE ${extra})
    set(extra ${octomap_server_DIR}/${extra})
  endif()
  include(${extra})
endforeach()
