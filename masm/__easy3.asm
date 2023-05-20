; 소문자 > 대문자로 출력.
; 조건 : 소문자만 입력받기.
; 다 무시하다, 소문자 나오는 즉시 대문자로 변환해서 출력하기.
CODE SEGMENT
    ASSUME CS:CODE, DS:CODE
    SAY DB 0DH, 0AH, 'try : $'

INIT:
    MOV AX, CODE
    MOV DS, AX

RE:
    MOV DX, OFFSET SAY
    MOV AH, 9
    INT 21H

    MOV AH, 1
    INT 21H

    CMP AL, 'a'
    JB RE
    CMP AL, 'z'
    JA RE
    SUB AL, 32

    MOV DL, AL
    MOV AH, 2
    INT 21H

    MOV AX, 4C00H
    INT 21H    

CODE ENDS
END INIT