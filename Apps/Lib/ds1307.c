#include "ds1307.h"
#include "../Lib/types.h"
#include "../Lib/i2c.h"

#define DS1307_ADDR     0x68
#define DS1307_TIME     0x00
#define DS1307_DATE     0x04
#define DS1307_WEEKDAY  0x03
#define DS1307_CTRL     0x07

byte ds1307_init() {
    if (i2c_start(DS1307_ADDR, I2C_WRITE)) return 1;
    i2c_write(DS1307_CTRL);
    i2c_write(0x00);
    i2c_stop();
    return 0;
}

void ds1307_settime(byte hours, byte minutes, byte seconds) {
    i2c_start(DS1307_ADDR, I2C_WRITE);
    i2c_write(DS1307_TIME);
    i2c_write(((seconds / 10) << 4 ) | (seconds % 10));
    i2c_write(((minutes / 10) << 4 ) | (minutes % 10));
    i2c_write(((hours / 10) << 4 ) | (hours % 10));
    i2c_stop();
}

void ds1307_gettime(byte *hours, byte *minutes, byte *seconds) {
    byte value;
    i2c_start(DS1307_ADDR, I2C_WRITE);
    i2c_write(DS1307_TIME);
    i2c_start(DS1307_ADDR, I2C_READ);

    i2c_read(&value, 1);
    *seconds = (value >> 4) * 10 + (value & 0x0F);
    i2c_read(&value, 1);
    *minutes = (value >> 4) * 10 + (value & 0x0F);
    i2c_read(&value, 0);
    *hours = (value >> 4) * 10 + (value & 0x0F);

    i2c_stop();
}

void ds1307_setdate(byte day, byte month, byte year) {
    i2c_start(DS1307_ADDR, I2C_WRITE);
    i2c_write(DS1307_DATE);
    i2c_write(((day / 10) << 4 ) | (day % 10));
    i2c_write(((month / 10) << 4 ) | (month % 10));
    i2c_write(((year / 10) << 4 ) | (year % 10));
    i2c_stop();
}

void ds1307_getdate(byte *day, byte *month, byte *year) {
    byte value;
    i2c_start(DS1307_ADDR, I2C_WRITE);
    i2c_write(DS1307_DATE);
    i2c_start(DS1307_ADDR, I2C_READ);

    i2c_read(&value, 1);
    *day = (value >> 4) * 10 + (value & 0x0F);
    i2c_read(&value, 1);
    *month = (value >> 4) * 10 + (value & 0x0F);
    i2c_read(&value, 0);
    *year = (value >> 4) * 10 + (value & 0x0F);

    i2c_stop();
}
