# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "exosystem: 5 messages, 0 services")

set(MSG_I_FLAGS "-Iexosystem:/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(exosystem_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg" NAME_WE)
add_custom_target(_exosystem_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exosystem" "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg" ""
)

get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg" NAME_WE)
add_custom_target(_exosystem_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exosystem" "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg" ""
)

get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg" NAME_WE)
add_custom_target(_exosystem_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exosystem" "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg" ""
)

get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg" NAME_WE)
add_custom_target(_exosystem_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exosystem" "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg" ""
)

get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg" NAME_WE)
add_custom_target(_exosystem_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "exosystem" "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem
)
_generate_msg_cpp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem
)
_generate_msg_cpp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem
)
_generate_msg_cpp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem
)
_generate_msg_cpp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem
)

### Generating Services

### Generating Module File
_generate_module_cpp(exosystem
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(exosystem_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(exosystem_generate_messages exosystem_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_cpp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_cpp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_cpp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_cpp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_cpp _exosystem_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exosystem_gencpp)
add_dependencies(exosystem_gencpp exosystem_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exosystem_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem
)
_generate_msg_eus(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem
)
_generate_msg_eus(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem
)
_generate_msg_eus(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem
)
_generate_msg_eus(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem
)

### Generating Services

### Generating Module File
_generate_module_eus(exosystem
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(exosystem_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(exosystem_generate_messages exosystem_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_eus _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_eus _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_eus _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_eus _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_eus _exosystem_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exosystem_geneus)
add_dependencies(exosystem_geneus exosystem_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exosystem_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem
)
_generate_msg_lisp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem
)
_generate_msg_lisp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem
)
_generate_msg_lisp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem
)
_generate_msg_lisp(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem
)

### Generating Services

### Generating Module File
_generate_module_lisp(exosystem
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(exosystem_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(exosystem_generate_messages exosystem_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_lisp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_lisp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_lisp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_lisp _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_lisp _exosystem_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exosystem_genlisp)
add_dependencies(exosystem_genlisp exosystem_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exosystem_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem
)
_generate_msg_nodejs(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem
)
_generate_msg_nodejs(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem
)
_generate_msg_nodejs(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem
)
_generate_msg_nodejs(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem
)

### Generating Services

### Generating Module File
_generate_module_nodejs(exosystem
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(exosystem_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(exosystem_generate_messages exosystem_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_nodejs _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_nodejs _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_nodejs _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_nodejs _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_nodejs _exosystem_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exosystem_gennodejs)
add_dependencies(exosystem_gennodejs exosystem_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exosystem_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem
)
_generate_msg_py(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem
)
_generate_msg_py(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem
)
_generate_msg_py(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem
)
_generate_msg_py(exosystem
  "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem
)

### Generating Services

### Generating Module File
_generate_module_py(exosystem
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(exosystem_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(exosystem_generate_messages exosystem_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Limbpos.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_py _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Sysstatus.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_py _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Motor_Force.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_py _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Torque.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_py _exosystem_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/msg/Encoder.msg" NAME_WE)
add_dependencies(exosystem_generate_messages_py _exosystem_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(exosystem_genpy)
add_dependencies(exosystem_genpy exosystem_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS exosystem_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/exosystem
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(exosystem_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/exosystem
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(exosystem_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/exosystem
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(exosystem_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/exosystem
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(exosystem_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem)
  install(CODE "execute_process(COMMAND \"/home/jackho/anaconda3/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/exosystem
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(exosystem_generate_messages_py std_msgs_generate_messages_py)
endif()
