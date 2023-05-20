; scroll up
.model small
.stack 100h
.code 
main proc 
    mov dx, offset mesg
    mov ah, 9h
    int 21H ; print mesg string
    
    mov ah, 1
    int 21H
    sub al, '0' ; key input

    mov ah, 06h
    ; 06h : up
    ; 07h : down
    ; AL == SCROLL SCALA
    mov bh, 7 ; bh : attribute to use on blaked lines
    mov cx, 0000h 
    ; ch : top row of scroll window
    ; cl : left column of scroll window
    mov dx, 194fh
    ; dh : bottom row of scroll window
    int 10h

stop:
    mov ax, 4C00H
    int 21H

mesg db "line number for scrolling : $"
main endp
end main
