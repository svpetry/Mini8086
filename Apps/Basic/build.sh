ia16-elf-gcc -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=tiny -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -T ./src/APP.LD -o ./bin/basic.raw \
    ./src/basic.c ./src/basic_helpers.c ./src/utils.c ./src/ftoa.c ./src/mybasic.c ./src/vars.c \
    ../Lib/strutils.c ../Lib/utils.c ../Lib/app_utils.c ../Lib/kernel.c ../Lib/strutils_far.c \
    ../Lib/bios_screen.c ../Lib/bios_misc.c ../Lib/bios_fs.c ../Lib/bios_screen_far.c \
    ../Lib/debug.c ../Lib/file_buffer.c

rm crt0.o
