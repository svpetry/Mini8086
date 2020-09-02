@rem Compiling.
@rem 0:     8088 and 8086 instructions.
@rem d0:    No debugging information.
@rem ms:    The "small" memory model is selected.
@rem s:     Remove stack overflow checks.
@rem wx:    Set the warning level to its maximum setting.
@rem zl:    Suppress generation of library file names and references in object file.
wcc -0 -d0 -ms -s -wx -zl bios0.c

@rem Linking.
@rem FILE:      Specify the object files.
@rem FORMAT:    Specify the format of the executable file.
@rem NAME:      Name for the executable file.
@rem OPTION:    Specify options.
@rem Note startup function (main_) implemented in bios.c.
wlink FILE bios0.obj FORMAT RAW BIN NAME bios0.bin OPTION NODEFAULTLIBS, START=main_
@rem wlink @linkerscript.link
