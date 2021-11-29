#include "vars.h"
#include "mybasic.h"
#include "../../Lib/app_utils.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"

void init(void) {
	clrscr();
	// IO_WRITE(5, #32);
	// IO_WRITE(6, #31);
}

void main() {

	init();

	puts("                    ___ _            _     ___          _    ");
	puts("                   / __(_)_ __  _ __| |___| _ ) __ _ __(_)__ ");
	puts("                   \\__ \\ | '  \\| '_ \\ / -_) _ \\/ _` (_-< / _|");
	puts("                   |___/_|_|_|_| .__/_\\___|___/\\__,_/__/_\\__|");
	puts("                               |_|       (c)2010-2021 S.Petry ");
	puts("\n");
	if (paramcount) {
		init_vars();
		load_program(params[0]);
		puts("\n\nProgram ready. Press any key to start.");
		getchar();
		clrscr();
		start_basic();
	}
	puts("\n\nPress any key to quit.");
	getchar();

	return;
}
