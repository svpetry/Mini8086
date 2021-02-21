#include "types.h"

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
