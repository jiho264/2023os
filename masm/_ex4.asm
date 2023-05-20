code segment
    assume cs:code

    mov ah, 15
    int 10h ; get video state
    mov si, bx

    mov ax, 060ah ; al = number of line to scroll 070ah면 down
    mov bh, 1fh ; bh = attribute to be used on blank line
    mov cx, 0814h ; scroll (ch, cl) - (dh, dl)
    mov dx, 113bh ; = scroll (14h, 8h) - (3bh, 11h)
    int 10h

move:
    mov bx, si ; bh = paga number
    mov ah, 02h
    mov dx, 1114h ; dh = row, dl = column
    int 10h ; set position 14h, 11h

code ends

end
