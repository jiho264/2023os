CODE SEGMENT
    ASSUME CS:CODE
NEXT: 
    MOV AH, 1
    INT 21H

    CMP AL, 20H ; space bar == ascii 20h
    JE EXIT ; terminate
    CMP AL, 'A' 
    JB PRINT ; jump if below > print
    CMP AL, 'Z'
    JA PRINT ; jump if above > print
    ; this AL is always upper alphabet
    ADD AL, 'a'-'A' ; if alphabet? set lower alphabet

PRINT:
    MOV AH, 2
    MOV DL, AL
    INT 21H
    JMP NEXT
EXIT:
    MOV AH, 4CH
    INT 21H
CODE ENDS
END