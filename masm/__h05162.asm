; input str 역순 출력하기
code segment
    assume cs:code, ds:data
init:
    mov ax, data
    mov ds, ax
    xor cx, cx

try: 
    mov ah, 1
    int 21h
    cmp al, 20H ; space bar == terminate
    je print_str

    push ax
    inc cx
    jmp try

print_str:
    pop dx
    mov ah, 2
    int 21h
    loop print_str

exit:
    mov ah, 4ch
    int 21h
code ends
data segment
data ends
end init