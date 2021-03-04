#include "sd.h"
#include "types.h"
#include "lowlevel.h"
#include "defs.h"
#include "strutils.h"
#include "screen.h"

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

bool sd_reset() {
    byte cmd = 0b00001111;
    outp(0x90, cmd);
    return inp(0x90) == cmd;
}

void sd_select() {
    byte ctrl = inp(0x90);
    outp(0x90, ctrl & 0b11110111);
}

void sd_deselect() {
    byte ctrl = inp(0x90);
    outp(0x90, ctrl | 0b00001000);
}

byte read_r1() {
    byte i, j, res;

    j = 20;
    do {    
        i = 8;    
        do {
            res = spi_send(0xFF);
        } while (--i > 0 && res == 0xFF);
    } while (--j > 0 && (res & 0x01) == 0);
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

byte send_cmd0() {
    sd_command(0, 0, 0x94);
    return read_r1();
}

byte send_cmd8() {
    sd_command(8, 0x0000001AA, 0x86);
    return read_r3_r7();
}

byte send_cmd58() {
    sd_command(58, 0, 0);
    return read_r3_r7();
}

byte send_acmd41_new() {
    byte res;
    sd_command(55, 0, 0);
    res = read_r1();
    if (res != 0x01) return res;
    sd_command(41, 0x40000000, 0);
    return read_r1();
}

byte send_acmd41_old() {
    byte res;
    sd_command(55, 0, 0);
    res = read_r1();
    if (res != 0x01) return res;
    sd_command(41, 0, 0xE5);
    return read_r1();
}

byte send_cmd1() {
    sd_command(1, 0, 0xF9);
    return read_r1();
}

void sd_delay() {
    int i;
    for (i = 0; i < 10000; i++)
        asm("nop");
}

bool sd_init() {
    byte i, res;
    byte r7[4];

    sd_deselect();
    for (i = 0; i < 10; i++)
        spi_send(0xFF);

    spi_send(0xFF);
    sd_select();
    spi_send(0xFF);

    // send CMD0
    if (send_cmd0() != 0x01) return FALSE;

    // send CMD8
    res = send_cmd8();
    if (res == 0x01) {
        // Ver 2.x or later

        do {
            // send ACMD41 until in_idle_state == 0
            res = send_acmd41_new();
            if (res == 0x01) sd_delay();
        } while (res == 0x01);
        if (res != 0x00) return FALSE;

        // send CMD58
        if (!send_cmd58()) return FALSE;

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
            if (res != 0x00) return FALSE;
        }
    } else return FALSE;
    return TRUE;
}

bool sd_inserted() {
    return (inp(0x91) & 0b00000010) > 0;
}
