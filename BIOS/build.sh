ia16-elf-gcc -Os -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=small -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -T ./src/BIOS.LD -o ./bin/b.bin \
    ./src/bios.c ./src/io.c ./src/strutils.c ./src/boot.c ./src/start.c ./src/lowlevel.c ./src/biosfunc.c \
    ./src/utils.c ./src/screen.c ./src/lcd.c ./src/sd.c \
    ./src/ff.c ./src/diskio.c
rm crt0.o