; FIND MIN, MAX NUMBER
; TODO FIND MAX+MIN
MAIN SEGMENT
    ASSUME CS:MAIN, DS:data
PRINT_ANS:
    MOV AX, SUM
    CMP AX, 10
    JB UNDER10

    MOV BL, 10
    DIV BL
    MOV NUM10, AL
    MOV NUM1, AH
    MOV DX, OFFSET NUM10
    JMP EXIT
    
    UNDER10: ; IF ANS < 10
        MOV AX, SUM
        MOV NUM1, AL
        MOV DX, OFFSET NUM1
    EXIT: ; CONVERT TO ASCII CODE
        ADD NUM10, '0'
        ADD NUM1, '0'
        MOV AH, 9
        INT 21H
    RET
INIT:
    MOV AX, data
    MOV DS, AX

    MOV DI, OFFSET ARR ; ANY INDEX REGISTER
    MOV AX, [DI]
    
    MOV MIN, AX
    MOV MAX, AX
    ;ADD DL, 2
    MOV CX, 7 ; LOOP LENGTH

    A1:
        MOV AX, [DI]
        CMP AX, MIN
        JGE A2
        MOV MIN, AX

        A2: 
            CMP AX, MAX
            JLE A3
            MOV MAX, AX

        A3:
            ADD DI, 2 ; WORD ARRAY
    LOOP A1 ; LOOP 6 TIME

PRINT:
    ; PRINT SUM
    MOV AX, MAX
    ADD AX, MIN
    MOV SUM, AX

    call PRINT_ANS
    ; terminate
    MOV AH, 4CH
    INT 21H

data SEGMENT
    MIN DW ?
    MAX DW ?
    SUM DW ?
    num10 db ?
    num1 db ?
    theend db '$'
    ARR DW 3, 7, 4, 15, 2, 62, 8
data ends
MAIN ENDS
    END INIT