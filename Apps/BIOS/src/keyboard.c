#include "../../Lib/types.h"
#include "../../Lib/lowlevel.h"
#include "keylayouts.h"
#include "../../Lib/keys.h"

#define KB_QUEUE_LEN 32

char kb_queue[KB_QUEUE_LEN];
byte kb_queue_count;
byte kb_queue_head;
byte kb_queue_tail;

byte shift_l;
byte shift_r;

static void add_to_queue(char c) {
    if (kb_queue_count < KB_QUEUE_LEN) {
        kb_queue[kb_queue_head++] = c;
        if (kb_queue_head == KB_QUEUE_LEN) kb_queue_head = 0;
        kb_queue_count++;
    }
}

static byte getkeycode_wait() {
    int maxtries = 2000;
    while ((inp(0x64) & 0b00000001) == 0) asm("nop");
    if ((inp(0x64) & 0b00000001) > 0) return inp(0x60);
    return 0;
}

static char read_char() {
    byte special = 0;
    byte key_break = 0;
    char result = 0;
   
    byte code = inp(0x60);

    // special key
    if (code == 0xE0 || code == 0xE1) {
        special = 1;
        code = getkeycode_wait();
    }
    
    // break code
    if (code == 0xF0) {
        key_break = 1;
        code = getkeycode_wait();
    }

    if (special) {
        switch (code) {
            case 0x14:
                // Pause/Break has no break code.
                getkeycode_wait(); // 0x77
                getkeycode_wait(); // 0xE1
                getkeycode_wait(); // 0xF0
                getkeycode_wait(); // 0x14
                getkeycode_wait(); // 0xF0
                getkeycode_wait(); // 0x77
                result = KEY_PAUSE;
                break;
            case 0x6B: // left
                result = KEY_LEFT;
                break;
            case 0x75: // up
                result = KEY_UP;
                break;
            case 0x72: // down
                result = KEY_DOWN;
                break;
            case 0x74: // right
                result = KEY_RIGHT;
                break;
            case 0x6C: // home
                result = KEY_HOME;
                break;
            case 0x69: // end
                result = KEY_END;
                break;
            case 0x7D: // page up
                result = KEY_PAGEUP;
                break;
            case 0x7A: // page down
                result = KEY_PAGEDOWN;
                break;
            case 0x71: // del
                result = KEY_DELETE;
                break;
            case 0x70: // insert
                result = KEY_INSERT;
        }
    } else {
        result = decodekey_ger(code, shift_l || shift_r);
    }

    if (result == 0) {
        switch (code) {
            case 0x0D: // tab
                result = '\t';
                break;
            case 0x29: // space
                result = ' ';
                break;
            case 0x5A: // enter
                result = '\n';
                break;
            case 0x76: // escape
                result = KEY_ESCAPE;
                break;
            case 0x66: // backspace
                result = KEY_BACKSPACE                                                                                                 ;
                break;
            case 0x12: // left shift
                shift_l = key_break ? 0 : 1;
                break;
            case 0x59: // right shift
                shift_r = key_break ? 0 : 1;
                break;
        }
    }
    
    if (key_break) return 0;
    return result;
}

void keyb_init() {
    kb_queue_count = 0;
    kb_queue_head = 0;
    kb_queue_tail = 0;
    shift_l = 0;
    shift_r = 0;

    // clear output buffer
    while ((inp(0x64) & 0b00000001) > 0) inp(0x60);
}

void keyb_handleint() {
    while ((inp(0x64) & 0b00000001) > 0) {
        char c = read_char();
        if (c != 0) add_to_queue(c);
    }
}

byte haschar() {
    return kb_queue_count > 0;
}

char getchar() {
    if (kb_queue_count == 0) return 0;
    char result = kb_queue[kb_queue_tail++];
    if (kb_queue_tail == KB_QUEUE_LEN) kb_queue_tail = 0;
    kb_queue_count--;
    return result;
}
