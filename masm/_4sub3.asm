; 1. non echo input...
; if lower alphabet : print
; else print 0
; after 10 time : terminate
CODE SEGMENT
    ASSUME CS:CODE
    COUNTER DW 0
NEXT: 
    MOV AH, 1
    INT 21H

    CMP AL, 'a' 
    JB PRINT ; jump if below > print
    CMP AL, 'z'
    JA PRINT ; jump if above > print
    MOV AL, '0'
    

PRINT:
    INC COUNTER
    MOV AH, 2
    MOV DL, AL
    INT 21H

    CMP COUNTER, 10 
    JE EXIT ; terminate
    JMP NEXT
EXIT:
    MOV AH, 4CH
    INT 21H
CODE ENDS
END