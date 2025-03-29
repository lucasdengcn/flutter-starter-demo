#!/bin/bash

# Script to build the Flutter application with the correct environment

# Default to development environment if not specified
ENV=${1:-dev}
# Default build type based on environment
if [ "$ENV" == "production" ] || [ "$ENV" == "staging" ]; then
  BUILD_TYPE="--release"
else
  BUILD_TYPE="--debug"
fi

# Source directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Setup the environment
"$SCRIPT_DIR/setup_env.sh" "$ENV"

# Check if setup was successful
if [ $? -ne 0 ]; then
  echo "Failed to setup environment. Aborting build."
  exit 1
fi

# Build the application
echo "Building application for $ENV environment with $BUILD_TYPE..."

# Determine the platform and build accordingly
PLATFORM=${2:-all}

case "$PLATFORM" in
  android)
    flutter build apk $BUILD_TYPE
    ;;
  ios)
    flutter build ios $BUILD_TYPE --no-codesign
    ;;
  web)
    flutter build web $BUILD_TYPE
    ;;
  all)
    echo "Building for Android..."
    flutter build apk $BUILD_TYPE
    
    echo "Building for iOS..."
    flutter build ios $BUILD_TYPE --no-codesign
    
    echo "Building for Web..."
    flutter build web $BUILD_TYPE
    ;;
  *)
    echo "Unknown platform: $PLATFORM. Valid options are: android, ios, web, all"
    exit 1
    ;;
esac

echo "Build completed successfully!"