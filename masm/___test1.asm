; (문제 1) 
;    키보드에서 입력받은 A~Z 의 문자에 따라 (단, 대소문자를 구분하지 않음),
;    각각 숫자 1~26이 화면에 출력되는 PC 어셈블리 프로그램을 작성하시오.
;    단, 이 프로그램은 무한 반복되게 해야 함.
;    예를들어, 소문자 Z 나 대문자 Z를 입력하면 화면에 26 이 나타나면 됨.
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
PRINT_ANS:
; 미리 ax에 출력값 넣어놔야함
    MOV CX,0
    MOV DX,0
    LABEL1:
        CMP AX,0
        JE PRINT1     
        MOV BX,10       
        DIV BX               
        PUSH DX             
        INC CX      
        XOR DX,DX
        JMP LABEL1
    PRINT1:
        CMP CX,0
        JE EXIT
        POP DX
        ADD DX,48
        MOV AH,02H
        INT 21H
        DEC CX
        JMP PRINT1
    EXIT:
        RET
    
INIT:
    MOV AX, DATA
    MOV DS, AX

RT:
    
    MOV AH, 1
    INT 21H
    
    MOV BL, AL
    MOV AX, BX
    ; IF INPUT IS LOWER
    CMP AX, 'a'
    JB SKIP
    SUB AX, 20H
    SKIP:
        SUB AX, 'A'-1

    CALL PRINT_ANS

    MOV DX, OFFSET RE
    MOV AH, 9
    INT 21H
    
    JMP RT
    
CODE ENDS
DATA SEGMENT
    RE DB 0DH, 0AH, '$'
DATA ENDS
    END INIT