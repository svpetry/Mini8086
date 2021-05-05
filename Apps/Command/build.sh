ia16-elf-gcc -Os -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=small -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -T ./src/APP.LD -o ./bin/command.bin \
    ./src/command.c \
    ../Lib/lowlevel.c ../Lib/strutils.c ../Lib/utils.c ../Lib/i2c.c ../Lib/eeprom.c ../Lib/bmp280.c \
    ../Lib/ds1307.c ../Lib/bios_screen.c ../Lib/bios_misc.c
rm crt0.o
