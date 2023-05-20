; 소문자 > 대문자로 출력.
; 조건 : 소문자만 입력받는단 전제.
CODE SEGMENT
    ASSUME CS:CODE

    MOV AH, 1
    int 21h

    sub al, 32

    MOV Dl, Al
    mov ah, 2
    INT 21h

    MOV AX, 4C00H
    INT 21h
CODE ENDS
END