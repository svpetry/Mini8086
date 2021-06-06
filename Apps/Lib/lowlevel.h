#ifndef LOWLEVEL_H
#define LOWLEVEL_H

#include "types.h"

void outp(word port, byte value);
byte inp(word port);

void reboot();

#endif
