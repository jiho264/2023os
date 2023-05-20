; find abs
; under 10(dec)
CODE SEGMENT
    ASSUME CS:CODE
    A DW 16
    B DW 20
MAIN:
    MOV AX, A
    MOV BX, B
    CMP AX, BX 
    JAE PRINT ; JUMP IF ABOVE EQUAL

    MOV B, AX
    MOV A, BX
    MOV AX, A
    MOV BX, B
    
PRINT:
    SUB AX, BX ; SAVE RESULT TO AX
    
    MOV DX, AX
    ADD DX, '0'
    MOV AH, 2
    INT 21H

    MOV AH, 4CH
    INT 21H
    
CODE ENDS
    END MAIN
