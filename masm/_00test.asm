CODE SEGMENT
    ASSUME CS:CODE, DS:CODE
INIT:
    MOV AX, CS
    MOV DS, AX


    xor ax, ax
    xor dx, dx

    mov al, var1
    
    mov bl, 2
    div bl
    

    mov dl, al
    
    add dl, '0'
    mov ah, 2
    int 21h

    MOV AX, 4C00H
    INT 21H

    VAR1 DB 7
CODE ENDS
    END INIT