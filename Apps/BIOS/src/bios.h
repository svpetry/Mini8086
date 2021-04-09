#include "../../Lib/types.h"

extern volatile byte hours;
extern volatile byte minutes;
extern volatile byte seconds;
extern volatile byte ticks; // 20 ticks/sec.

/* BIOS startup routine */
int main();

/* divide by zero interrupt handler */
void int_div_by_zero();

/* NMI interrupt handler */
void int_nmi();

/* overflow interrupt handler */
void int_overflow();

/* timer interrupt handler */
void int_timer();

/* keyboard interupt handler */
void int_keyboard();

/* sd drive interrupt handler */
void int_drive();