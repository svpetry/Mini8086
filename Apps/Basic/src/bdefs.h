#ifndef BDEFS_H
#define BDEFS_H

#include "../../Lib/types.h"

#undef _DEBUG

#define MAX_STRING_VARS		40
#define MAX_NUM_VARS		40
#define MAX_STRING_DVARS	20
#define MAX_NUM_DVARS		20
#define MAX_STRING_LEN		200
#define MAX_TOKEN_LEN		127
#define MAX_VAR_NAME_LEN	5
#define MAX_NUMSTR_LEN		12
#define FOR_STACK_SIZE		10
#define GOSUB_STACK_SIZE	10
#define LABEL_STACK_SIZE	2000 // don't modify!
#define IF_STACK_SIZE		10
#define WHILE_STACK_SIZE	10
#define MAX_PROG_FILE_SIZE	32768

// Tokens ----------------------------------------------------------------------

// basic commands
#define T_PRINT		1
#define T_INPUT		2
#define T_IF		3
#define T_THEN		4
#define T_ELSE		5
#define T_ENDIF		6
#define T_CLS		7
#define T_FOR		8
#define T_TO		9
#define T_NEXT		10
#define T_LET		11
#define T_GOTO		12
#define T_GOSUB		13
#define T_RETURN	14
#define T_END		15
#define T_DIM		16
#define T_READ		17
#define T_DATA		18
#define T_GOTOXY	19
#define T_ON		20
#define T_STEP		21
#define T_WHILE		22
#define T_WEND		23
#define T_STOP		24
#define T_BEEP		25
#define T_RESTORE	26

// string functions
#define T_MID		100
#define T_LEFT		101
#define T_RIGHT		102
#define T_TAB		103
#define T_STR		104
#define T_CHR		105
#define T_UPPER		106

// numeric/math functions
#define T_LEN		150
#define T_RND		151
#define T_INT		152
#define T_VAL		153
#define T_SIN		154
#define T_COS		155
#define T_ABS		156
#define T_SQR		157
#define T_ASC		158
#define T_TAN		159
#define T_LOG		160
#define T_INSTR		161
#define T_EXP		162

// other
#define T_REM		180

// special
#define T_NUMVAR	200
#define T_STRVAR	201
#define T_INTVAL	202
#define T_FLOATVAL	203
#define T_STRVAL	204
#define T_LINEEND	205
#define T_EOP		206
#define T_SPECIAL	207
#define T_COLON		208
#define T_AND		209
#define T_OR		210

/*----------------------------------------------------------------------------*/
// token types

#define TT_COMMAND	1
#define TT_STRFUNC	2
#define TT_NUMFUNC	3
#define TT_VALUE	4
#define TT_VARIABLE 5
#define TT_SPECIAL	6
#define TT_LOGIC_OP	7

/*----------------------------------------------------------------------------*/
// value types

#define VT_STRING	1
#define VT_INT      2
#define VT_FLOAT	3
#define VT_BOOL		4

/*----------------------------------------------------------------------------*/
// errors

#define E_SYNTAX				1
#define E_STR_TOO_LONG			2
#define E_TOKEN_TOO_LONG		3
#define E_VARNAME_TOO_LONG		4
#define E_DIVZERO				5
#define E_TOO_MANY_VARS			6
#define E_LBL_NOT_FOUND			7
#define E_STACK_OVERFLOW		8
#define E_ENDIF_WITHOUT_IF		9
#define E_ELSE_WITHOUT_IF		10
#define E_ENDIF_MISSING			11
#define E_LABEL_ORDER			12
#define E_NEXT_WITHOUT_FOR		13
#define E_WEND_WITHOUT_WHILE	14
#define E_RETURN_WITHOUT_GOSUB	15
#define E_NO_DATA				16
#define E_WRONG_VALUE			17
#define E_INTEXP				18
#define E_STREXP				19
#define E_DIMVAR_KNOWN			20
#define E_OUT_OF_MEMORY			21
#define E_VAR_DIM_ERROR			22
#define E_OUT_OF_RANGE			23

/******************************************************************************/

struct s_name_token {
	char name[10];
	byte token;
};

struct s_num {
	long ival;
	float fval;
	byte isint;
};

struct s_expr_res {
	char sval[MAX_STRING_LEN + 1];
	long ival;
	float fval;
	byte type;
};

struct s_strvar {
	char name[MAX_VAR_NAME_LEN + 1];
	char __far *value;
	byte maxlen;
};

struct s_numvar {
	char name[MAX_VAR_NAME_LEN + 1];
	struct s_num value;
};

struct s_strdvar {
	char name[MAX_VAR_NAME_LEN + 1];
	byte len_dim1;
	byte len_dim2;
	byte len_dim3;
	char __far **data;
};

struct s_numdvar {
	char name[MAX_VAR_NAME_LEN + 1];
	byte len_dim1;
	byte len_dim2;
	byte len_dim3;
	struct s_num *data; 
};

struct s_label_stack_entry { // size: 4 bytes
	char __far *pos;
	int label;
};

struct s_for_stack_entry {
	struct s_num *var;
	struct s_num end_value;
	struct s_num step;
	char *loop_start;
};

/******************************************************************************/

#endif
