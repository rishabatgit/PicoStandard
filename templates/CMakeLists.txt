cmake_minimum_required(VERSION 3.13)

include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(PROJECT_NAME)

pico_sdk_init()

add_executable(PROJECT_NAME
    src/main.c
)

target_link_libraries(PROJECT_NAME
    pico_stdlib
    hardware_spi
)

pico_enable_stdio_usb(PROJECT_NAME 1)
pico_enable_stdio_uart(PROJECT_NAME 0)

pico_add_extra_outputs(PROJECT_NAME)
