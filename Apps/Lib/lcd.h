#ifndef LCD_H
#define LCD_H

/* initializes the LCD */
void lcd_init();

/* clears the LCD */
void lcd_clear();

/* outputs a string on the LCD */
void lcd_putstr(int col, int row, const char *str);

#endif
