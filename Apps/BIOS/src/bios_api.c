#include "bios_api.h"
#include "../../Lib/types.h"
#include "../../Lib/screen.h"
#include "keyboard.h"
#include "bios_fsapi.h"
#include "bios.h"

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

        // set cursor position
        case 0x01: {
            setcursor(int_dx, int_dx >> 8);
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
            settext_far(int_dx, int_dx >> 8, (char __far *)addr, int_cx);
            break;
        }

        // show or hide the cursor
        case 0x08: {
            enable_cursor(int_ax & 0xFF);
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
    }
}
