; (문제 2)
;     키보드에서 대 소문자 문자들을 계속 입력받으며 '소문자 X' 가 입력될때까지 그 갯수를 카운팅 하여 출력하는 PC 어셈블리 프로그램을 작성하시오.
;     예를들어    NOCREDITX 이라고 입력하면, 8 을 출력하면 됨. (X는 카운트 하지 않음)
;     입력은 아주 협조적이어서, 대소문자 이외에는 아무것도 입력하지 않는다고 가정하면 됨. (대소문자가 아닌 것에 대한 어떤 예외 처리도 필요없다는 것)
;     X 가 입력 종료 문자가 되는 것임.
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
PRINT_ANS:
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
    
    CMP AX, 'x' ; compare
    JE TERMINATE ; if equal > terminate
    INC CNT ; increment counter
    JMP RT ; keep going

TERMINATE:
    MOV DX, OFFSET RE
    MOV AH, 9
    INT 21H

    MOV AX, CNT
    CALL PRINT_ANS

CODE ENDS
DATA SEGMENT
    CNT DW 0
    RE DB 0DH, 0AH, '$'
DATA ENDS
    END INIT