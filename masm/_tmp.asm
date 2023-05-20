code SEGMENT
    ASSUME cs:code
    mov ax, code
    mov dx, ax

    mov ah, 1
    int 21H

    inc AX
    mov DX, AX
    mov ah, 2
    int 21H

    mov ax, 4C00H
    int 21H
code ENDS
end