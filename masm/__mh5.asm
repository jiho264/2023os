; 99단 상수
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
PRINT_ANS:
    ; ans DW 17(10)
    ;       11H
    CMP ANS, 10
    JB UNDER10
    UPPER10: ; IF ANS >= 10
        MOV AX, ANS
        MOV BL, 10
        DIV BL
        MOV NUM10, AL
        MOV NUM1, AH
        MOV DX, OFFSET NUM10
        JMP EXIT
    UNDER10: ; if ans < 10
        MOV AX, ANS
        MOV NUM1, AL
        MOV DX, OFFSET NUM1
    EXIT: ; convert to ascii code
        ADD NUM10, '0'
        ADD NUM1, '0'
        MOV AH, 9
        INT 21H
    RET

STR_PRINT:
    ADD A, '0' ; CONVERT to ASCII CODE
    ADD B, '0'
    MOV DX, OFFSET A ; PRINT START ADDRESS
    MOV AH, 9
    INT 21H ; PRINT 
    INC B ; INCREMENT
    SUB A, '0'
    SUB B, '0'
    CALL PRINT_ANS ; PRINT ANS
    RET
INIT:
    MOV AX, DATA ; INIT DATA SEGMENT ADDRESS
    MOV DS, AX
    MOV CX, 9 ; SET LOOP LENGTH
NUM:
    MOV AL, A 
    MUL B
    MOV ANS, AX ; ANS = A * B
    
    CALL STR_PRINT ; PRINT
    LOOP NUM ; TABLE LOOP

    MOV AH, 4CH ; TERMINATE
    INT 21H
CODE ENDS
DATA SEGMENT
    A DB 9
    STAR DB ' * '
    B DB 1
    RESULT DB ' = $'
    ANS DW ?
    NUM10 DB ?
    NUM1 DB ?
    ENDSIGN DB 0DH, 0AH, '$'
DATA ENDS
    END INIT