nasm -f bin src\resetvector.asm -o resetvector.bin

copy src\*.h dosbox\local /b /v /y
copy src\*.c dosbox\local /b /v /y
copy src\*.S dosbox\local /b /v /y

DOSBox.exe dosbox\setup.bat
copy dosbox\local\bios0.bin . /b /v /y

BiosBuilder
pause