CODE SEGMENT
    ASSUME CS:CODE, DS:CODE

    CR EQU 0DH
    LF EQU 0AH

    MOV AX, CODE
    MOV DS, AX

    MOV BX, OFFSET BUFFER ; buffer address
    MOV SI, 2

    MOV DL, [BX+SI]
    MOV AH, 2
    INT 21H

    MOV DL, [BX+SI+1]
    MOV AH, 2
    INT 21H

    MOV DL, CR
    MOV AH, 2
    INT 21H

    MOV DL, LF
    MOV AH, 2
    INT 21H  ; CR + LF == enter key

    MOV DL, [BX+SI+4]
    MOV AH, 2
    INT 21H

    MOV AH, 4CH
    INT 21H

    BUFFER DB 'example.' ; data byte.. array

CODE ENDS
END