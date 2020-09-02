CPU 8086
ORG 0xF0000

    XOR AX, AX
    MOV SS, AX
    MOV DS, AX
    MOV ES, AX
    MOV AX, 0xFFFF
    MOV SP, AX

    ; write to PPI control port
    MOV AL, 0x80
    OUT 0x0E, AL

    ; set all port bits to 0
    XOR AL, AL
    OUT 0x08, AL
    OUT 0x0A, AL
    OUT 0x0C, AL




;     MOV BYTE [0xFFFF], 0x00
; @loop:
;     MOV CX, 0x2000
; @delay:
;     NOP
;     NOP
;     LOOP @delay

;     MOV AL, [0xFFFF]
;     OUT 0x08, AL

;     INC BYTE [0xFFFF]
;     JMP @loop
