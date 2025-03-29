#!/bin/bash

# Script to copy the appropriate .env file based on environment

# Default to development environment if not specified
ENV=${1:-dev}

# Source directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Project root directory (one level up from scripts directory)
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Path to the environment-specific .env file
ENV_FILE="$PROJECT_DIR/.env.$ENV"
# Path to the destination .env file
DEST_FILE="$PROJECT_DIR/.env"

echo "Setting up environment for: $ENV"

# Check if the environment-specific file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: Environment file $ENV_FILE does not exist!"
    exit 1
fi

# Copy the environment-specific file to .env
cp "$ENV_FILE" "$DEST_FILE"

echo "Successfully copied $ENV_FILE to $DEST_FILE"