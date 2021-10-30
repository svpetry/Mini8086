#ifndef BIOS_SCREEN_H
#define BIOS_SCREEN_H

#include "types.h"

#define RED           0b11100000
#define GREEN         0b00011100
#define BLUE          0b00000011
#define YELLOW        0b11111100
#define MAGENTA       0b11100011
#define CYAN          0b00011111
#define LIGHT_YELLOW  0b11111101
#define LIGHT_MAGENTA 0b11101011
#define LIGHT_CYAN    0b01011111
#define LIGHT_RED     0b11101001
#define LIGHT_GREEN   0b01011101
#define LIGHT_BLUE    0b01001011
#define WHITE         0b11111111
#define BLACK         0b00000000
#define LIGHT_GRAY    0b10110110
#define DARK_GRAY     0b01001001

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
