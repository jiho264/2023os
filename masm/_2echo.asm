; INPUT METHOD
CODE SEGMENT
    ASSUME CS:CODE, DS:CODE

    MOV AX, CODE
    MOV DS, AX ; init

    ;MOV AH, 1 ;  echo false
    MOV AH, 8 ; echo true
    
    INT 21H ; AH==01H && 21H >> wait input
            ; input saved to AL
    MOV KEEP, AL ; toss to KEEP

    MOV DL, KEEP ; input save to DL
    ADD DL, 1 ; increment >> next ascii code
    MOV AH, 2 ; print flag
    INT 21H ; intrrput

    MOV AH, 4CH ; terminate
    INT 21H

    KEEP DB ? ; init variable
CODE ENDS
END