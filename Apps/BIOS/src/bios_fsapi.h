#ifndef BIOS_FSAPI_H
#define BIOS_FSAPI_H

#include "../../Lib/types.h"

void initialize_filesys();

void fsapi_unmount();

void handle_filesys(byte code);

#endif