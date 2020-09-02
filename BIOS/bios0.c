#include "bios0.h"

int main() {
    int i, j;

    while (1) {
        outp(0x08, 0xff);
        for (i = 0; i < 2000; i++) ;
        outp(0x08, 0x00);
        for (i = 0; i < 2000; i++) ;
    }

    //outp(0x08, 0xff);

    while (1) {
        for (i = 0; i < 16; i++) {
            DisplayNumber(i);
            for (j = 0; j < 8000; j++) ;
        }
    }

    while (1) ;
    return 0;
}

void outp(int port, unsigned char value) {
    __asm {
        MOV AL, value
        MOV DX, port
        OUT DX, AL
    }
}

void DisplayNumber(unsigned char x) {
    unsigned char a;
    
    switch (x) {
        case 0x00:
            a = 0x88;
            break;
        case 0x01:
            a = 0xEB;
            break;
        case 0x02:
            a = 0x4C;
            break;
        case 0x03:
            a = 0x49;
            break;
        case 0x04:
            a = 0x28;
            break;
        case 0x05:
            a = 0x19;
            break;
        case 0x06:
            a = 0x18;
            break;
        case 0x07:
            a = 0xCB;
            break;
        case 0x08:
            a = 0x08;
            break;
        case 0x09:
            a = 0x09;
            break;
        case 0x0A:
            a = 0x0A;
            break;
        case 0x0B:
            a = 0x38;
            break;
        case 0x0C:
            a = 0x9B;
            break;
        case 0x0D:
            a = 0x6F;
            break;
        case 0x0E:
            a = 0x1B;
            break;
        case 0x0F:
            a = 0x19;
            break;
    }
    outp(0x08, a);
}

void _cstart() {
}
