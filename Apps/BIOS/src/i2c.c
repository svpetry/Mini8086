#include "i2c.h"
#include "types.h"
#include "screen.h"

static byte i2c_br;

static void i2c_delay_long() {
    word i;
    for (i = 0; i < 20000; i++)
        asm("nop");
}

static byte wait_for_status(byte status) {
    int tries = 5000;
    while (tries-- > 0) {
        if (inp(I2CSTA) == status) {
            return 0;
        }
    }
    return 1;
}

static byte wait_for_status2(byte status1, byte status2) {
    int tries = 5000;
    byte status;
    while (tries-- > 0) {
        status = inp(I2CSTA);
        if (status == status1 || status == status2)
            return 0;
    }
    return 1;
}

static byte i2c_wait_for_si() {
    int tries = 1000;
    byte data;
    while (tries-- > 0) {
        if ((inp(I2CCON) & I2CCON_SI) > 0) return 0;
    }
    return 1;
}

byte i2c_init(byte bitrate) {
    i2c_br = bitrate & 0b00000111;
    outp(I2CTO, 0xFF);
    outp(I2CADR, 0x00);
    byte conval = i2c_br | I2CCON_ENSIO;
    outp(I2CCON, conval);

    i2c_delay_long();

    if (inp(I2CCON) == conval && inp(I2CSTA) == 0xF8) return 0;
    return 1;
}

byte i2c_start(byte addr, byte rw) {
    // generate start command
    outp(I2CCON, i2c_br | I2CCON_AA | I2CCON_ENSIO | I2CCON_STA);
    if (i2c_wait_for_si()) return 1;

    // check status
    if (wait_for_status2(0x08, 0x10)) return 1;

    // load slave address + r/w bit into I2CDAT
    outp(I2CDAT, (addr << 1) + rw);

    // reset SI and STA bits
    outp(I2CCON, i2c_br | I2CCON_AA | I2CCON_ENSIO);
    if (i2c_wait_for_si()) return 1;

    // check status
    if (rw == I2C_WRITE) {
        if (wait_for_status(0x18)) return 1;
    } else {
        if (wait_for_status(0x40)) return 1;
    }

    return 0;
}

byte i2c_write(byte data) {
    outp(I2CDAT, data);

    // reset SI bit
    outp(I2CCON, i2c_br | I2CCON_AA | I2CCON_ENSIO);
    if (i2c_wait_for_si()) return 1;
    
    // check status
    if (wait_for_status(0x28)) return 1;

    return 0;
}

byte i2c_read(byte *data, byte ack) {
    // reset SI bit
    if (ack)
        outp(I2CCON, i2c_br | I2CCON_AA | I2CCON_ENSIO);
    else
        outp(I2CCON, i2c_br | I2CCON_ENSIO);
    if (i2c_wait_for_si()) return 1;

    // check status
    if (ack) {
        if (wait_for_status(0x50)) return 1;
    } else {
        if (wait_for_status(0x58)) return 1;
    }

    // read data
    *data = inp(I2CDAT);

    return 0;
}

byte i2c_stop() {
    // generate stop command
    outp(I2CCON, i2c_br | I2CCON_AA | I2CCON_ENSIO | I2CCON_STO);

    // check status
    if (wait_for_status(0xF8)) return 1;

    return 0;
}

