#include "handleint.h"
#include "scheduler.h"
#include "kmalloc.h"
#include "../../Lib/types.h"
#include "../../Lib/kernel_defs.h"
#include "../../Lib/strutils.h"
#include "../../Lib/bios_fs.h"

volatile word int_sp_save;
volatile word int_ss_save;

volatile word int_ax;
volatile word int_cx;
volatile word int_dx;

int process_index;

static void strcpy_far(char __far *dest, const char __far *src) {
    char __far *temp = dest;
    while (*dest++ = *src++) ;
}

static void strcpy_far_to_near(char *dest, const char __far *src) {
    char *temp = dest;
    while (*dest++ = *src++) ;
}

void int_kernel() {
    byte status = 0;
    switch (int_ax >> 8) {
        // start process
        case 0x00: {
            char __far *far_path = (char __far *)((((dword)int_dx) << 16) + int_cx);
            char path[MAX_PATH];
            int pid;
            PROC_TYPE ptype;
            strcpy_far_to_near(path, far_path);
            status = new_process(path, &pid, &ptype);
            int_cx = pid;
            int_dx = ptype;
            break;
        }

        // terminate process
        case 0x01:
            status = terminate_process(int_cx);
            break;

        // check if process exists
        case 0x02: {
            status = 1;
            int pid = int_cx;
            int i = 0;
            while (i < process_count) {
                if (processes[i]->id == pid) {
                    status = 0;
                    break;
                }
                i++;
            }
            break;
        }

        // list process
        case 0x10: {
            proc_info_ext __far *procinfo = (proc_info_ext __far *)((((dword)int_dx) << 16) + int_cx);
            if ((int_ax & 0xFF) == 0x01)
                process_index = 0;
            else
                process_index++;
            
            if (process_index < process_count) {
                processinfo __far *pi = processes[process_index];
                procinfo->id = pi->id;
                strcpy_far(procinfo->name, pi->name);
                procinfo->priority = pi->priority;
                procinfo->size = ((dword)pi->size) << 4;
            } else {
                procinfo->id = 0;
                procinfo->name[0] = 0;
                procinfo->priority = 0;
                procinfo->size = 0;
            }
            break;
        }

        // allocate memory block
        case 0x20: {
            dword size = (((dword)int_dx) << 16) + int_cx;
            if (size >= 64ul * 1024 - 16) {
                int_cx = 0;
                int_dx = 0;
                status = 1;
                break;
            }            
            void __far *memptr = malloc_(size);
            if (memptr == NULL) status = 1;
            dword memaddr = (dword)memptr;
            int_dx = memaddr >> 16;
            int_cx = memaddr;           
            break;
        }

        // free memory block
        case 0x21: {
            dword memaddr = (((dword)int_dx) << 16) + int_cx;
            free_((void __far *)memaddr);
            break;
        }

        // check free memory
        case 0x22: {
            dword free_ram = malloc_free_ram();
            int_dx = free_ram >> 16;
            int_cx = free_ram;
            break;
        }
    }
    int_ax = status;
}