main segment
    assume cs:main, ds:data

start:
    mov ax, data
    mov ds, ax
    
    mov al, A
    add al, B
    mov SUM, al

    mov ax, 4C00H
    int 21H
main ends
data segment ; 0584:0020 == 0586:0000. 조금 밑으로 내리면 data segment 찾을 수 있음. a, b, sum을 찾을 수 있음.
    A db 0ffh
    B db 1
    SUM db ?
data ends    

    end start