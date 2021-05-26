#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_fs.h"

int main() {
    while (1) {
        putstr("Hello from command2!\n");
        for (int i = 0; i < 10000; i++)
            for (int j = 0; j < 10; j++)
                asm volatile ("nop");
    }
}