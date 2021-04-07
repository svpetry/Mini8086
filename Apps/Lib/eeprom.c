#include "eeprom.h"
#include "types.h"
#include "i2c.h"

#define EEPROM_ADDR 0x50

byte eeprom_write_buf(byte addr, const byte *buffer, byte count) {
    byte abort = i2c_start(EEPROM_ADDR, I2C_WRITE);
    if (!abort)
        abort = i2c_write(addr);
    
    while (count-- > 0 && !abort)
        abort = i2c_write(*(buffer++));
    
    i2c_stop();
    return abort;
}

byte eeprom_read_buf(byte addr, byte *buffer, byte count) {
    byte data;
    byte abort = i2c_start(EEPROM_ADDR, I2C_WRITE);
    if (!abort)
        abort = i2c_write(addr);
    if (!abort)
        abort = i2c_start(EEPROM_ADDR, I2C_READ);
    
    while (count-- > 0 && !abort)
        abort = i2c_read(buffer++, 1);
    if (!abort)
        abort = i2c_read(&data, 0);

    i2c_stop();
    return abort;
}
