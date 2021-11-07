#ifndef BIOS_SCREEN_H
#define BIOS_SCREEN_H

#include "types.h"

/* clear the screen */
void clrscr();

/* scroll the screen down by one line */
void scrolldown();

/* scroll the screen up by one line */
void scrollup();

/* set the cursor position */
void setcursor(byte col, byte row);

/* get the cursor position */
void getcursor(byte *col, byte *row);

/* output a single char at the cursor position */
int putchar(int c);

/* output a string */
int puts(const char *str);

/* print a text on the screen */
void settext(byte col, byte row, const char *s, byte color, byte inverse);

/* show or hide the cursor */
void enable_cursor(byte enable);

/* set text color */
void set_textcolor(byte color);

/* set background color */
void set_bgcolor(byte color);

/* sets the scrollable screen dimensions */
void settextdim(byte first_row, byte last_row);

#endif
