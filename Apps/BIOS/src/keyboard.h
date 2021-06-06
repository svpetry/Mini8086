#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "../../Lib/types.h"

/* initializes the keyboard handling */
void keyb_init();

/* handles a keyboard controller interrupt */
void keyb_handleint();

/* returns true if the keyboard queue is not empty */
byte haschar();

/* returns the next keycode in the queue */
char getchar();

#endif
