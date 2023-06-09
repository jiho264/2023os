CODE SEGMENT
    ASSUME CS:CODE
NEXT: 
    MOV AH, 1 ; INPUT : CHAR 1
    INT 21H ; SYSTEM CALL 21H-1 == READ

    CMP AL, 'X' ; IF AL == 'X' > JE == TRUE
    JE TERMINATE ; IF == >> JUMP ~~
    CMP AL, 'x'
    JE TERMINATE
    
    MOV DL, AL
    INC DL ; DL++
    MOV AH, 2 ; OUTPUT : CHAR 1
    INT 21H ; SYSTEM CALL 21H-2 == WRITE

    JMP NEXT ; GO TO NEXT
    
TERMINATE:
    MOV AH, 4CH ; AL == SYSTEM RETURN VALUE
    INT 21H ; SYSTEM CALL 21H-4C == TERMINATE
CODE ENDS
END

; 가장 어려운 응용문제 : 대문자면 ++, 소문자면 --해서 출력하기. z, Z는 제외

; TEST >> and operator