#include "utils.h"
#include "../../Lib/types.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_screen_far.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/strutils.h"
#include "../../Lib/strutils_far.h"
#include "../../Lib/kernel.h"

static byte text_color = LIGHT_GREEN;

byte first_row;
byte rows_total;

void set_line(int row, char c) {
    char s[LINE_LEN + 1];
    int i;
    for (i = 0; i < LINE_LEN; i++)
        s[i] = c;
    s[i] = '\0';
    settext(0, row, s, text_color, FALSE);
}

void write_inverse(byte row, byte col, const char *s) {
    settext(col, row, s, text_color, TRUE);
}

void put_line(const char *s, int row) {
    settext(0, first_row + row, s, text_color, FALSE);
    int len = strlen(s);
    if (len < 80) {
        char fill[81];
        strofchar(fill, 80 - len, ' ');
        settext(len, first_row + row, fill, text_color, FALSE);
    }
}

void put_line_far(const char __far *s, int row) {
    settext_far(0, first_row + row, s, text_color, FALSE);
    int len = strlen_far(s);
    if (len < 80) {
        char fill[81];
        strofchar(fill, 80 - len, ' ');
        settext(len, first_row + row, fill, text_color, FALSE);
    }
}

