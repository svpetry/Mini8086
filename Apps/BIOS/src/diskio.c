/*-----------------------------------------------------------------------*/
/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2019        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

#include "ff.h"			/* Obtains integer types */
#include "diskio.h"		/* Declarations of disk functions */
#include "defs.h"
#include "sd.h"
#include "screen.h"
#include "strutils.h"

/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
	BYTE pdrv		/* Physical drive nmuber to identify the drive */
)
{
	if (sd_inserted()) {
		if (!sd_initialized())
			return STA_NOINIT;
		return 0;
	}
	return STA_NODISK;
}

/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
	BYTE pdrv				/* Physical drive nmuber to identify the drive */
)
{
	sd_led_rd(1);
	byte result = sd_init();
	sd_led_rd(0);
	if (result)
		return 0;
	return STA_NOINIT;
}

/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/

DRESULT disk_read (
	BYTE pdrv,			/* Physical drive nmuber to identify the drive */
	BYTE __far *buff,	/* Data buffer to store read data */
	LBA_t sector,		/* Start sector in LBA */
	UINT count			/* Number of sectors to read */
)
{
#if SD_DEBUG
	char s[16];
	putstr("disk_read\n");
	putstr("sector: ");
	ltoa(sector, s);
	putstr(s);
	putch('\n');
	putstr("count: ");
	itoa(count, s);
	putstr(s);
	putch('\n');
#endif

	int i, j;
	byte error = 0, res;

	sd_led_rd(1);
	sd_select();

	if (count == 1) {
		// read single block
		sd_command(17, sector, 00);
		if (read_r1() > 0x01)
			error = 1;
		else {
			if (sd_read_data_packet(buff) != 0xFE)
				error = 1;
		}
	} else {
		// read multiple blocks
		sd_command(18, sector, 00);
		if (read_r1() > 0x01)
			error = 1;
		else {
			for (i = 0; i < count; i++) {
				if (sd_read_data_packet(buff) != 0xFE) {
					error = 1;
					break;
				}
				buff += 512;
			}
			spi_send(0xFF);
			if (!error) {
				sd_command(12, 0, 0);
				spi_send(0xFF); // ignore stuff byte
				read_r1();
				while (spi_send(0xFF) == 0) ; // wait while busy
			}
		}
	}

	sd_deselect();
	sd_led_rd(0);

#if SD_DEBUG
	if (error) putstr("Error!\n");
#endif
	return error ? RES_ERROR : RES_OK;
}

/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/

#if FF_FS_READONLY == 0

DRESULT disk_write (
	BYTE pdrv,				/* Physical drive nmuber to identify the drive */
	const BYTE __far *buff,	/* Data to be written */
	LBA_t sector,			/* Start sector in LBA */
	UINT count				/* Number of sectors to write */
)
{
#if SD_DEBUG
	char s[16];
	putstr("disk_write\n");
	putstr("sector: ");
	ltoa(sector, s);
	putstr(s);
	putch('\n');
	putstr("count: ");
	itoa(count, s);
	putstr(s);
	putch('\n');
#endif

	sd_led_wr(1);
	sd_select();

	// TODO

	sd_deselect();
	sd_led_wr(0);
}

#endif

/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl (
	BYTE pdrv,		/* Physical drive nmuber (0..) */
	BYTE cmd,		/* Control code */
	void *buff		/* Buffer to send/receive control data */
)
{
#if SD_DEBUG
	char s[16];
	putstr("disk_ioctl\n");
	putstr("cmd: ");
	itoa(cmd, s);
	putstr(s);
	putch('\n');
#endif

		// Process of the command for the MMC/SD card
}

/*
	Currnet local time shall be returned as bit-fields packed into a DWORD value. The bit fields are as follows:

	bit31:25
	Year origin from the 1980 (0..127, e.g. 37 for 2017)
	bit24:21
	Month (1..12)
	bit20:16
	Day of the month (1..31)
	bit15:11
	Hour (0..23)
	bit10:5
	Minute (0..59)
	bit4:0
	Second / 2 (0..29, e.g. 25 for 50)
*/
DWORD get_fattime() {
	return 0;
}
