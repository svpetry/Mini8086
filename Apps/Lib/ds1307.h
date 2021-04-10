#include "../Lib/types.h"

/* DS1307 initialization */
byte ds1307_init();

/* sets the time */
void ds1307_settime(byte hours, byte minutes, byte seconds);

/* gets the time */
void ds1307_gettime(byte *hours, byte *minutes, byte *seconds);

/* sets the date */
void ds1307_setdate(byte day, byte month, byte year);

/* gets the date */
void ds1307_getdate(byte *day, byte *month, byte *year);
