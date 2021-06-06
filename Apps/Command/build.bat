@echo off
if exist c:\windows\sysnative\wsl.exe (
	c:\windows\sysnative\wsl ./build.sh
) else (
	wsl ./build.sh
)

..\..\Tools\PrepExec\bin\Release\PrepExec bin\command.raw bin\command.bin 8 0 1

pause