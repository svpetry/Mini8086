#include "types.h"

byte crc8x_simple(byte crc, const void __far *mem, word len);
byte crc8x_fast(byte crc, const void __far *mem, word len);
