; 문자 하나 입력받아서 대/소문자 구분하고, 바꿔 출력하기
CODE SEGMENT
    ASSUME CS:CODE

INIT:
    MOV AX, CODE
    MOV DS, AX

    MOV AH, 1
    INT 21H
    ; AL == ALPHABET

    CMP AL, 'a'
    JAE L1

    ADD AL, 20H
    JMP L2
L1:
    SUB AL, 20H
L2:
    MOV DL, AL
    MOV AH, 2
    INT 21H
    MOV AX, 4C00H
    INT 21H
CODE ENDS
END