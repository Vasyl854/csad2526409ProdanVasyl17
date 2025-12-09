cmake_minimum_required(VERSION 3.24)

# Turn on the NEW behavior for CMP0135 (timestamp handling for FetchContent)
if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW)
endif()

project(csad2526409ProdanVasyl17 LANGUAGES C CXX)

# Example/typical settings — adjust to match your original CMake contents
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Source files (ensure these paths match files in your repo)
set(SOURCES
  main.cpp
  # add other sources here, e.g. src/foo.cpp
)

# If you prefer to fail fast with a clear message when a source file is missing,
# you can keep the check; otherwise remove this check if you will update SOURCES.
foreach(f ${SOURCES})
  if(NOT EXISTS "${CMAKE_SOURCE_DIR}/${f}")
    message(FATAL_ERROR "Missing source file referenced in CMakeLists.txt: ${f}")
  endif()
endforeach()

add_executable(${PROJECT_NAME} ${SOURCES})

# Any extra targets, link libraries, or install rules follow...
