; 화면헤서 하나 받아서 그대로 출력
CODE SEGMENT
    ASSUME CS:CODE

    MOV AX, CS
    MOV DX, AX

    MOV AH, 1
    MOV DX, AX
    INT 21h

    MOV AX, 4C00H
    INT 21h
CODE ENDS
END