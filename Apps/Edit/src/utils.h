#ifndef UTILS_H
#define UTILS_H

#include "../../Lib/types.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/colors.h"

#define LINE_LEN 80

extern byte first_row;
extern byte rows_total;

void set_line(int row, char c);
void write_inverse(byte row, byte col, const char *s);
void put_line(const char *s, int row);
void put_line_far(const char __far *s, int row);
void quit_app();

#endif
