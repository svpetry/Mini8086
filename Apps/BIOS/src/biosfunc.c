#include "biosfunc.h"
#include "../../Lib/types.h"
#include "../../Lib/screen.h"
#include "keyboard.h"

volatile word int_sp_save;
volatile word int_ss_save;

volatile word int_ax;
volatile word int_cx;
volatile word int_dx;

void int_bios() {
    switch (int_ax >> 8) {

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
            putch(int_ax);
            break;
        }

        // read character from cursor position
        case 0x05: {
            break;    
        }

        // write string at cursor position
        case 0x06: {
            dword addr = (((dword)int_cx) << 16) + int_dx;
            putstr_far((char __far *)addr);
            break;
        }

        // read character from keyboard buffer
        case 0x10: {
            int_ax = getchar();
            break;
        }
    }
}
