#include "sd.h"
#include "../../Lib/types.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/strutils.h"
#include "../../Lib/screen.h"
#include "defs.h"

#define SD_BLOCK_SIZE 512

volatile byte initialized;

/*
CMD17 0, crc=0x3b (Read one block)
CMD18 0, crc=0x57 (Read multiple blocks)
CMD24 0, crc=0x6f (set write address for single block)
CMD25 0, crc=0x03 (set write address for first block)
*/

byte spi_send(byte value) {
    outp(0x92, value);

    byte status;
    int i = 10000;
    while (--i > 0 && (inp(0x91) & 0x01) > 0) ;

    return inp(0x92);
}

void sd_command(byte cmd, dword arg, byte crc) {
#if SD_DEBUG
    char s[4];
    itoa(cmd, s);
    putstr("sending CMD");
    if (cmd < 10) putch('0');
    putstr(s);
    putch('\n');
#endif
    spi_send(cmd | 0x40);
    spi_send((byte)(arg >> 24));
    spi_send((byte)(arg >> 16));
    spi_send((byte)(arg >> 8));
    spi_send((byte)arg);
    spi_send(crc | 0x01);
}

byte sd_reset() {
    initialized = 0;
    byte cmd = 0b01001101;
    outp(0x90, cmd);
    return inp(0x90) == cmd;
}

void sd_select() {
    byte ctrl = inp(0x90);
    outp(0x90, ctrl & 0b11110111);
    spi_send(0xFF);
}

void sd_deselect() {
    byte ctrl = inp(0x90);
    outp(0x90, ctrl | 0b00001000);
    spi_send(0xFF);
}

byte read_r1() {
    byte i, j, res;

    i = 10;
    do {
        res = spi_send(0xFF);
    } while (--i > 0 && res == 0xFF);
#if SD_DEBUG
    putstr("result: ");
    puthexbyte(res);
    putch('\n');
#endif
    return res;
}

byte read_r3_r7() {
    byte i, res, res1;
    res = read_r1();
    if (res != 0x01) return res; // error

    for (i = 0; i < 4; i++) {
        res1 = spi_send(0xFF);
#if SD_DEBUG
        puthexbyte(res1);
        if (i < 3)
            putch(' ');
        else
            putch('\n');
#endif
    }
    return res;
}

static byte send_cmd0() {
    sd_command(0, 0, 0x94);
    return read_r1();
}

static byte send_cmd8() {
    sd_command(8, 0x0000001AA, 0x86);
    return read_r3_r7();
}

static byte send_cmd58() {
    sd_command(58, 0, 0xFD);
    return read_r3_r7();
}

static byte send_acmd41_new() {
    byte res;
    sd_command(55, 0, 0x65);
    res = read_r1();
    if (res != 0x01) return res;
    sd_command(41, 0x40000000, 0x77);
    return read_r1();
}

static byte send_acmd41_old() {
    byte res;
    sd_command(55, 0, 0x65);
    res = read_r1();
    if (res != 0x01) return res;
    sd_command(41, 0, 0xE5);
    return read_r1();
}

static byte send_cmd1() {
    sd_command(1, 0, 0xF9);
    return read_r1();
}

static void sd_delay() {
    int i;
    for (i = 0; i < 2000; i++)
        asm("nop");
}

static byte sd_init_internal() {
    byte i, res, cmd;
    byte r7[4];

    sd_deselect();
    for (i = 0; i < 10; i++)
        spi_send(0xFF);

    spi_send(0xFF);
    sd_select();
    spi_send(0xFF);

    // send CMD0
    if (send_cmd0() != 0x01) return 0;

    // send CMD8
    res = send_cmd8();
    if (res == 0x01) {
        // Ver 2.x or later

        do {
            // send ACMD41 until in_idle_state == 0
            res = send_acmd41_new();
            if (res == 0x01) sd_delay();
        } while (res == 0x01);
        if (res != 0x00) return 0;

        // send CMD58
        if (send_cmd58() > 0x01) return 0;

    } else if (res == 0x05) {
        // Version 1.x
        do {
            // send ACMD41 until in_idle_state == 0
            res = send_acmd41_old();
            if (res == 0x01) sd_delay();
        } while (res == 0x01);
        if (res == 0x05) {
            do {
                // send CMD1 until in_idle_state == 0
                res = send_cmd1();
                if (res == 0x01) sd_delay();
            } while (res == 0x01);
            if (res != 0x00) return 0;
        }
    } else return 0;

    // set block size to 512 bytes
    sd_command(16, 0x00000200, 0x81);
    read_r1();

    // increase transfer speed
    cmd = inp(0x90);
    cmd = cmd & 0b11111000;
    outp(0x90, cmd);

    sd_deselect();
    return 1;
}

byte sd_init() {
    byte i = 10, j;
    while (i > 0) {
        if (sd_init_internal())
            return initialized = 1;
        i--;
        for (j = 0; j < 10; j++)
            sd_delay();
    }
    return initialized = 0;
}

byte sd_read_data_packet(byte __far *buf) {
    int i, j;
    byte res, data;
#if SD_DEBUG
    char s[8];

    putstr("sd_read_data_packet...\n");
#endif

    i = 1000;
    res = spi_send(0xFF);
#if SD_DEBUG
    // puthexbyte(res);
    // putch('\n');
#endif 
    while (res == 0xFF && i > 0) {
        res = spi_send(0xFF);
    #if SD_DEBUG
        // puthexbyte(res);
        // putch('\n');
    #endif 
        i--;
    }

    if (res != 0xFE) {
#if SD_DEBUG
        putstr("ERROR!\n");
#endif 
        return res;
    }

    // read data
    j = 0;
    for (i = 0; i < SD_BLOCK_SIZE; i++) {
        data = spi_send(0xFF);
#if SD_DEBUG
        // puthexbyte(data);
        // if (j == 15) {
        //     j = 0;
        //     putch('\n');
        // } else {
        //     j++;
        //     putch(' ');
        // }	
#endif 
        *(buf++) = data;
    }

    // read crc (2 bytes)
    spi_send(0xFF);
    spi_send(0xFF);

#if SD_DEBUG
    putstr("\ndata packet received.\n");
#endif

    return res;
}

byte sd_inserted() {
    return (inp(0x91) & 0b00000010) > 0;
}

byte sd_initialized() {
    return initialized;
}

void sd_led_rd(byte state) {
    byte ctrl = inp(0x90);
    if (state)
        outp(0x90, ctrl | 0b00010000);
    else
        outp(0x90, ctrl & 0b11101111);
}

void sd_led_wr(byte state) {
    byte ctrl = inp(0x90);
    if (state)
        outp(0x90, ctrl | 0b00100000);
    else
        outp(0x90, ctrl & 0b11011111);
}
