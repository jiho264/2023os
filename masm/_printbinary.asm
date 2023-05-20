title display

dosseg
.model small
.stack 100H

.code 
main proc
    mov al, 6ch ; 0110 1100 b
    mov cx, 8

l1:
    shl al, 1 ; 1101 1000 b 
    mov dl, '0'
    jnc l2 ; not carry.
    mov dl, '1'
l2:
    push ax
    mov ah, 2
    int 21h
    pop ax
    loop l1

    mov ah, 4ch
    int 21h

; shift left 1 && print 반복하면, 최상위비트부터 출력됨.
main endp
    end main