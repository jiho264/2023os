code segment
    assume cs:code, ds:code
    org 100h
CR EQU 0dh
LF EQU 0aH

init:
    mov ax, cs
    mov ds, ax
    mov bx, 0
    jmp start

start:
    ; table == dw variable
    ; index +2 = next index
    mov dx, table[bx] ; print target
    mov ah, 9h ; print string
    int 21H

    inc bx
    inc bx
    cmp bx, 5*2
    jb start

stop:
    mov ax, 4C00H   
    int 21H

m1 db 'message 1','$'
m2 db ' message 2','$'
m3 db '  message 3','$'
m4 db '   message 4','$'
m5 db '    message 5','$'

table dw offset m1, offset m2, offset m3, offset m4, offset m5

code ends
    end init


; code segment
;     assume cs:code, ds:code
;     org 100h

; start:
;     mov ax, cs
;     mov ds, ax

;     mov bx, 1

;     mov dx, table[bx] ; print target
;     mov ah, 9h ; print string
;     int 21H

; stop:
;     mov ax, 4C00H   
;     int 21H

; m1 db 'message 1','$'
; m2 db ' message 2','$'
; m3 db '  message 3','$'
; m4 db '   message 4','$'
; m5 db '    message 5','$'

; table dw offset m1, offset m2, offset m3, offset m4, offset m5

; code ends
;     end start


