#ifndef BIOS_SCREEN_H
#define BIOS_SCREEN_H

#include "types.h"

/* clears the screen */
void clrscr();

/* scrolls the screen down by one line */
void scrolldown();

/* scrolls the screen up by one line */
void scrollup();

/* sets the cursor position */
void setcursor(byte col, byte row);

/* outputs a single char at the cursor position */
void putch(char c);

/* outputs a string */
void putstr(const char *str);

/* prints a text on the screen */
void settext(byte col, byte row, const char *s, byte color);

#endif
