#include "../../Lib/types.h"

extern volatile word sp_save;
extern volatile word ss_save;

extern volatile word int_ax;
extern volatile word int_bx;
extern volatile word int_cx;
extern volatile word int_dx;

extern void int_kernel();
