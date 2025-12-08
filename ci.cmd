@echo off
:: Windows (cmd.exe) CI script
:: - Creates and enters a build directory
:: - Configures the project with CMake
:: - Builds the project
:: - Runs tests with CTest
:: Note: Windows does not use chmod; execution permission step is only in ci.sh.

echo === CI: Starting (Windows) ===

:: Check for cmake
where cmake >nul 2>&1
if errorlevel 1 (
  echo Error: cmake not found in PATH. Please install CMake.
  exit /b 1
)

:: ctest may be available as part of CMake/CTest bundle; warn if missing
where ctest >nul 2>&1
if errorlevel 1 (
  echo Warning: ctest not found in PATH. Tests may not run.
)

:: Create build directory (mkdir ignores existing directory with 1>nul 2>nul on newer Windows)
if not exist build (
  mkdir build
) else (
  echo build directory already exists
)

:: Enter the build directory
cd /d build

:: Configure the project using CMake (parent directory)
echo Configuring project with CMake...
cmake ..
if errorlevel 1 (
  echo CMake configuration failed.
  exit /b %errorlevel%
)

:: Build the project using CMake
echo Building the project...
cmake --build .
if errorlevel 1 (
  echo Build failed.
  exit /b %errorlevel%
)

:: Run tests using CTest (if available)
where ctest >nul 2>&1
if errorlevel 0 (
  echo Running tests with CTest...
  ctest --output-on-failure
  if errorlevel 1 (
    echo Some tests failed.
    exit /b %errorlevel%
  )
) else (
  echo Skipping tests: ctest not available.
)

echo === CI: Finished ===
exit /b 0
