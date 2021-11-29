#include "mybasic.h"
#include "../../Lib/types.h"
#include "../../Lib/kernel.h"
#include "../../Lib/utils.h"
#include "../../Lib/strutils.h"
#include "../../Lib/app_utils.h"
#include "../../Lib/file_buffer.h"
#include "../../Lib/bios_fs.h"
#include "../../Lib/bios_screen.h"
#include "../../Lib/bios_misc.h"
#include "utils.h"
#include "bdefs.h"
#include "basic_helpers.h"

#define HEAP_START 0x8000
#define HEAP_SIZE 0x8000

void quit_basic() {
	// TODO memory
	quit_app();
}

void load_program(char *file_name) {
	word i = 0;
	char val[MAX_NUMSTR_LEN + 1], *s;
	byte l;
	int lbl, last_lbl = 0;
	dword size;
	byte handle;
	char fname[16];
	
#define READ_CHAR fs_read_buffered(handle); size--

	if (!fs_open_buffered(file_name, &handle, &size)) {
		strcpy(fname, file_name);
		strcat(fname, ".bas");
		if (!fs_open_buffered(file_name, &handle, &size)) {
			puts("File not found! Press key to continue.");
			getchar();
			quit_basic();
		}
	}
	puts("Loading...");

	i = 0;
	ip = prog;

	while (size > 0 && i < MAX_PROG_FILE_SIZE) {
		*ip = fs_read_buffered(handle);
		size--;

		if (*ip != '\r') {
			if (*ip == '\n' || i == 0) {

				if (*ip == '\n' && size > 0) {
					*(++ip) = fs_read_buffered(handle);
					size--;
				}
				
				// skip white space
				while (size > 0 && i < MAX_PROG_FILE_SIZE && (iswhite(*ip) || *ip == '\n')) {
					*ip = fs_read_buffered(handle);
					size--;
					i++;
				}

				// read label value into string
				s = val;
				l = 0;
				while (size > 0 && isnum(*ip) && i < MAX_PROG_FILE_SIZE && l < 6) {
					*(s++) = *ip;
					*ip = fs_read_buffered(handle);
					size--;
					i++;
					l++;
				}
				*s = 0;

				// skip white space
				while (size > 0 && i < MAX_PROG_FILE_SIZE && iswhite(*ip)) {
					*ip = fs_read_buffered(handle);
					size--;
					i++;
				}

				// create label
				if (l > 0) {
					val[l] = 0;
					lbl = atoi(val);
					if (last_lbl >= lbl)
						error(E_LABEL_ORDER);
					last_lbl = lbl;

					labels[label_count].pos = ip;
					labels[label_count].label = lbl;
					label_count++;
				}

			}

			if (size > 0 && i < MAX_PROG_FILE_SIZE) {
				ip++;
				i++;
			}
		}
	}

	*ip = '\0'; // null terminate the program
	fs_close(handle);

	if (i == MAX_PROG_FILE_SIZE) {
		puts("File too large! Press key to continue.");
		getchar();
		quit_basic();
	}
}

void error(byte errno) {
	print_error_text(errno);
	ip--;
	do {
	  ip--;
	} while (ip > prog && *ip != '\n');
	if (ip > prog)
		ip++;
	while (*ip && *ip != '\n')
		putchar(*(ip++));
	putchar('\n');
	getchar();
	quit_basic();
}

void next_line() {
#ifdef DBG_INFO
	puts("next_line()");
#endif
	token_back = 0;
	
	while (*ip != '\n' && *ip)
		ip++;
	while (*ip == '\n' && *ip)
		ip++;
	token = 255;
}

void set_strvar(char *varname, char *value, int vd1, int vd2, int vd3) {
	int i;
	byte l, l1;
	struct s_strvar *svar = NULL;
	struct s_strdvar *sdvar;
	char __far **s;

#ifdef DBG_INFO
	puts("set_strvar()");
#endif

	l = strlen(value);
	for (i = 0; i < str_dvar_count; i++) {
		if (!strcmp(varname, str_dvars[i].name))
			break;
	}
	if (i < str_dvar_count && vd1 != -1) {
		sdvar = &str_dvars[i];
		if (vd3)
			s = sdvar->data + vd1 + vd2 * sdvar->len_dim1 + vd3 * sdvar->len_dim1 * sdvar->len_dim2;
		else if (vd2)
			s = sdvar->data + vd1 + vd2 * sdvar->len_dim1;
		else
			s = sdvar->data + vd1;

		if (*s != NULL)
			k_free(*s);
		if (l > 0) {
			*s = k_malloc(l + 1);
			strcpy_near_to_far(*s, value);
		}
	} else {

		l1 = (l & 0xf8) + 8;

		for (i = 0; i < str_var_count; i++) {
			if (!strcmp(varname, str_vars[i].name)) {
				svar = &(str_vars[i]);
				if (svar->maxlen < l) {
					k_free(svar->value);
					if ((svar->value = k_malloc(l1 + 1)) == NULL)
						error(E_OUT_OF_MEMORY);
					svar->maxlen = l1;
				}
				break;
			}
		}
		if (i == str_var_count) {
			if (str_var_count == MAX_STRING_VARS)
				error(E_TOO_MANY_VARS);
			str_var_count++;
			svar = &(str_vars[i]);
			strcpy(svar->name, varname);
			if ((svar->value = k_malloc(l1 + 1)) == NULL)
				error(E_OUT_OF_MEMORY);
			svar->maxlen = l1;
		}
		strcpy_near_to_far(svar->value, value);
	}
}

void set_numvar(char *varname, struct s_num *value, int vd1, int vd2, int vd3) {
	struct s_num *var;
	struct s_numdvar *dvar;
	int i;

#ifdef DBG_INFO
	puts("set_numvar()");
#endif

//	if (value->isint)
//		printf("set_numvar(%s, %d);\n", varname, value->ival);
//	else
//		printf("set_numvar(%s, %f);\n", varname, value->fval);
//
	for (i = 0; i < num_dvar_count; i++) {
		if (!strcmp(varname, num_dvars[i].name))
			break;
	}
	if (i < num_dvar_count && vd1 != -1) {
		dvar = &num_dvars[i];
		if (vd3)
			var = dvar->data + vd1 + vd2 * dvar->len_dim1 + vd3 * dvar->len_dim1 * dvar->len_dim2;
		else if (vd2)
			var = dvar->data + vd1 + vd2 * dvar->len_dim1;
		else
			var = dvar->data + vd1;
		var->ival = value->ival;
		var->fval = value->fval;
		var->isint = value->isint;
	} else {
		var = find_numvar(varname);
		var->ival = value->ival;
		var->fval = value->fval;
		var->isint = value->isint;
	}
}

void get_next_token() {
	int i;
#ifdef DBG_INFO
	char s[8];
#endif
//	char nums[MAX_NUMSTR_LEN];
//	char *s;
//	char *src;

#ifdef DBG_INFO
	puts("get_next_token()");
#endif

	if (token_back) {
#ifdef DBG_INFO
		puts_nlb("token_back: ");
		itoa(token, s);
		puts(s);
#endif
		token_back = 0;
		return;
	}

	while (iswhite(*ip))
		ip++;

	if (!(*ip)) {
	#ifdef DBG_INFO
		puts("	T_EOP");
	#endif
		*token_str = 0;
		token = T_EOP;
		token_type = TT_SPECIAL;
		return;

	} else if (isnum(*ip)) {
		// numeric value
		byte isint = 1;

		i = 0;
		do {
			if (*ip == '.')
            	isint = 0;
			token_str[i++] = *(ip++);
		} while (isnum(*ip));
		token_str[i] = 0;
		token = isint ? T_INTVAL : T_FLOATVAL;
		token_type = TT_VALUE;
		if (i == MAX_TOKEN_LEN )
			error(E_TOKEN_TOO_LONG);
	#ifdef DBG_INFO
		puts_nlb("T_INTVAL, T_FLOATVAL: ");
		puts(token_str);
	#endif
		return;

	} else if (*ip == '"') {
		// string value
		i = 0;
		do {
			token_str[i++] = *(ip++);
		} while (*ip != '"' && i < MAX_TOKEN_LEN);
		token_str[i++] = *(ip++);
		token_str[i] = 0;
		token = T_STRVAL;
		token_type = TT_VALUE;
		if (i == MAX_TOKEN_LEN )
			error(E_TOKEN_TOO_LONG);
	#ifdef DBG_INFO
		puts_nlb("T_STRVAL: ");
		puts(token_str);
	#endif
		return;

	} else if (isletter(*ip)) {

		i = 0;
		do { // todo SP: [] weg
			token_str[i++] = tolower(*(ip++));
		} while ((isletter(*ip) || isnum(*ip) || *ip == '$') && i < MAX_TOKEN_LEN);
		token_str[i] = 0;
	#ifdef DBG_INFO
		puts_nlb("token_str: ");
		puts(token_str);
	#endif
		if (i == MAX_TOKEN_LEN ) {
			error(E_TOKEN_TOO_LONG);
		}

		token = find_command(token_str);
		if (token) {
			// command
			token_type = TT_COMMAND;
		#ifdef DBG_INFO
			puts("TT_COMMAND");
		#endif
			return;
		}

		token = find_str_func(token_str);
		if (token) {
			// string function
		#ifdef DBG_INFO
			puts("TT_STRFUNC");
		#endif
			token_type = TT_STRFUNC;
			return;
		}

		token = find_num_func(token_str);
		if (token) {
			// numeric function
		#ifdef DBG_INFO
			puts("TT_NUMFUNC");
		#endif
			token_type = TT_NUMFUNC;
			return;
		}

		if (!strcmp(token_str, "and")) {
			// logic and
		#ifdef DBG_INFO
			puts("T_AND");
		#endif
			token_type = TT_LOGIC_OP;
			token = T_AND;
			return;
		}

		if (!strcmp(token_str, "or")) {
			// logic or
		#ifdef DBG_INFO
			puts("T_OR");
		#endif
			token_type = TT_LOGIC_OP;
			token = T_OR;
			return;
		}

		// variable
		token_type = TT_VARIABLE;
		if (token_str[i - 1] == '$') {
		#ifdef DBG_INFO
			puts("T_STRVAR");
		#endif
			token = T_STRVAR;
			if (i > MAX_VAR_NAME_LEN + 1)
				error(E_VARNAME_TOO_LONG);
		} else {
		#ifdef DBG_INFO
			puts("T_NUMVAR");
		#endif
			token = T_NUMVAR;
			if (i > MAX_VAR_NAME_LEN)
				error(E_VARNAME_TOO_LONG);
		}
		return;
		
	} else if (*ip == '\n') {
		ip++;
		if (*ip == '\n')
			ip++;
		// end of line
		token_str[0] = '\n';
		token_str[1] = 0;
	#ifdef DBG_INFO
		puts("T_LINEEND");
	#endif
		token_type = TT_SPECIAL;
		token = T_LINEEND;

	} else if (*ip == ':') {
		// colon
		token_str[0] = ':';
		token_str[1] = 0;
	#ifdef DBG_INFO
		puts("T_COLON");
	#endif
		token_type = TT_SPECIAL;
		token = T_COLON;
		ip++;

	} else if (strchr("+-*^/%=;(),><", *ip)) {
		// special character
		token_str[0] = *ip;
		token_str[1] = 0;
	#ifdef DBG_INFO
		puts("T_SPECIAL");
	#endif
		token_type = TT_SPECIAL;
		token = T_SPECIAL;
		ip++;
	} else {
		error(E_SYNTAX);
	}
}

void get_numvar(char *varname, struct s_num *result) {
	struct s_num *var;
	struct s_numdvar *dvar;
	byte i;

#ifdef DBG_INFO
	puts("get_numvar()");
#endif

	for (i = 0; i < num_dvar_count; i++) {
		if (!strcmp(varname, num_dvars[i].name))
			break;
	}

	read_dimensions();

	if (i < num_dvar_count && dim1 != -1) {

		dvar = &num_dvars[i];
		if (dim3)
			var = dvar->data + dim1 + dim2 * dvar->len_dim1 + dim3 * dvar->len_dim1 * dvar->len_dim2;
		else if (dim2)
			var = dvar->data + dim1 + dim2 * dvar->len_dim1;
		else
			var = dvar->data + dim1;
		result->isint = var->isint;
		result->fval = var->fval;
		result->ival = var->ival;
	} else {
		for (i = 0; i < num_var_count; i++) {
			if (!strcmp(varname, num_vars[i].name)) {
				var = &(num_vars[i].value);
				result->isint = var->isint;
				result->fval = var->fval;
				result->ival = var->ival;
				return;
			}
		}

		if (varname[0] == 'p' && varname[1] == 'i' && varname[2] == 0) {
			result->isint = 0;
			result->fval = 3.14159265;
		} else {
			result->isint = 1;
			result->ival = 0;
		}
	}
}

void get_strvar(char *varname, char *result, int *l) {
	char __far *src;
	char *dest;
	int i;
	struct s_strdvar *sdvar;
	char __far **s;
	char *t;

#ifdef DBG_INFO
	puts("get_strvar()");
#endif

	t = varname;
	while (*t != '$')
		t++;
	*t = 0;

	for (i = 0; i < str_dvar_count; i++) {
		if (!strcmp(varname, str_dvars[i].name))
			break;
	}

	read_dimensions();

	if (i < str_dvar_count && dim1 != -1) {
		sdvar = &str_dvars[i];
		if (dim3)
			s = sdvar->data + dim1 + dim2 * sdvar->len_dim1 + dim3 * sdvar->len_dim1 * sdvar->len_dim2;
		else if (dim2)
			s = sdvar->data + dim1 + dim2 * sdvar->len_dim1;
		else
			s = sdvar->data + dim1;

		if (*s != NULL) {
			src = *s;
			dest = result;
			while (*src && *l < MAX_STRING_LEN) {
				*(dest++) = *(src++);
				(*l)++;
			}
		}
	} else {
		for (i = 0; i < str_var_count; i++) {
			if (!strcmp(varname, str_vars[i].name)) {
				src = str_vars[i].value;
				dest = result;
				while (*src && *l < MAX_STRING_LEN) {
					*(dest++) = *(src++);
					(*l)++;
				}
				break;
			}
		}
	}
}

void put_back() {
#ifdef DBG_INFO
	puts("put_back()");
#endif
	token_back = 1;
}

void put_back_undo() {
#ifdef DBG_INFO
	puts("put_back_undo()");
#endif
	token_back = 0;
	ip -= strlen(token_str);
}

void assign_numvar() {
	char varname[MAX_VAR_NAME_LEN + 1];
	struct s_num value;
	int vd1, vd2, vd3;

#ifdef DBG_INFO
	puts("assign_numvar()");
#endif

	strcpy(varname, token_str);

	read_dimensions();
	vd1 = dim1;
	vd2 = dim2;
	vd3 = dim3;
	get_next_token();

	if (token_str[0] != '=')
		error(E_SYNTAX);
	parse_expression(1);
	if (expr_res.type != VT_FLOAT && expr_res.type != VT_INT)
		error(E_SYNTAX);

	value.ival = expr_res.ival;
	value.fval = expr_res.fval;
	value.isint = expr_res.type == VT_INT ? 1 : 0;
	set_numvar(varname, &value, vd1, vd2, vd3);
}

void assign_strvar() {
	char *src, *dest;
	char varname[MAX_VAR_NAME_LEN + 1];
	int vd1, vd2, vd3;

#ifdef DBG_INFO
	puts("assign_strvar()");
#endif

	src = token_str;
	dest = varname;
	while (*src != '$')
		*(dest++) = *(src++);
	*dest = 0;

	read_dimensions();
	vd1 = dim1;
	vd2 = dim2;
	vd3 = dim3;
	get_next_token();

	if (token_str[0] != '=')
		error(E_SYNTAX);
	parse_expression(0);
	if (expr_res.type != VT_STRING)
		error(E_SYNTAX);

	set_strvar(varname, expr_res.sval, vd1, vd2, vd3);
}

void start_basic() {
	byte i;

	enable_cursor(FALSE);

	// initialize stacks
	for (i = 0; i < FOR_STACK_SIZE; i++)
		for_stack[i].loop_start = 0;
	for (i = 0; i < IF_STACK_SIZE; i++)
    	if_starts[i] = 0;
	for (i = 0; i < WHILE_STACK_SIZE; i++)
    	while_stack[i] = 0;

	// start
	ip = prog;

	get_next_token();
	while (token != T_EOP && token != T_END && token != T_STOP) {

		// // abort execution on ESC
		// if (io_read(128) == 27) 
		// 	return;

		while ((token == T_LINEEND || token == T_COLON) && token != T_EOP && token != T_END && token != T_STOP)
			get_next_token();

		switch (token) {
			case T_STRVAR:
				assign_strvar();
				break;

			case T_LET:
				get_next_token();
				if (token_type != TT_VARIABLE)
                	error(E_SYNTAX);
				put_back();
				break;

			case T_NUMVAR:
				assign_numvar();
				break;

			case T_DATA:
            	// falls through
			case T_REM:
				next_line();
				break;
				
			case T_PRINT:
				exec_print();
				break;

			case T_INPUT:
            	exec_input();
				break;

			case T_GOTO:
				exec_goto();
				break;

			case T_IF:
            	exec_if();
				break;

			case T_ELSE:
				if (if_pos > 0)
					if_pos--;
				else
                	if_pos = IF_STACK_SIZE - 1;
				if (!if_starts[if_pos])
					error(E_ELSE_WITHOUT_IF);
            	if_starts[if_pos] = 0;

				goto_tokens(T_ENDIF, 0);
				if (token != T_ENDIF)
					error(E_ENDIF_MISSING);
				break;

			case T_ENDIF:
				if (if_pos > 0)
					if_pos--;
				else
                	if_pos = IF_STACK_SIZE - 1;
				if (!if_starts[if_pos])
					error(E_ENDIF_WITHOUT_IF);
            	if_starts[if_pos] = 0;
				break;

			case T_FOR:
				exec_for();
            	break;

			case T_NEXT:
				exec_next();
				break;

			case T_WHILE:
				exec_while();
				break;

			case T_WEND:
				exec_wend();
				break;

			case T_CLS:
				clrscr();
				break;

			case T_GOSUB:
				exec_gosub();
				break;

			case T_RETURN:
				exec_return();
				break;

			case T_READ:
				exec_read();
				break;

			case T_ON:
				exec_on();
				break;

			case T_DIM:
				exec_dim();
				break;

			case T_BEEP:
				// TODO
                //beep();
				break;

			case T_GOTOXY:
            	exec_gotoxy();
				break;

			case T_RESTORE:
				read_pointer = NULL;
				break;

			case T_END:
			case T_STOP:
			case T_INTVAL:
				// do nothing
			case T_EOP:
				// do nothing
				break;

			default:
				error(E_SYNTAX);

		}
		if (token != T_END && token != T_STOP)
			get_next_token();
	}
 }

void __far *malloc_checked(unsigned int size) {
	void __far *result;
//	char s[10];

//	puts_nlb("malloc_checked(");
//	itoa_(size, s);
//	puts_nlb(s);
//	puts(")");

	result = k_malloc(size);
	memset_(result, 0, size);
	if (result == NULL)
		error(E_OUT_OF_MEMORY);
	return result;
}


