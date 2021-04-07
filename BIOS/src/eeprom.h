#include "types.h"

/* write to eeprom */
byte eeprom_write_buf(byte addr, const byte *buffer, byte count);

/* read from eeprom */
byte eeprom_read_buf(byte addr, byte *buffer, byte count);
