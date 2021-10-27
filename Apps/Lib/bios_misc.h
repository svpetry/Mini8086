#include "types.h"

/* read a character from the keyboard buffer */
char getchar();

/* get current ticks */
byte get_ticks();

/* get date and time */
void get_date_time(byte *year, byte *month, byte *day, 
    byte *hours, byte *minutes, byte *seconds);

/* set time */
void set_time(byte hours, byte minutes, byte seconds);

/* set date */
void set_date(byte year, byte month, byte day);
