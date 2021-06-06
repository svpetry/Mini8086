#ifndef BIOS_H
#define BIOS_H

#include "../../Lib/types.h"

extern volatile byte t_hours;
extern volatile byte t_minutes;
extern volatile byte t_seconds;
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

#endif