cmake_minimum_required(VERSION 3.4.3)

#===============================================================================
# 1. LOAD LLVM CONFIGURATION
#===============================================================================
# Set this to a valid LLVM installation dir
set(LT_LLVM_INSTALL_DIR "" CACHE PATH "LLVM installation directory")

# Add the location of LLVMConfig.cmake to CMake search paths (so that
# find_package can locate it)
list(APPEND CMAKE_PREFIX_PATH "${LT_LLVM_INSTALL_DIR}/lib/cmake/llvm/")

find_package(LLVM 10.0.0 REQUIRED CONFIG)

# nested-loop-counter includes headers from LLVM - update the include paths accordingly
include_directories(${LLVM_INCLUDE_DIRS})

#===============================================================================
# 2. LLVM-TUTOR BUILD CONFIGURATION
#===============================================================================
# Use the same C++ standard as LLVM does
set(CMAKE_CXX_STANDARD 14 CACHE STRING "")

# LLVM is normally built without RTTI. Be consistent with that.
if(NOT LLVM_ENABLE_RTTI)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

# The following flag is used to enable the registration of nested-loop-counter with the
# optimisation pipelines.
OPTION(NESTEDLOOPCOUNTER_OPT_PIPELINE_REG "Register nested-loop-counter with the optimisation pipelines" OFF)
if(NESTEDLOOPCOUNTER_OPT_PIPELINE_REG)
  add_definitions(-DNESTEDLOOPCOUNTER_OPT_PIPELINE_REG)
endif()

#===============================================================================
# 3. ADD THE TARGET
#===============================================================================
add_library(nested-loop-counter SHARED nested-loop-counter.cpp)

# Allow undefined symbols in shared objects on Darwin (this is the default
# behaviour on Linux)
target_link_libraries(nested-loop-counter
  "$<$<PLATFORM_ID:Darwin>:-undefined dynamic_lookup>")
