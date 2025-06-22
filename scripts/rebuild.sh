#!/bin/bash

# --- Configuration ---
PROJECT_ROOT_DIR="$(dirname "$0")/.." # Assumes script is in project_root/scripts/ or similar
                                      # Adjust if your script is in a different location relative to project root
                                      # If script is in the project root: PROJECT_ROOT_DIR="$(pwd)"
BUILD_DIR="build"                     # Name of your build directory
EXECUTABLE_NAME="app"                 # Name of your executable target in CMakeLists.txt

# --- CMake Configuration ---
CMAKE_GENERATOR="Ninja"
CMAKE_C_COMPILER="gcc"
CMAKE_CXX_COMPILER="g++"

# --- Go to Project Root ---
# Get the absolute path to the project root
PROJECT_ROOT=$(realpath "$PROJECT_ROOT_DIR")
if [ ! -d "$PROJECT_ROOT" ]; then
    echo "Error: Project root directory '$PROJECT_ROOT' not found."
    exit 1
fi
echo "Navigating to project root: $PROJECT_ROOT"
cd "$PROJECT_ROOT" || { echo "Failed to change directory to '$PROJECT_ROOT'"; exit 1; }

# --- Clean Build Directory ---
if [ -d "$BUILD_DIR" ]; then
    echo "Cleaning existing build directory: $BUILD_DIR"
    rm -rf "$BUILD_DIR"
fi
mkdir -p "$BUILD_DIR" # -p creates parent directories if they don't exist
echo "Created new build directory: $BUILD_DIR"

# --- Configure Project with CMake ---
echo "Configuring project with CMake..."
# The -G, -D flags ensure explicit settings, overriding anything set in CMakeLists.txt or environment vars.
# This makes the script very reliable.
CMAKE_COMMAND="cmake -S . -B \"$BUILD_DIR\" -G \"$CMAKE_GENERATOR\" -DCMAKE_C_COMPILER=\"$CMAKE_C_COMPILER\" -DCMAKE_CXX_COMPILER=\"$CMAKE_CXX_COMPILER\" -DCMAKE_BUILD_TYPE=Debug"
echo "Running: $CMAKE_COMMAND"
eval "$CMAKE_COMMAND"

# Check if CMake configuration was successful
if [ $? -ne 0 ]; then
    echo "Error: CMake configuration failed."
    exit 1
fi
echo "CMake configuration successful."

# --- Build Project with Ninja ---
echo "Building project with Ninja..."
ninja -C "$BUILD_DIR" # -C flag tells ninja to operate in the specified directory

# Check if Ninja build was successful
if [ $? -ne 0 ]; then
    echo "Error: Build failed."
    exit 1
fi
echo "Build successful."

echo "Script finished."
