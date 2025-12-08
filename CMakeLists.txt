
cmake_minimum_required(VERSION 3.14)
project(math_project VERSION 0.1 LANGUAGES CXX)

# Use a reasonable C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Create library target for the math operations
add_library(math_operations STATIC
    math_operations.cpp
)

# Expose the project root as an include directory so headers in the root can be found
target_include_directories(math_operations
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
)

# Enable testing
enable_testing()

# Fetch GoogleTest and make it available as imported targets (GTest::gtest GTest::gtest_main)
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
)
# For reproducible builds, prevent googletest from overriding user flags
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Test executable
add_executable(unit_tests
    tests/unit_tests.cpp
)

target_link_libraries(unit_tests
    PRIVATE
        math_operations
        GTest::gtest_main
)

target_include_directories(unit_tests
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
)

# Use GoogleTest's helper to discover and register tests with CTest
include(GoogleTest)
gtest_discover_tests(unit_tests)

cmake_minimum_required(VERSION 3.16)

# Project name (use your repo or preferred name)
project(csad2526409ProdanVasyl17 VERSION 0.1.0 LANGUAGES CXX)

# Require a modern C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Add a simple executable target. Expects src/main.cpp to exist.
add_executable(${PROJECT_NAME} src/main.cpp)

