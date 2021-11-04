ia16-elf-gcc -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=tiny -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -T ./src/APP.LD -o ./bin/command.raw \
    ./src/command.c ./src/cmdline.c ./src/filesystem.c ./src/misc.c ./src/time.c ./src/utils.c \
    ./src/kernel.c ./src/applauncher.c \
    ../Lib/strutils.c ../Lib/utils.c ../Lib/lowlevel.c \
    ../Lib/bios_screen.c ../Lib/bios_misc.c ../Lib/bios_fs.c ../Lib/kernel.c

rm crt0.o
