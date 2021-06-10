#ifndef SCREEN_H
#define SCREEN_H

#include "types.h"

/* should be called by a timer and not manually */
void cursor_blink();

/* show or hide the cursor */
void enable_cursor(byte enable);

/* sets the active text color */
void set_textcol(byte color);

/* initializes the screen in textmode with default colors */
void init_screen();

/* clears the screen */
void clrscr();

/* clears a row on the screen */
void clrrow(byte row);

/* scrolls the screen down by one line */
void scrolldown();

/* scrolls the screen up by one line */
void scrollup();

/* sets the cursor position */
void setcursor(byte col, byte row);

/* outputs a single char at the cursor position */
int putchar(int c);

/* sets a char at a given position */
void setchar(byte col, byte row, char c);

/* prints a text on the screen */
void settext(byte col, byte row, const char *s, byte color);

/* prints a text on the screen (far pointer) */
void settext_far(byte col, byte row, const char __far *s, byte color);

/* gets a char at a given position */
char getscreenchar(byte col, byte row);

/* outputs a string */
int puts(const char *str);

/* outputs a string with inverse characters */
int puts_inv(const char *str);

/* outputs a string (far pointer) */
int puts_far(const char __far *str);

/* outputs a byte as 2-digit hex number */
void puthexbyte(byte value);

#endif
