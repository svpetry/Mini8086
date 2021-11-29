#ifndef VARS_H
#define VARS_H

#include "../../Lib/types.h"
#include "bdefs.h"

extern const struct s_name_token cmd_names[];
extern const struct s_name_token str_func_names[];
extern const struct s_name_token num_func_names[];

extern char __far *prog;

extern char __far *ip;
extern char token_str[MAX_TOKEN_LEN + 1];
extern int token;
extern int token_type;
extern byte token_back;
extern byte print_pos;

extern word dim1;
extern word dim2;
extern word dim3;

extern struct s_expr_res expr_res;

extern struct s_strvar str_vars[MAX_STRING_VARS];
extern int str_var_count;
extern struct s_numvar num_vars[MAX_NUM_VARS];
extern int num_var_count;
extern struct s_strdvar str_dvars[MAX_STRING_DVARS];
extern int str_dvar_count;
extern struct s_numdvar num_dvars[MAX_NUM_DVARS];
extern int num_dvar_count;

extern struct s_label_stack_entry labels[LABEL_STACK_SIZE];
extern int label_count;

extern char *if_starts[IF_STACK_SIZE];
extern byte if_pos;

extern struct s_for_stack_entry for_stack[FOR_STACK_SIZE];
extern byte for_pos;

extern char *while_stack[WHILE_STACK_SIZE];
extern byte while_pos;

extern char *gosub_stack[GOSUB_STACK_SIZE];
extern byte gosub_count;

extern char *read_pointer;

void init_vars();

#endif
