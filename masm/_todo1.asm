; SUB를 이용해서 2byte 뺄셈

CODE SEGMENT
    ASSUME CS:CODE

    MOV AX, CS
    MOV DS, AX

    MOV AX, A
    SUB AX, B

    MOV A, AX
    
    MOV AH, 4CH
    INT 21H

    A DW 4444H
    B DW 1111H
CODE ENDS
END
