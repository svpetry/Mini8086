#ifndef FILESYSTEM_H
#define FILESYSTEM_H

#include "../../Lib/bios_fs.h"

extern char current_path[MAX_PATH];

byte handle_file_param(char *filepath, dword *size);

void list_directory();
void rename();
void delete();
void change_directory();

#endif