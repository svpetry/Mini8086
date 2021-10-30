# kernel functions at INT 20h

---
## AH = 00h start process

returns:
- AL: result code (0 = OK)
- CX: process id

---
## AH = 01h kill process

- CX: process id

returns:
- AL: result code (0 = OK)

---
## AH = 10h list process

- AL: 1 = first process, 0 = next process
- DX:CX pointer to data structure

returns:
- AL: result code (0 = OK)

---
## AH = 20h allocate memory block
- DX:CX		size in bytes

returns:
- DX:CX pointer to memory block
- AL: result code (0 = OK)

---
## AH = 21h free memory block
- DX:CX pointer to memory block

returns:
- AL: result code (0 = OK)

---
## AH = 22h check free memory

returns:
- DX:CX free memory in bytes
- AL: result code (0 = OK)

# other
## INT 80h	Sleep (finish scheduler time slice)
## INT 81h	Terminate current process
