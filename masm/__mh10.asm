; 연속되는 문자를 입력받아 대문자/소문자 개수 구하기/ 변환하기
; 전제조건 : 모든 입력은 알파벳
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
PRINT_ANS:
    MOV AX, Bx
    MOV BL, 10
    DIV BL
    MOV NUM10, AL
    MOV NUM1, AH
    MOV DX, OFFSET NUM10

    cmp num10, 0
    jne EXIT

    MOV DX, OFFSET NUM1
    EXIT: ; CONVERT TO ASCII CODE
        ADD NUM10, '0'
        ADD NUM1, '0'
        MOV AH, 9
        INT 21H
    RET
COUNTER:
    CMP AL, 20H ; SPACE BAR
    JE TERMINATE
    CMP AL, 'a'
    JAE LOWER
    UPPER:
        INC CNT_H
        MOV DL, AL
        ADD DL, 20H
        MOV AH, 2
        INT 21H
        RET
    LOWER:
        INC CNT_L
        MOV DL, AL
        SUB DL, 20H
        MOV AH, 2
        INT 21H
        RET

INIT:
    MOV AX, DATA
    MOV DS, AX

    INPUT:
        MOV AH, 1
        INT 21H

        CALL COUNTER
    JMP INPUT

TERMINATE:
    MOV Bl, CNT_H
    CALL PRINT_ANS
    MOV Bl, CNT_L
    CALL PRINT_ANS

    MOV AX, 4C00H
    INT 21H
CODE ENDS
DATA SEGMENT
    CNT_H DB 0
    CNT_L DB 0
    NUM10 Db ?
    NUM1 Db ?
    THEEND DB 0dh, 0ah, '$'
DATA ENDS
END INIT