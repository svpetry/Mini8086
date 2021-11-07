#ifndef BIOS_SCREEN_FAR_H
#define BIOS_SCREEN_FAR_H

#include "types.h"

/* output a string */
int puts_far(const char __far *str);

/* print a text on the screen */
void settext_far(byte col, byte row, const char __far *s, byte color, byte inverse);

#endif
