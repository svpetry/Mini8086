
# BIOS function at INT 10h

## SCREEN

---
**AH = 00h**	Clear screen

---
**AH = 01h**	Set cursor position

- DL: column
- DH: row

---
**AH = 02h**	Scroll down

- AL: lines to scroll

---
**AH = 03h**	Scroll up

- AL: lines to scroll

---
**AH = 04h**	Write character at cursor position

- AL: character code

---
**AH = 05h**	Read character from cursor position

returns:
- AL: character code

---
**AH = 06h**	Write string at cursor position

- DX:CX: pointer to string

---
**AH = 07h**	Outputs a text on the screen

- DL: column
- DH: row
- CL: color
- SI:DI: pointer to string

---
**AH = 08h**	Show or hide the cursor

- AL: 0 = cursor disabled, 1 = cursor enabled

---
**AH = 09h**	Set text color.

- AL: text color

---
**AH = 0Ah**	Set background color

- AL: background color

---

## KEYBOARD

---
**AH = 10h**	Read keycode from keyboard

returns:
- AL: keycode

---

## OTHER

---
**AH = 11**		Read current ticks

return:
- AL: ticks (0-19)

---
**AH = 12**		Read date and time

- AL: 0 = time only, 1 = date & time

return:
- AL: seconds
- AH: minutes
- CL: hours
- CH: day
- DL: month
- DH: year

---
**AH = 13**		Set time

- CL: seconds
- CH: minutes
- DL: hours

---
**AH = 14**		Set date

- CL: day
- CH: month
- DL: year

---

## FILE SYSTEM

---
**AH = 20h**	Read volume name

- DX:CX: pointer to destination string

returns:
- AL: 0 = OK, 1 = error

---
**AH = 21h**	Open file

AL: mode
- 0 = read
- 1 = write
- 2 = append

- DX:CX: pointer to file name

returns:
- AL: 0 = OK, 1 = error
- AH: file handle

---
**AH = 22h**	Close file

- AL: file handle

---
**AH = 23h**	Get file info

- DX:CX: file name

returns:
- AL: 0 = OK, 1 = file does not exist
- AH: attributes
- DX:CX: file size in bytes (32 bit)
- SI: file date
	- 15:9 - year difference to 1980
	- 8:5 - month
	- 4:0 - day
- DI: file time
	- 15:11 - hour
	- 10:5 - minute
	- 4:0 - second / 2
	
---
**AH = 24h**	Seek

- AL: file handle
- DX:CX: position

returns:
- AL: 0 = OK, 1 = error

---
**AH = 25h**	Rename file

- DX:CX: old filename
- SI:DI: new filename

returns:
- AL: 0 = OK, 1 = error

---
**AH = 26h**	Read data

AL: file handle
- DX:CX: pointer to buffer
- SI: number of bytes to read
- DI: actual number of bytes read

returns:
- AL: 0 = OK, 1 = error

---
**AH = 27h**	Write data

- AL: file handle
- DX:CX: pointer to buffer
- SI: number of bytes to write
- DI: actual number of bytes written

returns:
- AL: 0 = OK, 1 = error

---
**AH = 28h**	Open directory

- DX:CX: path

returns:
- AL: 0 = OK, 1 = error
- AH: directory handle

---
**AH = 29h**	Close directory

- AL: directory handle

returns:
- AL: 0 = OK, 1 = error

---
**AH = 2Ah**	Read next directory entry

- AL: directory handle
- DX:CX: pointer to destination string

Returns a null string if all entries have been read.

returns:
- AL: 0 = OK, 1 = error

---
**AH = 2Bh**	Create directory

- AL: directory handle

returns:
- AL: 0 = OK, 1 = error

---
**AH = 2Ch**	Delete file or directory

- DX:CX: file name

returns:
- AL: 0 = OK, 1 = error

# TODO
- read/write date & time
