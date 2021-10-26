#ifndef FILESYSTEM_H
#define FILESYSTEM_H

#include "../../Lib/types.h"
#include "../../Lib/bios_fs.h"

extern char current_path[MAX_PATH];

byte handle_file_param(char *filepath, byte index, dword *size, byte docheck);

void list_directory();
void rename();
void delete();
void change_directory();
void create_directory();
void remove_directory();

#endif