ia16-elf-gcc -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=tiny -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -T ./src/APP.LD -o ./bin/lcdclock.raw \
    ./src/lcdclock.c \
    ../Lib/strutils.c ../Lib/lowlevel.c ../Lib/kernel.c \
    ../Lib/lcd.c ../Lib/bios_time.c

rm crt0.o
