; non echo input...
; if lower alphabet : print
; else print 0
; after 10 time : terminate
CODE SEGMENT
    ASSUME CS:CODE
    COUNTER DW 0
NEXT: 
    MOV AH, 8
    INT 21H

    CMP AL, 'a' 
    JB PRINT0 ; jump if below > print
    CMP AL, 'z'
    JA PRINT0 ; jump if above > print
    JMP PRINT

PRINT:
    INC COUNTER
    MOV AH, 2
    MOV DL, AL
    INT 21H

    CMP COUNTER, 10 
    JE EXIT ; terminate
    JMP NEXT

PRINT0:
    INC COUNTER
    MOV AH, 2
    MOV AL, '0'
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