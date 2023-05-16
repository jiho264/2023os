.model small
.stack 100h
.data  
    prompt db 'enter a lower case letter : $'
    msg db 0Dh, 0Ah, 'in upper case it is : '
    char db ?, '$'
.code 
main proc
    mov ax, @data                               ; get data segement
    mov ds, ax

    mov dx, offset prompt                       ; 'enter a lower case letter : '를 출력
    mov ah, 9
    int 21h                                     ; display prompt

    mov ah, 1
    int 21h                                     ; char in AL

    sub al, 20h                                 ; converts to upper case (16진수 20 -> 10진수 32 -> 'a'-32 = 'A')
    mov char, al                                ; store char

    mov dx, offset msg
    mov ah, 9
    int 21h                                     ; final message display 

    mov ah, 4ch
    int 21h 

main endp
end main