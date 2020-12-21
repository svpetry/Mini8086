#include "types.h"

void set_textcol(byte col);
void init_screen();
void clrscr();
void scrolldown();
void scrollup();
void setcursor(word col, word row);
void putch(char c);
void setchar(word col, word row, char c);
void putstr(char *str);
void putstr_inv(char *str);
