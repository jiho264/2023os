; 대문자면 ++, 소문자면 --해서 출력하기. z, Z는 제외.
; A > B
; X > Y
; z > y
code segment
    assume cs:code
init:
    mov ax, code
    mov ds, ax

try:
    mov ah, 1
    int 21h
    
    cmp al, 'Z'
    je try 
    cmp al, 'a'
    je try

    cmp al, 'Z'
    jb case_upper
    cmp al, 'z'
    jbe case_lower

    case_upper:
        mov dx, ax
        inc dx
        jmp exit
    case_lower:
        mov dx, ax
        dec dx
        jmp exit

exit:
    mov ah, 2
    int 21h
    mov ah, 4ch
    int 21h
code ends
end init