;
; var1(H), var2(L) 32bit 
; var3(H), var4(L) 32bit 
; add >> var1(H), var2(L) 
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    MOV AX, DATA
    MOV DS, AX

    MOV AX, VAR1
    MOV BX, VAR2
    MOV CX, VAR3
    MOV DX, VAR4
    
    ADD BX, DX
    ADC AX, CX ; ADD + Carry

    MOV VAR1, AX
    MOV VAR2, BX

    MOV AX, 4C00H
    INT 21H
CODE ENDS
DATA SEGMENT
    VAR1 DW 1223H
    VAR2 DW 8000H
    VAR3 DW 2000H
    VAR4 DW 8213H
DATA ENDS
    END
