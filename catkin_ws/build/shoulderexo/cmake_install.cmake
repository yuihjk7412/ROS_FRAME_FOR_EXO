# Install script for directory: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/shoulderexo/msg" TYPE FILE FILES
    "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/msg/Limbpos.msg"
    "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/msg/Encoder.msg"
    "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/msg/Motor_Force.msg"
    "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/msg/Sysstatus.msg"
    "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/msg/Torque.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/shoulderexo/cmake" TYPE FILE FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo/catkin_generated/installspace/shoulderexo-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/include/shoulderexo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/share/roseus/ros/shoulderexo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/share/common-lisp/ros/shoulderexo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/share/gennodejs/ros/shoulderexo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/home/jackho/anaconda3/bin/python" -m compileall "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/python3/dist-packages/shoulderexo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/python3/dist-packages/shoulderexo")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo/catkin_generated/installspace/shoulderexo.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/shoulderexo/cmake" TYPE FILE FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo/catkin_generated/installspace/shoulderexo-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/shoulderexo/cmake" TYPE FILE FILES
    "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo/catkin_generated/installspace/shoulderexoConfig.cmake"
    "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo/catkin_generated/installspace/shoulderexoConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/shoulderexo" TYPE FILE FILES "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/package.xml")
endif()

