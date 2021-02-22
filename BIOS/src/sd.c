#include "sd.h"
#include "types.h"
#include "lowlevel.h"
#include "defs.h"
#include "strutils.h"

byte spi_send(byte value) {
    outp(0x92, value);

    byte status;
    int i = 10000;
    while (--i > 0 && (inp(0x91) & 0x01) > 0) ;

    return inp(0x92);
}

void sd_command(byte cmd, dword arg, byte crc) {
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
    byte i, res;
    i = 8;    
    do {
        res = spi_send(0xFF);
    } while (i > 0 && res == 0xFF);

#if SD_DEBUG
    putstr("result: ");
    puthexbyte(res);
    putch('\n');
#endif

    return res;
}

void read_r3() {

}

void read_r7() {

}

bool init_cmd0() {
#if SD_DEBUG
    putstr("sending CMD0\n");
#endif
    sd_command(0, 0, 0x94);

    // wait for response
    res = read_res();
    if (res != 0x01)
        return FALSE; // error
}

bool init_cmd8() {
#if SD_DEBUG
    putstr("sending CMD8\n");
#endif
    sd_command(8, 0x0000001AA, 0x86);

    res = read_res();
    if (res != 0x01)
        return FALSE; // error

    for (i = 0; i < 4; i++) {
        res = spi_send(0xFF);
#if SD_DEBUG
        puthexbyte(res);
        if (i < 3)
            putch(' ');
        else
            putch('\n');
#endif
    }
}

bool init_cmd(byte cmd, dword arg, byte crc) {
#if SD_DEBUG
    putstr("sending CMD8\n");
#endif
    sd_command(8, 0x0000001AA, 0x86);

    res = read_res();
    if (res != 0x01)
        return FALSE; // error

    for (i = 0; i < 4; i++) {
        res = spi_send(0xFF);
#if SD_DEBUG
        puthexbyte(res);
        if (i < 3)
            putch(' ');
        else
            putch('\n');
#endif
    }
}

bool init_cmd58() {

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
    if (!init_cmd0()) return FALSE;

    // send CMD8
    if (!init_cmd8()) return FALSE;


}

bool sd_inserted() {
    return (inp(0x91) & 0b00000010) > 0;
}
