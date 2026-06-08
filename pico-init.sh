#!/bin/bash

if [ "$1" != "init" ] || [ -z "$2" ]; then
  echo "Usage: pico-init init <project_name>"
  exit 1
fi

PROJECT_NAME=$2
TEMPLATE_DIR=~/dev/tools/pico-standard/templates

mkdir -p "$PROJECT_NAME/src"
cd "$PROJECT_NAME"

cp "$TEMPLATE_DIR/main.c" src/

sed "s/PROJECT_NAME/$PROJECT_NAME/g" \
  "$TEMPLATE_DIR/CMakeLists.txt" >CMakeLists.txt

mkdir build
cd build

export PICO_SDK_PATH=~/dev/tools/pico-sdk

cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1

echo "Project '$PROJECT_NAME' created and configured."
