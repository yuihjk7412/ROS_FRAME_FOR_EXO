# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build

# Include any dependencies generated for this target.
include shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/depend.make

# Include the progress variables for this target.
include shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/progress.make

# Include the compile flags for this target's objects.
include shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/flags.make

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/flags.make
shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorcontrol_shoulderexo.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o -c /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorcontrol_shoulderexo.cpp

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.i"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorcontrol_shoulderexo.cpp > CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.i

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.s"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorcontrol_shoulderexo.cpp -o CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.s

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.requires:

.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.requires

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.provides: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.requires
	$(MAKE) -f shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/build.make shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.provides.build
.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.provides

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.provides.build: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o


shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/flags.make
shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorclass.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o -c /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorclass.cpp

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.i"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorclass.cpp > CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.i

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.s"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/motorclass.cpp -o CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.s

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.requires:

.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.requires

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.provides: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.requires
	$(MAKE) -f shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/build.make shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.provides.build
.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.provides

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.provides.build: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o


shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/flags.make
shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/pidclass.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o -c /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/pidclass.cpp

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.i"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/pidclass.cpp > CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.i

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.s"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/src/pidclass.cpp -o CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.s

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.requires:

.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.requires

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.provides: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.requires
	$(MAKE) -f shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/build.make shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.provides.build
.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.provides

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.provides.build: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o


# Object files for target motorcontrol_shoulderexo
motorcontrol_shoulderexo_OBJECTS = \
"CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o" \
"CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o" \
"CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o"

# External object files for target motorcontrol_shoulderexo
motorcontrol_shoulderexo_EXTERNAL_OBJECTS =

/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/build.make
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/libroscpp.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_signals.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/librosconsole.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/librosconsole_log4cxx.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/librosconsole_backend_interface.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/liblog4cxx.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_regex.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/libxmlrpcpp.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/libroscpp_serialization.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/librostime.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /opt/ros/kinetic/lib/libcpp_common.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_system.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_thread.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libpthread.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /usr/lib/x86_64-linux-gnu/libconsole_bridge.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo/lib/libcontrolcan.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/motorcontrol_shoulderexo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/build: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/shoulderexo/motorcontrol_shoulderexo

.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/build

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/requires: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorcontrol_shoulderexo.cpp.o.requires
shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/requires: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/motorclass.cpp.o.requires
shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/requires: shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/src/pidclass.cpp.o.requires

.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/requires

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/clean:
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo && $(CMAKE_COMMAND) -P CMakeFiles/motorcontrol_shoulderexo.dir/cmake_clean.cmake
.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/clean

shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/depend:
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/shoulderexo /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : shoulderexo/CMakeFiles/motorcontrol_shoulderexo.dir/depend

