#include "types.h"
#include "lowlevel.h"

#define I2CF_330    0b000
#define I2CF_288    0b001
#define I2CF_217    0b010
#define I2CF_146    0b011
#define I2CF_88     0b100
#define I2CF_59     0b101
#define I2CF_44     0b110
#define I2CF_36     0b111

#define I2CSTA      0x70
#define I2CTO       0x70
#define I2CDAT      0x71
#define I2CADR      0x72
#define I2CCON      0x73

#define I2CCON_AA       0b10000000
#define I2CCON_ENSIO    0b01000000
#define I2CCON_STA      0b00100000
#define I2CCON_STO      0b00010000
#define I2CCON_SI       0b00001000

#define I2C_WRITE   0
#define I2C_READ    1

/* initialize I2C controller with a given bitrate */
byte i2c_init(byte bitrate);

/* send start condition or repeated start */
byte i2c_start(byte addr, byte rw);

/* send stop condition */
byte i2c_stop();

/* send a byte */
byte i2c_write(byte data);

/* receive a byte */
byte i2c_read(byte *data, byte ack);
