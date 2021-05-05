timestamp=$(date "+%Y%m%d.%H%M%S")
echo '#define BUILD "'$timestamp'"' > ./src/build.h

ia16-elf-gcc -Os -c -o crt0.o ./src/CRT0.S
ia16-elf-gcc -Os -mcmodel=small -fno-jump-tables -nostartfiles \
    -mtune=i8086 -mno-segment-relocation-stuff -mfar-function-if-far-return-type -T ./src/APP.LD -o ./bin/kernel.bin \
    ./src/kernel.c ./src/malloc.c ./src/scheduler.c \
    ../Lib/lowlevel.c ../Lib/strutils.c ../Lib/utils.c ../Lib/bios_screen.c ../Lib/bios_misc.c
rm crt0.o

# ia16-elf-gcc -Os -mcmodel=small -fno-jump-tables -nostartfiles \
#     -mtune=i8086 -mno-segment-relocation-stuff -T ./src/APP.LD -o ./bin/kernel.bin \
#     ./src/kernel.c ./src/malloc.c ./src/scheduler.c \
#     ../Lib/lowlevel.c ../Lib/strutils.c ../Lib/utils.c ../Lib/bios_screen.c ../Lib/bios_misc.c
