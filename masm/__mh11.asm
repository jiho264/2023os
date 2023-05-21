; 메모리에 저장된 문자가 대문자인지, 소문자인지, 숫자인지 구분하기.
code segment
    assume cs:code, ds:data
init:
    mov ax, data
    mov ds, ax

    mov al, var

    cmp al, '9'
    jbe case_number
    cmp al, 'Z'
    jbe case_upper
    cmp al, 'z'
    jbe case_lower

    case_number:
        mov dx, offset str_num
        jmp exit
    case_upper:
        mov dx, offset str_upper
        jmp exit
    case_lower:
        mov dx, offset str_lower
        jmp exit

exit:
    mov ah, 9
    int 21h
    mov ah, 4ch
    int 21h
code ends
data segment
    var db 'z'
    str_upper db ' is upper$'
    str_lower db ' is lower$'
    str_num db ' is number$'
data ends
end init