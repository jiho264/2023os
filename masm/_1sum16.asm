;
; hex adder
; attention carry flag
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    MOV AX, DATA
    MOV DS, AX

    MOV AX, 1223H
    MOV BX, 8000H
    MOV CX, 2000H
    MOV DX, 8213H
    
    ADD BX, DX
    ADC AX, CX ; ADD + Carry
    
    MOV VAR1, AX
    MOV VAR2, BX

    MOV AH, 4CH
    INT 21H
CODE ENDS
DATA SEGMENT
    VAR1 DW ?
    VAR2 DW ?
DATA ENDS
    END
