- HTTPS://GITHUB.COM/JIHO264/2023OS/BLOB/MAIN/MASM/__MEMO.MD

# INPUT (SAVE INPUT TO AX)
- ECHO INPUT
    MOV AH, 1
- NON-ECHO INPUT
    MOV AH, 8
    
# OUTPUT (SAVE OUTPUT TO DX)
- PRINT WORD
    MOV AH, 2 (PRINT DX)
- PRINT STRING (START ADDRESS TO $)
    MOV AH, 9 (PRINT [DX ~~ $])
- PRINT ENTER
    MOV DL, CR (CR EQU 0DH)
    +
    MOV DL, LF (LF EQU 0AH)
    
# FOUR ARITHMETIC OPERATIONS
- ADDTION (OP1 += OP2)
    ADD OP1, OP2
    
    ADD AL, BL
    ADC AH, BH (CARRY FLAG)
- SUBTRATION (OP1 -= OP2)
    SUB OP1, OP2
- MULTIPLICATION
    SIZE | SOURCE1 | SOURCE 2 | DESTINATION
     DB  |   AL    |   R/M8   |    AX
     DW  |   AX    |   R/M16  |   DX:AX (DX NEEDS TO BE INITIALIZED)
- DIVISION
    SIZE | DIVIDEND | DIVISOR | QUITIENT | REMAINDER | MAXIMUM QUOTIENT
     DB  |    AX    |  R/M8   |    AL    |    AH     |      255
     DW  |    AX    |  R/M8   |    AL    |    AH     |      255
     DW  |   DX:AX  |  R/M16  |    AX    |    DX     |     65535 (DX NEEDS TO BE INITIALIZED)

# COMPARE
- USAGE
    CMP OP1, OP2
- OP1 > OP2 (ABOVE, GREAT)
    JA ~
    JG ~
- OP1 < OP2 (BELOW, LESS)
    JB ~
    JL ~
- OP1 == OP2 (EQUAL)
    JE ~
- OP1 != OP2 (NOT EQUAL)
    JNE ~

# LOOP
- USAGE
    MOV CX, N

    ORDER:
        (AUTO CX--)
    LOOP ORDER

# STACK
- PUSH (OP1 INTO STACK)
    PUSH OP1
    PUSHF
- POP (TOP INTO OP2)
    POP OP2
    POPF

# ADDRESS INDEX
- USAGE (USE ANY INDEX REGISTER)
    OPCODE [DI]

# CREATE VARIABLE
- 1BYTE   
    VAR1 DB ?
- 2BYTE   
    VAR1 DW ?

# SKELETON CODE
    CODE SEGMENT
        ASSUME CS:CODE, DS:CODE

    INIT:
        MOV AX, CS
        MOV DS, AX

        <YOUR CODE HERE>

        MOV AH, 4C00H
        INT 21H

        VAR1 DB ? (1BYTE)
        VAR2 DW ? (2BYTE)
        VAR3 DW 15, 53, 34, ...
        VAR4 DB 'HELLO WORLD$'
    CODE ENDS
        END INIT
# PRINT [0 99]
    PRINT_ANS:
        MOV AX, ANS
        MOV BL, 10
        DIV BL
        MOV NUM10, AL
        MOV NUM1, AH
        MOV DX, OFFSET NUM10

        CMP NUM10, 0
        JNE EXIT

        MOV DX, OFFSET NUM1
        EXIT: ; CONVERT TO ASCII CODE
            ADD NUM10, '0'
            ADD NUM1, '0'
            MOV AH, 9
            INT 21H
        RET

    ANS DW ?
    NUM10 DB ?
    NUM1 DB ?
# PRINT DECIMAL
    ; HTTPS://WWW.GEEKSFORGEEKS.ORG/8086-PROGRAM-TO-PRINT-A-16-BIT-DECIMAL-NUMBER/
    ;8086 PROGRAM TO PRINT A 16 BIT DECIMAL NUMBER
    .MODEL SMALL
    .STACK 100H
    .DATA
    ; PRINTABLE RANGE [0 65535]
    D1 DW 65535
    .CODE
    MAIN PROC FAR
        MOV AX,@DATA
        MOV DS,AX   
        
        ;LOAD THE VALUE STORED
        ; IN VARIABLE D1
        MOV AX,D1      
        
        ;PRINT THE VALUE
        CALL PRINT     
        
        ;INTERRUPT TO EXIT              
        MOV AH,4CH
        INT 21H

    MAIN ENDP
    PRINT PROC          
        
        ;INITIALIZE COUNT
        MOV CX,0
        MOV DX,0
        LABEL1:
            ; IF AX IS ZERO
            CMP AX,0
            JE PRINT1     
            
            ;INITIALIZE BX TO 10
            MOV BX,10       
            
            ; EXTRACT THE LAST DIGIT
            DIV BX                 

            ; DIV == AX / BX 
            ; AX /= BX
            ; DX = AX % BX

            ;PUSH IT IN THE STACK
            PUSH DX             
            
            ;INCREMENT THE COUNT
            INC CX             
            
            ;SET DX TO 0
            XOR DX,DX
            ; DX는 자신과 같으니, XOR DX, DX == ALWAYS ZERO.
            JMP LABEL1
        PRINT1:
            ; CX == STACK SIZE

            ;CHECK IF COUNT
            ;IS GREATER THAN ZERO
            CMP CX,0
            JE EXIT
            
            ;POP THE TOP OF STACK
            POP DX
            
            ;ADD 48 SO THAT IT
            ;REPRESENTS THE ASCII
            ;VALUE OF DIGITS
            ADD DX,48
            
            ;INTERRUPT TO PRINT A
            ;CHARACTER
            MOV AH,02H
            INT 21H
            
            ;DECREASE THE COUNT
            DEC CX
            JMP PRINT1
    EXIT:
    RET
    PRINT ENDP
    END MAIN

# PRINT HEXADECIMAL
    ; HTTPS://WWW.GEEKSFORGEEKS.ORG/8086-PROGRAM-TO-PRINT-A-16-BIT-DECIMAL-NUMBER/
    ;8086 PROGRAM TO PRINT A 16 BIT HEX NUMBER
    .MODEL SMALL
    .STACK 100H
    .DATA
    ; PRINTABLE RANGE [0 65535]
    D1 DW 0FAA1H
    .CODE
    MAIN PROC FAR
        MOV AX,@DATA
        MOV DS,AX   
        
        ;LOAD THE VALUE STORED
        ; IN VARIABLE D1
        MOV AX,D1      
        
        ;PRINT THE VALUE
        CALL PRINT     
        
        ;INTERRUPT TO EXIT              
        MOV AH,4CH
        INT 21H

    MAIN ENDP
    PRINT PROC          
        
        ;INITIALIZE COUNT
        MOV CX,0
        MOV DX,0
        LABEL1:
            ; IF AX IS ZERO
            CMP AX,0
            JE PRINTORDER     
            
            ;INITIALIZE BX TO 10
            MOV BX,16  
            
            ; EXTRACT THE LAST DIGIT
            DIV BX                 

            ; DIV == AX / BX 
            ; AX /= BX
            ; DX = AX % BX

            ;PUSH IT IN THE STACK
            PUSH DX             
            
            ;INCREMENT THE COUNT
            INC CX             
            
            ;SET DX TO 0
            XOR DX,DX
            ; DX는 자신과 같으니, XOR DX, DX == ALWAYS ZERO.
            JMP LABEL1

        PRINTORDER:
            ; CX == STACK SIZE
            ;CHECK IF COUNT
            ;IS GREATER THAN ZERO
            CMP CX,0
            JE EXIT
            POP DX
            CMP DX, 10
            JB PRINT1
            JMP PRINTH
        PRINT1:
            ADD DX,'0'
            MOV AH,02H
            INT 21H
            DEC CX
            JMP PRINTORDER
        PRINTH:
            ADD DX,'A'-10
            MOV AH,02H
            INT 21H
            DEC CX
            JMP PRINTORDER

    EXIT:
    RET
    PRINT ENDP
    END MAIN