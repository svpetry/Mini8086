#ifndef MYBASIC_H
#define MYBASIC_H

#include "../../Lib/types.h"
#include "vars.h"
#include "basic_helpers.h"

void load_program(char *file_name);
void error(byte errno);
void next_line(void);
void set_strvar(char *varname, char *value, int vd1, int vd2, int vd3);
void set_numvar(char *varname, struct s_num *value, int vd1, int vd2, int vd3);
void get_next_token(void);
void get_numvar(char *varname, struct s_num *result);
void get_strvar(char *varname, char *result, int *l);
void put_back(void);
void put_back_undo(void);
void assign_numvar(void);
void assign_strvar(void);
void start_basic(void);
void __far *malloc_checked(unsigned int size);

#endif
