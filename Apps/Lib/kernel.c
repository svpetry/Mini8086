#include "kernel.h"
#include "bios_misc.h"

#define TICK_DURATION_MS 50

void __far *k_malloc(dword size) {

}

void k_free(void __far *ptr) {

}

void start_process(char *filename) {

}

void terminate_process(char *procname) {
    
}

void sleep(word milliseconds) {
    if (milliseconds < TICK_DURATION_MS) {
        asm volatile (
            "int $0x80\n" // wait for next time slice
        );
        return;
    }
    word wait_ticks = milliseconds / TICK_DURATION_MS;
    while (wait_ticks > 0) {
        byte ticks = get_ticks();
        do {
            asm volatile (
                "int $0x80\n" // wait for next time slice
            );
        } while (ticks == get_ticks());
        wait_ticks--;
    }
}
