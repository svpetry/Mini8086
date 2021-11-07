#include "bios_api.h"
#include "../../Lib/types.h"
#include "../../Lib/screen.h"
#include "../../Lib/ds1307.h"
#include "../../Lib/lowlevel.h"
#include "keyboard.h"
#include "bios_fsapi.h"
#include "bios.h"
#include "start.h"

volatile word int_sp_save;
volatile word int_ss_save;

volatile word int_ax;
volatile word int_cx;
volatile word int_dx;
volatile word int_si;
volatile word int_di;


void int_bios() {
    byte code = int_ax >> 8;

    if (code >= 0x20) {
        handle_filesys(code);
        return;
    }

    switch (code) {

        // clear screen
        case 0x00: {
            clrscr();
            break;
        }

        // get/set cursor position
        case 0x01: {
            if ((int_ax & 0xFF) > 0)
                setcursor(int_dx, int_dx >> 8);
            else
                int_dx = ((word)cursor_row << 8) + cursor_col;
            break;
        }

        // scroll down
        case 0x02: {
            byte count = int_ax & 0x00FF;
            while (count-- > 0)
                scrolldown();
            break;
        }

        // scroll up
        case 0x03: {
            byte count = int_ax & 0x00FF;
            while (count-- > 0)
                scrollup();
            break;
        }

        // write character at cursor position
        case 0x04: {
            putchar(int_ax & 0xFF);
            break;
        }

        // read character from cursor position
        case 0x05: {
            break;    
        }

        // write string at cursor position
        case 0x06: {
            dword addr = (((dword)int_dx) << 16) + int_cx;
            puts_far((char __far *)addr);
            break;
        }

        // output a text on the screen
        case 0x07: {
            dword addr = (((dword)int_si) << 16) + int_di;
            if (int_cx >> 8)
                settext_far_inv(int_dx, int_dx >> 8, (char __far *)addr, int_cx & 0xFF);
            else
                settext_far(int_dx, int_dx >> 8, (char __far *)addr, int_cx & 0xFF);
            break;
        }

        // show or hide the cursor
        case 0x08: {
            enable_cursor(int_ax & 0xFF);
            break;
        }

        // set text color
        case 0x09: {
            set_textcol(int_ax & 0xFF);
            break;
        }

        // set background color
        case 0x0A: {
            outp(0x51, int_ax & 0xFF);
            break;
        }

        // set scrollable screen area
        case 0x0B: {
            settextdim(int_dx & 0xFF, int_dx >> 8);
            break;
        }

        // read character from keyboard buffer
        case 0x10: {
            int_ax = getchar();
            break;
        }

        // read current tick count
        case 0x11: {
            int_ax = ticks;
            break;
        }

        // read date and time
        case 0x12: {
            byte day = 0, month = 0, year = 0;
            if (cfg_rtc && (int_ax & 0xFF) > 0)
                ds1307_getdate(&day, &month, &year);
            asm volatile ("CLI");
            byte seconds = t_seconds;
            byte minutes = t_minutes;
            byte hours = t_hours;
            asm volatile ("STI");

            int_ax = (((word)minutes) << 8) + seconds;
            int_cx = (((word)day) << 8) + hours;
            int_dx = (((word)year) << 8) + month;
            break;
        }

        // set time
        case 0x13: {
            byte seconds = int_cx;
            byte minutes = int_cx >> 8;
            byte hours = int_dx;

            asm volatile ("CLI");
            t_hours = hours;
            t_minutes = minutes;
            t_seconds = seconds;
            asm volatile ("STI");
            if (cfg_rtc) ds1307_settime(hours, minutes, seconds);
            break;
        }

        // set date
        case 0x14: {
            byte day = int_cx;
            byte month = int_cx >> 8;
            byte year = int_dx;
            if (cfg_rtc) ds1307_setdate(year, month, day);
            break;
        }
    }
}
