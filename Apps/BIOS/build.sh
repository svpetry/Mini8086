timestamp=$(date "+%Y%m%d.%H%M%S")
echo '#define BUILD "'$timestamp'"' > ./src/build.h

ia16-elf-gcc -Os -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=small -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -T ./src/BIOS.LD -o ./bin/b.bin \
    ./src/bios.c ./src/io.c ./src/boot.c ./src/start.c \
    ./src/ff.c ./src/diskio.c ./src/biosfunc.c ./src/sd.c ./src/keyboard.c ./src/keylayouts.c \
    ./src/filebrowser.c ./src/biossetup.c \
    ../Lib/lowlevel.c ../Lib/strutils.c ../Lib/utils.c ../Lib/i2c.c ../Lib/eeprom.c ../Lib/ds1307.c \
    ../Lib/screen.c ../Lib/lcd.c ../Lib/bmp280.c
rm crt0.o