#include "../../Lib/types.h"
#include "../../Lib/lowlevel.h"
#include "../../Lib/screen.h"
#include "keylayouts.h"
#include "defs.h"
#include "../../Lib/keys.h"

#define KB_QUEUE_LEN    32
#define KEYLAYOUT_US    0
#define KEYLAYOUT_DE    1

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
    byte code = 0;
    int maxtries = 2000;
    while ((inp(0x64) & 0b00000001) == 0) asm("nop");
    if ((inp(0x64) & 0b00000001) > 0)
        code = inp(0x60);
#if KEYB_DEBUG
    putstr("code ");
    puthexbyte(code);
    putch('\n');
#endif
    return code;
}

static char read_char() {
    byte special = 0;
    byte key_break = 0;
    char result = 0;
   
    byte code = getkeycode_wait();

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
                result = KEY_BACKSPACE;
                break;
            case 0x12: // left shift
                shift_l = key_break ? 0 : 1;
                break;
            case 0x59: // right shift
                shift_r = key_break ? 0 : 1;
                break;
            case 0x05: // F1
                result = KEY_F1;
                break;
            case 0x06: // F2
                result = KEY_F2;
                break;
            case 0x04: // F3
                result = KEY_F3;
                break;
            case 0x0C: // F4
                result = KEY_F4;
                break;
            case 0x03: // F5
                result = KEY_F5;
                break;
            case 0x0B: // F6
                result = KEY_F6;
                break;
            case 0x83: // F7
                result = KEY_F7;
                break;
            case 0x0A: // F8
                result = KEY_F8;
                break;
            case 0x01: // F9
                result = KEY_F9;
                break;
            case 0x09: // F10
                result = KEY_F10;
                break;
            case 0x78: // F11
                result = KEY_F11;
                break;
            case 0x07: // F12
                result = KEY_F12;
                break;
        }
    }
    
#if KEYB_DEBUG
    putstr("---\n");
#endif

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
