;
; var1 16bit
; H 8bit + L 8bit
; add >> save to var2 8bit
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

    MOV AX, DATA ; AX = 0586
    MOV DS, AX ; DS = 0586

    MOV BX, OFFSET VAR1 ; VAR1 address.. == 0586:0000

    MOV AH, [BX]
    MOV AL, [BX + 1]
    
    ADD AH, AL
    MOV VAR2, AX

    MOV AX, 4C00H
    INT 21H
CODE ENDS
DATA SEGMENT
    VAR1 DW 1234H
    VAR2 DW ?
DATA ENDS
    END