#ifndef BIOS_TIME_H
#define BIOS_TIME_H

#include "types.h"

/* get current ticks */
byte get_ticks();

/* get date and time */
void get_date_time(byte *year, byte *month, byte *day, 
    byte *hours, byte *minutes, byte *seconds);

/* get time */
void get_time(byte *hours, byte *minutes, byte *seconds);

/* set time */
void set_time(byte hours, byte minutes, byte seconds);

/* set date */
void set_date(byte year, byte month, byte day);

#endif