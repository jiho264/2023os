;
; var1 16bit
; H 8bit + L 8bit
; add >> save to var2 8bit
DATA SEGMENT
    VAR1 DW 1234H
    VAR2 DW ?
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    MOV AX, DATA ; AX = 0584
    MOV DS, AX ; DS = 0584

    MOV BX, 0000H ; VAR1 address

    MOV AH, BYTE PTR [BX + 0]
    MOV AL, BYTE PTR [BX + 1]
    
    ADD AH, AL
    MOV VAR2, AX

    MOV AX, 4C00H
    INT 21H
CODE ENDS
    END