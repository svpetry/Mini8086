#ifndef SD_H
#define SD_H

#include "../../Lib/types.h"

/* send and receive a byte via SPI (to the SD card) */
byte spi_send(byte value);

/* sends a command to the SD card */
void sd_command(byte cmd, dword arg, byte crc);

/* select SD card */
void sd_select();

/* deselect SD card */
void sd_deselect();

/* read R1 from SD card */
byte read_r1();

/* resets the SD drive. Called when a new SD card is inserted. */
byte sd_reset();

/* initializes the SD drive */
byte sd_init();

/* reads a data packet (use with CMD17 or CMD18) */
byte sd_read_data_packet(byte __far *buf);

/* returns true when the SD slot is currently containing an SD card */
byte sd_inserted();

/* returns true if the SD card has been initialized */
byte sd_initialized();

/* sets the read LED state */
void sd_led_rd(byte state);

/* sets the write LED state */
void sd_led_wr(byte state);

#endif
