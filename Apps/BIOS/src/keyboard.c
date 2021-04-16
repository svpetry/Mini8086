#include "../../Lib/types.h"
#include "../../Lib/lowlevel.h"

#define KB_QUEUE_LEN 16

byte kb_queue[KB_QUEUE_LEN];
byte kb_queue_count;
byte kb_queue_head;
byte kb_queue_tail;

void keyb_init() {
    kb_queue_count = 0;
    kb_queue_head = 0;
    kb_queue_tail = 0;
}

void keyb_handleint() {
    while (inp(0x64) & 0b00000001 > 0) {
        byte data = inp(0x60);
        asm("cli");
        if (kb_queue_count < KB_QUEUE_LEN) {
            kb_queue[kb_queue_head++] = data;
            if (kb_queue_head == KB_QUEUE_LEN) kb_queue_head = 0;
            kb_queue_count++;
        }
        asm("sti");
    }
}

byte keyb_has_code() {
    return kb_queue_count > 0;
}

char keyb_get_code() {
    if (kb_queue_count == 0) return 0;
    asm("cli");
    char result = kb_queue[kb_queue_tail++];
    if (kb_queue_tail == KB_QUEUE_LEN) kb_queue_tail = 0;
    kb_queue_count--;
    asm("sti");
}
