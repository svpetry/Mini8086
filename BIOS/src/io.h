void init_screen();
void clrscr();
void scrolldown();
void setcursor(unsigned int col, unsigned int row);
void putch(char c);
void putstr(char *str);
void putstr_inv(char *str);
void lcd_init();
void lcd_putstr(int col, int row, char *str);