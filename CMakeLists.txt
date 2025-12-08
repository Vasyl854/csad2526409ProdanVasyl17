cmake_minimum_required(VERSION 3.16)

# Project name (use your repo or preferred name)
project(csad2526409ProdanVasyl17 VERSION 0.1.0 LANGUAGES CXX)

# Require a modern C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Add a simple executable target. Expects src/main.cpp to exist.
add_executable(${PROJECT_NAME} src/main.cpp)
