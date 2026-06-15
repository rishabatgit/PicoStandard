#!/bin/bash

set -e

if [ "$1" != "init" ] || [ -z "$2" ]; then
    echo "Usage: pico-init init <project_name>"
    exit 1
fi

PROJECT_NAME="$2"

DEV_DIR="$HOME/Dev"
TOOLS_DIR="$DEV_DIR/tools"
PICO_SDK_PATH="$TOOLS_DIR/pico-sdk"
TEMPLATE_DIR="$TOOLS_DIR/pico-standard/templates"

# Create ~/Dev if it doesn't exist
mkdir -p "$DEV_DIR"

# Install Pico SDK if missing
if [ ! -d "$PICO_SDK_PATH" ]; then
    echo "Pico SDK not found. Cloning..."

    mkdir -p "$TOOLS_DIR"

    git clone --recursive \
        https://github.com/raspberrypi/pico-sdk.git \
        "$PICO_SDK_PATH"

    echo "Pico SDK installed."
fi

# Check templates
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: Template directory not found:"
    echo "  $TEMPLATE_DIR"
    exit 1
fi

# Check project existence
if [ -e "$PROJECT_NAME" ]; then
    echo "Error: Project '$PROJECT_NAME' already exists."
    exit 1
fi

# Create project structure
mkdir -p "$PROJECT_NAME/src"
cd "$PROJECT_NAME"

cp "$TEMPLATE_DIR/main.c" src/

sed "s/PROJECT_NAME/$PROJECT_NAME/g" \
    "$TEMPLATE_DIR/CMakeLists.txt" > CMakeLists.txt

mkdir build
cd build

export PICO_SDK_PATH

cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1

cd ..

ln -sf build/compile_commands.json compile_commands.json

echo "Project '$PROJECT_NAME' created and configured."
