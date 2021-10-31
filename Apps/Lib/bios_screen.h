#ifndef BIOS_SCREEN_H
#define BIOS_SCREEN_H

#include "types.h"

#define RED           0b00000111
#define GREEN         0b00111000
#define BLUE          0b11000000
#define YELLOW        0b00111111
#define MAGENTA       0b11000111
#define CYAN          0b11111000
#define LIGHT_RED     0b10101111
#define LIGHT_GREEN   0b10111101
#define LIGHT_BLUE    0b11101101
#define LIGHT_YELLOW  0b10111111
#define LIGHT_MAGENTA 0b11101111
#define LIGHT_CYAN    0b11111101
#define DARK_RED      0b00000010
#define DARK_GREEN    0b00010000
#define DARK_BLUE     0b01000000
#define DARK_YELLOW   0b00010010
#define DARK_MAGENTA  0b01000010
#define DARK_CYAN     0b01010000
#define WHITE         0b11111111
#define BLACK         0b00000000
#define LIGHT_GRAY    0b10101101
#define DARK_GRAY     0b01010010

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
void settext(byte col, byte row, const char *s, byte color);

/* Show or hide the cursor */
void enable_cursor(byte enable);

/* Set text color */
void set_textcolor(byte color);

/* Set background color */
void set_bgcolor(byte color);

#endif
