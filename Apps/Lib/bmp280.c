#include "bmp280.h"
#include "types.h"
#include "i2c.h"

#define BMP280_ADDR     0x76
#define BMP280_ID       0xD0
#define BMP280_RESET    0xE0
#define BMP280_STATUS   0xF3
#define BMP280_CTRLM    0xF4
#define BMP280_CONFIG   0xF5
#define BMP280_PRESS    0xF7

static word dig_T1;
static int dig_T2;
static int dig_T3;
static word dig_P1;
static int dig_P2;
static int dig_P3;
static int dig_P4;
static int dig_P5;
static int dig_P6;
static int dig_P7;
static int dig_P8;
static int dig_P9;

/* Returns temperature in DegC, resolution is 0.01 DegC. Output value of “5123” equals 51.23 DegC. */
/* t_fine carries fine temperature as global value */
static BMP280_S32_t t_fine;
static BMP280_S32_t bmp280_compensate_T_int32(BMP280_S32_t adc_T) {
    BMP280_S32_t var1, var2, T;

    var1 = ((((adc_T >> 3) - ((BMP280_S32_t)dig_T1 << 1))) * ((BMP280_S32_t)dig_T2)) >> 11;
    var2 = (((((adc_T >> 4) - ((BMP280_S32_t)dig_T1)) 
        * ((adc_T >> 4) - ((BMP280_S32_t)dig_T1))) >> 12) * ((BMP280_S32_t)dig_T3)) >> 14;
    t_fine = var1 + var2;
    T = (t_fine * 5 + 128) >> 8;
    return T;
}

/* Returns pressure in Pa as unsigned 32 bit integer. Output value of “96386” equals 96386 Pa = 963.86 hPa */
static BMP280_U32_t bmp280_compensate_P_int32(BMP280_S32_t adc_P) {
    BMP280_S32_t var1, var2;
    BMP280_U32_t p;
    var1 = (((BMP280_S32_t)t_fine) >> 1) - (BMP280_S32_t)64000;
    var2 = (((var1 >> 2) * (var1 >> 2)) >> 11 ) * ((BMP280_S32_t)dig_P6);
    var2 = var2 + ((var1 * ((BMP280_S32_t)dig_P5)) << 1);
    var2 = (var2 >> 2) + (((BMP280_S32_t)dig_P4) << 16);
    var1 = (((dig_P3 * (((var1 >> 2) * (var1 >> 2)) >> 13 )) >> 3)
        + ((((BMP280_S32_t)dig_P2) * var1) >> 1)) >> 18;
    var1 = ((((32768 + var1)) * ((BMP280_S32_t)dig_P1)) >> 15);
    if (var1 == 0) {
        return 0; // avoid exception caused by division by zero
    }
    p = (((BMP280_U32_t)(((BMP280_S32_t)1048576) - adc_P) - (var2 >> 12))) * 3125;
    if (p < 0x80000000) {
        p = (p << 1) / ((BMP280_U32_t)var1);
    } else {
        p = (p / (BMP280_U32_t)var1) * 2;
    }
    var1 = (((BMP280_S32_t)dig_P9) * ((BMP280_S32_t)(((p >> 3) * (p >> 3)) >> 13))) >> 12;
    var2 = (((BMP280_S32_t)(p >> 2)) * ((BMP280_S32_t)dig_P8)) >> 13;
    p = (BMP280_U32_t)((BMP280_S32_t)p + ((var1 + var2 + dig_P7) >> 4));
    return p;
}

static byte bmp280_read(byte addr) {
    i2c_start(BMP280_ADDR, I2C_WRITE);
    i2c_write(addr);
    i2c_start(BMP280_ADDR, I2C_READ);
    byte data;
    i2c_read(&data, 0);
    i2c_stop();
    return data;
}

static void bmp280_write(byte addr, byte value) {
    i2c_start(BMP280_ADDR, I2C_WRITE);
    i2c_write(addr);
    i2c_write(value);
    i2c_stop();  
}

void bmp280_read_sensors(long *temp, long *pressure) {
    byte data[6];
    byte i;
    i2c_start(BMP280_ADDR, I2C_WRITE);
    i2c_write(BMP280_PRESS);
    i2c_start(BMP280_ADDR, I2C_READ);
    
    for (i = 0; i < 6; i++)
        i2c_read(data + i, i < 5);
    
    i2c_stop();
    
    dword adc_t = (((dword)data[3]) << 16) + (((dword)data[4]) << 8) + ((dword)data[5]);
    adc_t >>= 4;
    dword adc_p = (((dword)data[0]) << 16) + (((dword)data[1]) << 8) + ((dword)data[2]);
    adc_p >>= 4;

    *temp = bmp280_compensate_T_int32(adc_t);
    *pressure = bmp280_compensate_P_int32(adc_p);
}

byte bmp280_init() {
    // check device ID
    if (bmp280_read(BMP280_ID) != 0x58) return 1;

    // osrs_p=4, osrs_t=1, mode=normal(0b11)
    bmp280_write(BMP280_CTRLM, 0b00101111);

    // IIR=16, standby time 125ms=0b010
    bmp280_write(BMP280_CONFIG, 0b0101110);

    // read compensation parameters
    dig_T1 = (word)bmp280_read(0x88) | (((word)bmp280_read(0x89)) << 8);
    dig_T2 = (word)bmp280_read(0x8A) | (((word)bmp280_read(0x8B)) << 8);
    dig_T3 = (word)bmp280_read(0x8C) | (((word)bmp280_read(0x8D)) << 8);
    dig_P1 = (word)bmp280_read(0x8E) | (((word)bmp280_read(0x8F)) << 8);
    dig_P2 = (word)bmp280_read(0x90) | (((word)bmp280_read(0x91)) << 8);
    dig_P3 = (word)bmp280_read(0x92) | (((word)bmp280_read(0x93)) << 8);
    dig_P4 = (word)bmp280_read(0x94) | (((word)bmp280_read(0x95)) << 8);
    dig_P5 = (word)bmp280_read(0x96) | (((word)bmp280_read(0x97)) << 8);
    dig_P6 = (word)bmp280_read(0x98) | (((word)bmp280_read(0x99)) << 8);
    dig_P7 = (word)bmp280_read(0x9A) | (((word)bmp280_read(0x9B)) << 8);
    dig_P8 = (word)bmp280_read(0x9C) | (((word)bmp280_read(0x9D)) << 8);
    dig_P9 = (word)bmp280_read(0x9E) | (((word)bmp280_read(0x9F)) << 8);

    return 0;
}
