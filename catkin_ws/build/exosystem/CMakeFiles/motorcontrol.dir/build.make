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
include exosystem/CMakeFiles/motorcontrol.dir/depend.make

# Include the progress variables for this target.
include exosystem/CMakeFiles/motorcontrol.dir/progress.make

# Include the compile flags for this target's objects.
include exosystem/CMakeFiles/motorcontrol.dir/flags.make

exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o: exosystem/CMakeFiles/motorcontrol.dir/flags.make
exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorcontrol.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o -c /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorcontrol.cpp

exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.i"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorcontrol.cpp > CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.i

exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.s"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorcontrol.cpp -o CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.s

exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.requires:

.PHONY : exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.requires

exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.provides: exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.requires
	$(MAKE) -f exosystem/CMakeFiles/motorcontrol.dir/build.make exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.provides.build
.PHONY : exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.provides

exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.provides.build: exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o


exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o: exosystem/CMakeFiles/motorcontrol.dir/flags.make
exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorclass.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o -c /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorclass.cpp

exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/motorcontrol.dir/src/motorclass.cpp.i"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorclass.cpp > CMakeFiles/motorcontrol.dir/src/motorclass.cpp.i

exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/motorcontrol.dir/src/motorclass.cpp.s"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/motorclass.cpp -o CMakeFiles/motorcontrol.dir/src/motorclass.cpp.s

exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.requires:

.PHONY : exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.requires

exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.provides: exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.requires
	$(MAKE) -f exosystem/CMakeFiles/motorcontrol.dir/build.make exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.provides.build
.PHONY : exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.provides

exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.provides.build: exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o


exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o: exosystem/CMakeFiles/motorcontrol.dir/flags.make
exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/pidclass.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o -c /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/pidclass.cpp

exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/motorcontrol.dir/src/pidclass.cpp.i"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/pidclass.cpp > CMakeFiles/motorcontrol.dir/src/pidclass.cpp.i

exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/motorcontrol.dir/src/pidclass.cpp.s"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/src/pidclass.cpp -o CMakeFiles/motorcontrol.dir/src/pidclass.cpp.s

exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.requires:

.PHONY : exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.requires

exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.provides: exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.requires
	$(MAKE) -f exosystem/CMakeFiles/motorcontrol.dir/build.make exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.provides.build
.PHONY : exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.provides

exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.provides.build: exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o


# Object files for target motorcontrol
motorcontrol_OBJECTS = \
"CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o" \
"CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o" \
"CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o"

# External object files for target motorcontrol
motorcontrol_EXTERNAL_OBJECTS =

/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: exosystem/CMakeFiles/motorcontrol.dir/build.make
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/libroscpp.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_signals.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/librosconsole.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/librosconsole_log4cxx.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/librosconsole_backend_interface.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/liblog4cxx.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_regex.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/libxmlrpcpp.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/libroscpp_serialization.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/librostime.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /opt/ros/kinetic/lib/libcpp_common.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_system.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_thread.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libpthread.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /usr/lib/x86_64-linux-gnu/libconsole_bridge.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem/lib/libcontrolcan.so
/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol: exosystem/CMakeFiles/motorcontrol.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol"
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/motorcontrol.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
exosystem/CMakeFiles/motorcontrol.dir/build: /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/devel/lib/exosystem/motorcontrol

.PHONY : exosystem/CMakeFiles/motorcontrol.dir/build

exosystem/CMakeFiles/motorcontrol.dir/requires: exosystem/CMakeFiles/motorcontrol.dir/src/motorcontrol.cpp.o.requires
exosystem/CMakeFiles/motorcontrol.dir/requires: exosystem/CMakeFiles/motorcontrol.dir/src/motorclass.cpp.o.requires
exosystem/CMakeFiles/motorcontrol.dir/requires: exosystem/CMakeFiles/motorcontrol.dir/src/pidclass.cpp.o.requires

.PHONY : exosystem/CMakeFiles/motorcontrol.dir/requires

exosystem/CMakeFiles/motorcontrol.dir/clean:
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem && $(CMAKE_COMMAND) -P CMakeFiles/motorcontrol.dir/cmake_clean.cmake
.PHONY : exosystem/CMakeFiles/motorcontrol.dir/clean

exosystem/CMakeFiles/motorcontrol.dir/depend:
	cd /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/src/exosystem /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem /home/jackho/ROS_FRAME_FOR_EXO/catkin_ws/build/exosystem/CMakeFiles/motorcontrol.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : exosystem/CMakeFiles/motorcontrol.dir/depend

