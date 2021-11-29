#ifndef BASIC_HELPERS_H
#define BASIC_HELPERS_H

#include "../../Lib/types.h"
#include "vars.h"
#include "mybasic.h"

void print_error_text(byte errno);
byte find_command(char *s);
byte find_str_func(char *s);
byte find_num_func(char *s);
void goto_tokens(byte t1, byte t2);
void exec_print(void);
void exec_input(void);
void exec_if(void);
void exec_goto(void);
void exec_for(void);
void exec_next(void);
void exec_while(void);
void exec_wend(void);
void exec_gosub(void);
void exec_return(void);
void exec_read(void);
void exec_on(void);
void exec_dim(void);
void exec_gotoxy(void);
void eval_strfunc(char *result, int *l);
void str2num(char *str, struct s_num *value);
void eval_numfunc(struct s_num *result);
void unify(struct s_num *a, struct s_num *b);
void parse_num_3(struct s_num *a, byte eval_bool);
void parse_num_2(struct s_num *a, byte eval_bool);
void parse_num_1(struct s_num *a, byte eval_bool);
void parse_num_expr(struct s_num *a, byte eval_bool);
void parse_str_expr(void);
void parse_expression(byte eval_bool);
byte eval_bool_1(void);
byte eval_bool_expr(void);
char __far *get_label(int lbl);
void read_dimensions(void);
struct s_num *find_numvar(char *varname);

#endif // _BASIC_HELPERS_H
