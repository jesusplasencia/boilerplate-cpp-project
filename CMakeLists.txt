# Minimum required CMake version for this project
cmake_minimum_required(VERSION 3.10)

# Define the Project name and the languages used
project(LoggingProject LANGUAGES CXX)

# Set C++ standard to use (e.g. C++17)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # Optional: ensures strict standard compliance

# Specify compilers
set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)
set(CMAKE_GENERATOR ninja)

# Add an executable target.
add_executable(app src/main.cpp src/logger/logger.cpp src/math/math.cpp)

# If your header files were in a separate 'include' directory (common practice),
# you would add that directory to the include paths like this:
target_include_directories(app PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)

# Optional: Add compiler flags (e.g., warnings)
target_compile_options(app PRIVATE -Wall -Wextra -Wpedantic)
