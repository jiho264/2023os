CODE SEGMENT
    ASSUME CS:CODE
NEXT : 
    MOV AH, 1
    INT 21H ; save input to AL

    MOV DL, AL ; copy AL to DL
    INC DL ; DL++
    MOV AH, 2 ; print DL
    INT 21H

    JMP NEXT ; goto line 3.. loop

    MOV AH, 4CH ; terminate
    INT 21H
CODE ENDS
END