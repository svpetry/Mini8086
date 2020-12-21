#include "boot.h"
#include "screen.h"
#include "strutils.h"
#include "start.h"

void boot() {
    setcursor(4, 20);
    if (cfg_sddrive) {
        putstr("Booting...");

    } else
        putstr("No boot drive present. System halted.");
    
}