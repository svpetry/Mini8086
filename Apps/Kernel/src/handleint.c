#include "handleint.h"
#include "../../Lib/types.h"

volatile word int_sp_save;
volatile word int_ss_save;

volatile word int_ax;
volatile word int_cx;
volatile word int_dx;

void int_kernel() {
    switch (int_ax >> 8) {
        // start process
        case 0x00:
            break;

        // kill process
        case 0x01:
            break;

        // list first process
        case 0x10:
            break;

        // list next process
        case 0x11:
            break;

        // allocate memory block
        case 0x20:
            break;

        // free memory block
        case 0x21:
            break;

        // check freee memory
        case 0x022:
            break;
    }
}