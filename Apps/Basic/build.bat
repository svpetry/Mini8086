@echo off
if exist c:\windows\sysnative\wsl.exe (
	c:\windows\sysnative\wsl ./build.sh
) else (
	wsl ./build.sh
)

REM PrepExec [input file] [output file] [size in KB] [process type] [priority]
..\..\Tools\PrepExec\bin\Release\PrepExec bin\basic.raw bin\basic.bin 64 0 1

pause