#include "../../Lib/bios_screen.h"
#include "../../Lib/strutils.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/bios_misc.h"
#include "malloc.h"
#include "scheduler.h"

#define HEAP_START ((void __far *)0x10000000)
#define HEAP_SIZE 0xC0000 - 0x10000

static void init() {
    malloc_reset(HEAP_START, HEAP_SIZE);
    
}

int main() {
    putstr("Hello.");
    init();
    start_scheduler();
    reboot();
}