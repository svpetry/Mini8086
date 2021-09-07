# kernel functions at INT 20h

---
## AH = 00h start process

returns:
- AL: result code (0 = OK)

---
## AH = 01h kill process

- CX:DX process name

returns:
- AL: result code (0 = OK)

---
## AH = 10h list first process

- CX:DX pointer to data structure

returns:
- AL: result code (0 = OK)

---
## AH = 11h list next process

- CX:DX pointer to data structure

returns:
- AL: result code (0 = OK)

---
## AH = 20h allocate memory block
- CX:DX		size in bytes

returns:
- CX:DX pointer to memory block
- AL: result code (0 = OK)

---
## AH = 21h free memory block
- CX:DX pointer to memory block

returns:
- AL: result code (0 = OK)

---
## AH = 22h check free memory

returns:
- CX:DX free memory in bytes
- AL: result code (0 = OK)

# other
## INT 80h	Sleep (finish scheduler time slice)
## INT 81h	Terminate current process
