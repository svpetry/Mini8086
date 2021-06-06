#ifndef BMP280_H
#define BMP280_H

#include "types.h"

#define BMP280_S32_t    long
#define BMP280_U32_t    unsigned long

/* reads temperature and pressure from BMP280 */
void bmp280_read_sensors(long *temp, long *pressure);

/* initialize the BMP280 */
byte bmp280_init();

#endif
