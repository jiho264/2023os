CODE SEGMENT
    ASSUME CS:CODE, DS:CODE
INIT:
    MOV AX, CS
    MOV DS, AX

    mov dx, 0
    mov ax, var1
    ; ax = 0007
    mov bx, 2
    div bx
    ;mov dx, AX

    add dx, '0'
    mov ah, 2
    int 21h

    MOV AX, 4C00H
    INT 21H

    VAR1 DW 7
CODE ENDS
    END INIT