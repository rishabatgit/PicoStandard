#include "pico/stdlib.h"
#include <stdio.h>

int main() {
    stdio_init_all();

    while (!stdio_usb_connected()) {
        sleep_ms(100);
    }

    printf("BOOT OK\n");

    while (1) {
        printf("Running...\n");
        sleep_ms(1000);
    }
}
