#include "types.h"

/* resets the SD drive */
bool sd_reset();

/* initializes the SD drive. Called when a new SD card is inserted. */
bool sd_init();

/* returns true when the SD slot is currently containing an SD card */
bool sd_inserted();
