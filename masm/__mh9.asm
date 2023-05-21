; find min, max number








; todo find max+min









main segment
    assume cs:main, ds:main
init:
    mov ax, cs
    mov ds, ax

    mov di, offset arr ; any index register
    mov ax, [di]
    
    mov min, ax
    mov max, ax
    ;add dl, 2
    mov cx, 7 ; loop length

A1:
    mov ax, [di]
    cmp ax, min
    jge A2
    mov min, ax

A2: 
    cmp ax, max
    jle A3
    mov max, ax

A3:
    add di, 2 ; word array
    loop A1 ; loop 6 time

print:
    mov dx, min
    add dx, '0'
    mov ah, 2
    int 21H
    mov dx, max
    add dx, '0'
    mov ah, 2
    int 21H

    mov ah, 4ch
    int 21h
min dw ?
max dw ?
arr dw 3, 7, 4, 5, 2, 1, 8

main ends
    end init