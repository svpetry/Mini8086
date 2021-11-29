#ifndef UTILS_H
#define UTILS_H

#include "../../Lib/types.h"

byte iswhite(char c);
byte isletter(char c);
byte isnum(char c);

void strcpy_near_to_far(char __far *dest, const char *src);

#endif
