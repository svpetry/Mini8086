timestamp=$(date "+%Y%m%d.%H%M%S")
echo '#define BUILD "'$timestamp'"' > ./src/build.h

ia16-elf-gcc -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -O2 -mcmodel=tiny -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -mfar-function-if-far-return-type -fno-inline -T ./src/APP.LD -o ./bin/kernel.bin \
    ./src/kernel.c ./src/kmalloc.c ./src/scheduler.c ./src/kutils.c ./src/handleint.c \
    ../Lib/lowlevel.c ../Lib/strutils.c ../Lib/utils.c ../Lib/bios_screen.c ../Lib/bios_fs.c \
    ../Lib/crc8.c ../Lib/bios_time.c
rm crt0.o
