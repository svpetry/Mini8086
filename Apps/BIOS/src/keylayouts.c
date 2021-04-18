#include "keylayouts.h"

char decodekey_ger(byte code, byte shift) {
    char result = 0;
    if (!shift) {
        switch (code) {
            case 0x1C:
                result = 'a';
                break;
            case 0x32:
                result = 'b';
                break;
            case 0x21:
                result = 'c';
                break;
            case 0x23:
                result = 'd';
                break;
            case 0x24:
                result = 'e';
                break;
            case 0x2B:
                result = 'f';
                break;
            case 0x34:  
                result = 'g';
                break;
            case 0x33:
                result = 'h';
                break;
            case 0x43:
                result = 'i';
                break;
            case 0x3B:
                result = 'j';
                break;
            case 0x42:
                result = 'k';
                break;
            case 0x4B:
                result = 'l';
                break;
            case 0x3A:
                result = 'm';
                break;
            case 0x31:
                result = 'n';
                break;
            case 0x44:
                result = 'o';
                break;
            case 0x4D:
                result = 'p';
                break;
            case 0x15:
                result = 'q';
                break;
            case 0x2D:
                result = 'r';
                break;
            case 0x1B:
                result = 's';
                break;
            case 0x2C:
                result = 't';
                break;
            case 0x3C:
                result = 'u';
                break;
            case 0x2A:
                result = 'v';
                break;
            case 0x1D:
                result = 'w';
                break;
            case 0x22:
                result = 'x';
                break;
            case 0x1A:
                result = 'y';
                break;
            case 0x35:
                result = 'z';
                break;
            case 0x45:
                result = '0';
                break;
            case 0x16:
                result = '1';
                break;
            case 0x1E:
                result = '2';
                break;
            case 0x26:
                result = '3';
                break;
            case 0x25:
                result = '4';
                break;
            case 0x2E:
                result = '5';
                break;
            case 0x36:
                result = '6';
                break;
            case 0x3D:
                result = '7';
                break;
            case 0x3E:
                result = '8';
                break;
            case 0x46:
                result = '9';
                break;
            // case 0x54:
            //     result = 'ü';
            //     break;
            case 0x5B:
                result = '+';
                break;
            // case 0x4C:
            //     result = 'ö';
            //     break;
            // case 0x52:
            //     result = 'ä';
            //     break;
            case 0x5D:
                result = '#';
                break;
            case 0x41:
                result = ',';
                break;
            case 0x49:
                result = '.';
                break;
            case 0x4A:
                result = '-';
                break;
        } 
    } else {
        switch (code) {
            case 0x1C:
                result = 'A';
                break;
            case 0x32:
                result = 'B';
                break;
            case 0x21:
                result = 'C';
                break;
            case 0x23:
                result = 'D';
                break;
            case 0x24:
                result = 'E';
                break;
            case 0x2B:
                result = 'F';
                break;
            case 0x34:  
                result = 'G';
                break;
            case 0x33:
                result = 'H';
                break;
            case 0x43:
                result = 'I';
                break;
            case 0x3B:
                result = 'J';
                break;
            case 0x42:
                result = 'K';
                break;
            case 0x4B:
                result = 'L';
                break;
            case 0x3A:
                result = 'M';
                break;
            case 0x31:
                result = 'N';
                break;
            case 0x44:
                result = 'O';
                break;
            case 0x4D:
                result = 'P';
                break;
            case 0x15:
                result = 'Q';
                break;
            case 0x2D:
                result = 'R';
                break;
            case 0x1B:
                result = 'S';
                break;
            case 0x2C:
                result = 'T';
                break;
            case 0x3C:
                result = 'U';
                break;
            case 0x2A:
                result = 'V';
                break;
            case 0x1D:
                result = 'W';
                break;
            case 0x22:
                result = 'X';
                break;
            case 0x1A:
                result = 'Y';
                break;
            case 0x35:
                result = 'Z';
                break;
            case 0x45:
                result = '=';
                break;
            case 0x16:
                result = '!';
                break;
            case 0x1E:
                result = '"';
                break;
            // case 0x26:
            //     result = '§';
            //     break;
            case 0x25:
                result = '$';
                break;
            case 0x2E:
                result = '%';
                break;
            case 0x36:
                result = '&';
                break;
            case 0x3D:
                result = '/';
                break;
            case 0x3E:
                result = '(';
                break;
            case 0x46:
                result = ')';
                break;
            // case 0x54:
            //     result = 'Ü';
            //     break;
            case 0x5B:
                result = '*';
                break;
            // case 0x4C:
            //     result = 'Ö';
            //     break;
            // case 0x52:
            //     result = 'Ä';
            //     break;
            case 0x5D:
                result = '\'';
                break;
            case 0x41:
                result = ';';
                break;
            case 0x49:
                result = ':';
                break;
            case 0x4A:
                result = '_';
                break;
        }
    }
    return result;
}

char decodekey_en(byte code, byte shift) {

}
