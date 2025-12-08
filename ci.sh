#!/usr/bin/env bash
# POSIX (Linux / macOS) CI script
# - Creates and enters a build directory
# - Configures the project with CMake
# - Builds the project
# - Runs tests with CTest
# - Adds execution permission to this script (as requested)
#
# Usage:
#   ./ci.sh
# or
#   bash ci.sh

set -euo pipefail
IFS=$'\n\t'

# Determine the directory of this script so we can chmod the script file reliably
# Works when the script is executed directly or via "bash ci.sh"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
script_path="$script_dir/ci.sh"

echo "=== CI: Starting (Linux/macOS) ==="

# Ensure required tools exist
if ! command -v cmake >/dev/null 2>&1; then
  echo "Error: cmake not found in PATH. Please install CMake." >&2
  exit 1
fi

if ! command -v ctest >/dev/null 2>&1; then
  echo "Warning: ctest not found in PATH. Tests may not run." >&2
fi

# Create the build directory if it doesn't exist
echo "Creating build directory..."
mkdir -p build

# Enter the build directory
echo "Entering build directory..."
cd build

# Configure the project using CMake
echo "Configuring project with CMake..."
# Use '..' to configure the parent directory (project root)
cmake ..

# Build the project using CMake
echo "Building the project..."
cmake --build .

# Run tests using CTest
# --output-on-failure shows failing tests' output for easier debugging
if command -v ctest >/dev/null 2>&1; then
  echo "Running tests with CTest..."
  ctest --output-on-failure
else
  echo "Skipping tests: ctest not available."
fi

# Add execution permissions to this script file (per request).
# We do this at the end so the script can be marked executable for future runs.
if [ -f "$script_path" ]; then
  echo "Adding execution permission to '$script_path'..."
  chmod +x "$script_path" || true
fi

echo "=== CI: Finished ==="
