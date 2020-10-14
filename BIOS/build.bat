nasm -f bin src\resetvector.asm -o resetvector.bin

copy src\*.h dosbox\local /b /v /y
copy src\*.c dosbox\local /b /v /y
copy src\*.S dosbox\local /b /v /y
copy src\*.LD dosbox\local /b /v /y

DOSBox.exe dosbox\setup.bat
copy dosbox\local\b.bin . /b /v /y

del ROM?.bin
BiosBuilder
@if not exist ROM0.bin pause
