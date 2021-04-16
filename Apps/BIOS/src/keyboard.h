#include "../../Lib/types.h"

/* initializes the keyboard handling */
void keyb_init();

/* handles a keyboard controller interrupt */
void keyb_handleint();

/* returns true if the keyboard queue is not empty */
byte keyb_has_code();

/* returns the next keycode in the queue */
char keyb_get_code();
