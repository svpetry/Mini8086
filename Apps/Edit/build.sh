ia16-elf-gcc -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=tiny -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -T ./src/APP.LD -o ./bin/edit.raw \
    ./src/edit.c \
    ../Lib/strutils.c ../Lib/utils.c ../Lib/app_params.c \
    ../Lib/bios_screen.c ../Lib/bios_misc.c ../Lib/bios_fs.c

rm crt0.o
