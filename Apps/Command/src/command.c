#include "../../Lib/strutils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/kernel.h"

#define CMD_VER "0.1"

void init() {
    clrscr();
    
    putstr("Mini8086 command shell " CMD_VER "\n\n");
}

void start() {

}

int main() {
    init();
    start();
    while (1) ;
}