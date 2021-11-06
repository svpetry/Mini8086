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
int putchar(int c);

/* outputs a string */
int puts(const char *str);

/* prints a text on the screen */
void settext(byte col, byte row, const char *s, byte color, byte inverse);

/* Show or hide the cursor */
void enable_cursor(byte enable);

/* Set text color */
void set_textcolor(byte color);

/* Set background color */
void set_bgcolor(byte color);

#endif
