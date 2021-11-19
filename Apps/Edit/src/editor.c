#include "editor.h"
#include "utils.h"
#include "../../Lib/types.h"
#include "../../Lib/strutils.h"
#include "../../Lib/strutils_far.h"
#include "../../Lib/kernel.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/app_utils.h"
#include "../../Lib/keys.h"
#include "../../Lib/colors.h"
#include "../../Lib/debug.h"
#include "../../Lib/file_buffer.h"

#define SCREEN_COLS 80

char line_buf[MAX_LINE_LENGTH + 1];
char file_name[13];

struct line_header __far *line_base;
struct line_header __far *start_line; // 1st line of visible screen area
struct line_header __far *curr_line; // cursor line

byte edit_active;

const char msg_out_of_memory[] = "Out of memory. Press any key to continue.";

void show_message(const char *msg) {
	set_line(24, ' ' | 0x80);
	write_inverse(24, 1, msg);
}

void free_lines() {	
	struct line_header __far *lp = line_base;
	while (lp != NULL) {
		void __far *ptr = lp;
		lp = lp->next;
		k_free(ptr);
	}
	line_base = NULL;
}

void quit_editor() {
	free_lines();
	quit_app();
}

byte prompt_file_name() {
	char s[13];
	byte pos;
	char c, col;
	byte esc = 0;

	const byte pos_offset = 11;

	pos = strlen(file_name);
	strcpy(s, file_name);
	show_message("");
	write_inverse(24, 1, "Filename: ");
	write_inverse(24, pos_offset, s);

	c = 0;
	while (c != '\n' && !esc) {

		setcursor(pos_offset + pos, 24);
		c = getchar_wait();

		if ((c >= 'A' && c <= 'Z')
			|| (c >= 'a' && c <= 'z')
			|| (c >= '0' && c <= '9')
			|| c == ' ' || c == '_' || c == '-' || c == '.')
		{
			if (pos < 12) {
				s[pos] = c;
				putchar(c + 0x80);
				pos++;
			}

		} else if (c == 8) { // backspace
			if (pos > 0) {
				pos--;
				s[pos] = ' ' + 0x80;
				setcursor(pos_offset + pos, 24);
				putchar(' ' + 0x80);
			}
		} else if (c == 27) // escape
			esc = 1;
	}
	
	if (esc)
		return 0;

	s[pos] = 0;
	strcpy(file_name, s);
	return 1;
}

void trim_line(struct line_header __far *line, byte use_line_buf) {
	byte l;
	struct line_header __far *new_line;

	if (use_line_buf)
		l = strlen_far(line_buf);
	else
		l = strlen_far(line->line);

	if (l + 2 < line->size || use_line_buf) {
		if ((new_line = k_malloc(LINE_HEADER_SIZE + l + 1)) == NULL) {
			show_message(msg_out_of_memory);
			getchar_wait();
			quit_editor();
		}
		if (use_line_buf)
			strcpy_far(new_line->line, line_buf);
		else
			strcpy_far(new_line->line, line->line);
		new_line->size = l;
		new_line->next = line->next;
		new_line->prev = line->prev;
		new_line->prev->next = new_line;
		if (new_line->next != NULL)
			new_line->next->prev = new_line;
		if (curr_line == line)
			curr_line = new_line;
		if (start_line == line)
			start_line = new_line;
		k_free(line);
	}
}

void show_status() {
	char s[20];

	show_message("");
	if (file_name[0] == 0)
		write_inverse(24, 1, "<new file>");
	else
		write_inverse(24, 1, file_name);
	write_inverse(24, 20, "Free RAM: ");
	ltoa(k_check_free_memory(), s);
	strcat(s, " Bytes");
	write_inverse(24, 30, s);
}

void init_line_base() {
	line_base = k_malloc(LINE_HEADER_SIZE + 1);
	line_base->next = NULL;
	line_base->prev = NULL;
	line_base->size = 0;
	line_base->line[0] = '\0';
}

void init_empty_file() {
	init_line_base();
	start_line = curr_line = k_malloc(LINE_HEADER_SIZE + 1);
	curr_line->next = NULL;
	curr_line->prev = line_base;
	line_base->next = curr_line;

	curr_line->size = 0;
	curr_line->line[0] = '\0';
}

void start_lineedit() {
	char __far *src;
	char *dest;
    byte i;

	if (!edit_active) {
		src = curr_line->line;
		dest = line_buf;
		i = 0;
		while (*src) {
			*(dest++) = *(src++);
			i++;
		}
		while (i < MAX_LINE_LENGTH) {
			*(dest++) = ' ';
			i++;
		}
		*dest = 0;

		edit_active = 1;
	}
}

void finish_lineedit() {
	char *s;

	if (edit_active) {

		s = line_buf + MAX_LINE_LENGTH - 1;
		while (*s == ' ' && s != line_buf)
			s--;
		if (*s == ' ')
			*s = 0;
		else
			*(s + 1) = 0;

		trim_line(curr_line, 1);
		edit_active = 0;
		show_status();
	}
}

void display() {
	byte i;
	struct line_header __far *line = start_line;

	for (i = 0; i < rows_total && line != NULL; i++) {
		put_line_far(line->line, i);
		line = line->next;
	}

	while (i < rows_total)
		put_line("", i++);
}

void load_file() {
	char c;        
	byte i, col, handle;
	struct line_header __far *line;
	struct line_header __far *new_line;
	dword size;

	free_lines();
	init_line_base();
	line = line_base;

	if (!fs_open_buffered(file_name, &handle, &size)) {
		show_message("Loading...");
		col = 0;

		i = 0;
		
		while (size > 0) {
			c = fs_read_buffered(handle);
			size--;

			if (c >= ' ' && (unsigned char)c < 128 ) {
				line_buf[i++] = c;
			} else if (c == '\t') {
				line_buf[i++] = ' ';
				while ((i & 0x03) > 0 && i < MAX_LINE_LENGTH)
                	line_buf[i++] = ' ';
			}
			if (i == MAX_LINE_LENGTH || c == '\n') {
				line_buf[i++] = 0;
				new_line = k_malloc(LINE_HEADER_SIZE + i + 1);
				if (new_line == NULL) {
					show_message(msg_out_of_memory);
					getchar_wait();
					quit_editor();
				}
				line->next = new_line;
				new_line->prev = line;
				strcpy_far(new_line->line, line_buf);
				new_line->size = i;

				line = new_line;
				i = 0;
			}
		}

		line_buf[i++] = 0;
		new_line = k_malloc(LINE_HEADER_SIZE + i + 1);
		if (new_line == NULL) {
			show_message(msg_out_of_memory);
			getchar_wait();
			quit_editor();
		}
		line->next = new_line;
		new_line->prev = line;
		strcpy_far(new_line->line, line_buf);
		new_line->size = i;
		new_line->next = NULL;

		fs_close(handle);
	} else {
		init_empty_file();
		show_message("File not found! Press any key to continue.");
		getchar_wait();
	}
}

void save_file() {
	// word bidx;
	// byte l, i;
	// struct line_header *line;
	// char *s;

	// if (prompt_file_name()) {

	// 	show_message("Saving...");

	// 	if (fopen_write(file_name, NULL)) {

	// 		bidx = 0;
	// 		line = line_base->next;

	// 		while (line != NULL) {
	// 			l = strlen(line->line);
	// 			if (bidx + l + 2 > 0x200) {
	// 				fwriteblock(bidx);
	// 				bidx = 0;
	// 			}
	// 			s = line->line;
	// 			for (i = 0; i < l; i++)
	// 				disk_buffer[bidx++] = *(s++);
	// 			if (line->next != NULL) {
	// 				disk_buffer[bidx++] = 13;
	// 				disk_buffer[bidx++] = 10;
	// 			}

	// 			line = line->next;
	// 		}
	// 		if (bidx > 0)
	// 			fwriteblock(bidx);

	// 	} else {
	// 		show_message("Error! Press any key to continue.");
	// 		getchar_wait();
	// 	}
	// }

}

void prompt_load_file() {
	if (prompt_file_name()) {
		// k_malloc_reset(HEAP_START, HEAP_SIZE);
		load_file();
		edit_active = 0;
		start_line = curr_line = line_base->next;
		display();
	}
}

void init_editor() {
	// k_malloc_reset(HEAP_START, HEAP_SIZE);

	// settextdim(1, 23);
	line_base = NULL;
	first_row = 1;
	rows_total = 23;
	set_bgcolor(DARKER_GREEN);
	set_textcolor(LIGHTER_GREEN);
	clrscr();
	enable_cursor(1);
	settextdim(first_row, first_row + rows_total - 1);

	set_line(0, ' ' | 0x80);
	set_line(24, ' ' | 0x80);
	write_inverse(0, 0, " F2: SAVE   F3: LOAD   F5: -   F6: -   F8: DELETE   F10: QUIT");

	if (paramcount) {
		strcpy(file_name, params[0]);
		load_file();
	} else {
		file_name[0] = 0;
		init_empty_file();
	}
	show_status();
}

void start_editor() {
	char c;
	char __far *fs;
	char __far *fdest;
	char *s;
	int i, l;
	struct line_header __far *line1;
	struct line_header __far *line2;

	edit_active = 0;
	start_line = curr_line = line_base->next;

	display();
	int cur_col = 0, cur_row = 0;

	while (1) {
		// showcursor();
		setcursor(cur_col, first_row + cur_row);
		c = getchar_wait();
		// hidecursor();

		if (c < 0x20) {
        	// special key
			switch (c) {
				case KEY_F1: // F1
					break;
				case KEY_F2: // F2
					finish_lineedit();
					save_file();
					show_status();
					break;
				case KEY_F3: // F3
					finish_lineedit();
					prompt_load_file();
					show_status();
					break;
				case KEY_F4: // F4
					break;
				case KEY_F5: // F5
					break;
				case KEY_F6: // F6
					break;
				case KEY_F7: // F7
					break;
				case KEY_F8: // F8
					finish_lineedit();
					line1 = curr_line;
					if (curr_line->next != NULL) {
						curr_line->prev->next = curr_line->next;
						curr_line->next->prev = curr_line->prev;
						if (start_line == curr_line)
							start_line = curr_line->next;
						curr_line = curr_line->next;
						k_free(line1);
						show_status();
					} else
						curr_line->line[0] = 0;
					display();
					break;
				case KEY_F9: // F9
					break;
				case KEY_F10: // F10
					quit_editor();
					break;
				case KEY_UP: // up
					if (cur_row > 0) {
						finish_lineedit();
						cur_row--;
						curr_line = curr_line->prev;
					} else {
						if (curr_line->prev != line_base) {
							finish_lineedit();
							// cur_row--;
							scrolldown(1);
							start_line = curr_line = curr_line->prev;
							put_line_far(start_line->line, 0);
						}
					}
					break;
				case KEY_DOWN: // down
					if (curr_line->next != NULL) {
						finish_lineedit();
						if (cur_row < rows_total - 1) {
							cur_row++;
							curr_line = curr_line->next;
						} else {
							// cur_row++;
							scrollup(1);
							start_line = start_line->next;
							curr_line = curr_line->next;
							put_line_far(curr_line->line, rows_total - 1);
						}
					}
					break;
				case KEY_RIGHT: // right
					if (cur_col < SCREEN_COLS - 1) {
						cur_col++;
					}
					break;
				case KEY_LEFT: // left
					if (cur_col > 0) {
						cur_col--;
					}
					break;
				case KEY_PAGEUP: // page up
					finish_lineedit();
					if (start_line->prev == line_base) {
						cur_row = 0;
						curr_line = start_line;
					} else {
						i = rows_total;
						while (i > 0 && start_line->prev != line_base) {
							start_line = start_line->prev;
							curr_line = curr_line->prev;
							i--;
						}
					}
					display();
					break;
				case KEY_PAGEDOWN: // page down
					finish_lineedit();
					i = rows_total;
					while (i > 0 && start_line->next != NULL) {
						start_line = start_line->next;
						if (curr_line->next != NULL)
							curr_line = curr_line->next;
						else
                        	cur_row--;
						i--;
					}
					display();	
					break;
				case KEY_HOME: // home
                	cur_col = 0;
					break;
				case KEY_END: // end
					if (edit_active) {
						s = line_buf + MAX_LINE_LENGTH - 1;
						while (*s == ' ' && s != line_buf)
							s--;
						cur_col = (byte)((word)s - (word)line_buf) + 1;
					} else
						cur_col = strlen_far(curr_line->line);
					if (cur_col > SCREEN_COLS - 1)
                    	cur_col = SCREEN_COLS - 1;
					break;
			}

			if (c == '\n') { // enter
				finish_lineedit();

				l = strlen_far(curr_line->line);
				if (cur_col >= l) {
					// cursor after text line
					if ((line2 = k_malloc(LINE_HEADER_SIZE + 1)) == NULL) {
						show_message(msg_out_of_memory);
						getchar_wait();
						quit_editor();
					}

					line2->size = 0;
					line2->line[0] = '\0';
					line2->prev = curr_line;
					line2->next = curr_line->next;
					if (line2->next != NULL)
						line2->next->prev = line2;
					line2->prev->next = line2;
					curr_line = line2;
					if (cur_row == rows_total - 1)
						start_line = start_line->next;
					else
						cur_row++;
					show_status();
				} else {
					// cursor in text line
                    line1 = curr_line;

					if ((line2 = k_malloc(LINE_HEADER_SIZE + l - cur_col + 1)) == NULL) {
						show_message(msg_out_of_memory);
						getchar_wait();
						quit_editor();
					}

					i = l - cur_col;
					fdest = line2->line;
					fs = curr_line->line + cur_col;
					while (i > 0) {
						*(fdest++) = *(fs++);
						i--;
					}
					*fdest = '\0';
					*(curr_line->line + cur_col) = '\0';

					line2->size = cur_col - l;
					line2->prev = curr_line;
					line2->next = curr_line->next;
					if (line2->next != NULL)
						line2->next->prev = line2;
					line2->prev->next = line2;
					curr_line = line2;
					if (cur_row == rows_total - 1)
						start_line = start_line->next;
					else
						cur_row++;

					trim_line(line1, 0);
					show_status();
				}

				cur_col = 0;
				display();
			} else if (c == 8) { // backspace
				l = strlen_far(curr_line->line);
				if (cur_col > l && !edit_active) {
					if (cur_col > 0)
						cur_col--;
				} else if (cur_col > 0) {
					start_lineedit();
					s = line_buf + cur_col;
					while (*s) {
						*(s - 1) = *s;
						s++;
					}
					*(s - 1) = ' ';
					put_line(line_buf, cur_row);
					cur_col--;
				} else {

				}
			} else if (c == 9) { // tab
			}
		} else {
			
			// other characters
			start_lineedit();
			s = line_buf + MAX_LINE_LENGTH - 2;
			while (s >= line_buf + cur_col) {
				*(s + 1) = *(s);
				s--;
			}
			*(s + 1) = c;
			put_line(line_buf, cur_row);
			if (cur_col < SCREEN_COLS - 1)
				cur_col++;
		}
		setcursor(cur_col, first_row +  cur_row);
	}
}
