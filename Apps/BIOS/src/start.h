#ifndef START_H
#define START_H

#include "../../Lib/types.h"

void startup();

/* SD drive available */
extern byte cfg_sddrive;

/* UART available */
extern byte cfg_rs232;

/* I2C controller available */
extern byte cfg_i2c;

/* EEPROM available */
extern byte cfg_eeprom;

/* BMP280 pressure & temperature sensor available */
extern byte cfg_bmp280;

/* DS1307 RTC available */
extern byte cfg_rtc;

/* amount of RAM in KBytes */
extern int ram_kb;

#endif
