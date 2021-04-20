#include "bootmenu.h"

void bootmenu() {

    asm("ljmpw $0xFFFF, $0x0000");
}
