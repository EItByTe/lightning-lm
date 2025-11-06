# - Try to find glog
# Once done this will define
#
#  GLOG_FOUND - System has glog
#  GLOG_INCLUDE_DIR - The glog include directories
#  GLOG_LIBRARIES - The libraries needed to use glog

# Based on the FindGlog.cmake from the Ceres project.

if(NOT GLOG_FOUND)
  if(NOT CMAKE_WINDOWS)
    find_package(PkgConfig)
    if(PKG_CONFIG_FOUND)
      pkg_check_modules(PC_GLOG glog)
    endif(PKG_CONFIG_FOUND)
  endif(NOT CMAKE_WINDOWS)

  find_path(GLOG_INCLUDE_DIR glog/logging.h
            PATHS ${PC_GLOG_INCLUDE_DIRS}
            /usr/include /usr/local/include /opt/local/include /sw/include)

  find_library(GLOG_LIBRARY glog
               PATHS ${PC_GLOG_LIBRARY_DIRS}
                     /usr/lib /usr/local/lib /opt/local/lib /sw/lib /usr/lib64)

  if(GLOG_INCLUDE_DIR AND GLOG_LIBRARY)
    set(GLOG_FOUND TRUE)
    set(GLOG_LIBRARIES ${GLOG_LIBRARY})
    message(STATUS "Found glog: ${GLOG_LIBRARY}")
  else(GLOG_INCLUDE_DIR AND GLOG_LIBRARY)
    set(GLOG_FOUND FALSE)
    message(STATUS "Glog not found.")
  endif(GLOG_INCLUDE_DIR AND GLOG_LIBRARY)

  # Handle the QUIETLY and REQUIRED arguments and set GLOG_FOUND to TRUE
  # if all listed variables are TRUE
  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(glog DEFAULT_MSG
                                    GLOG_LIBRARY GLOG_INCLUDE_DIR)

  if(GLOG_FOUND)
    set(GLOG_INCLUDE_DIRS ${GLOG_INCLUDE_DIR})
    set(GLOG_LIBRARIES ${GLOG_LIBRARY})
  endif(GLOG_FOUND)

  mark_as_advanced(GLOG_INCLUDE_DIR GLOG_LIBRARY)
endif(NOT GLOG_FOUND)