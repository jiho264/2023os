# input (save input to AX)
- echo input
    MOV AH, 1
- non-echo input
    MOV AH, 8
    
# output (save output to DX)
- print word
    MOV AH, 2 (PRINT DX)
- print string (start address to $)
    MOV AH, 9 (PRINT [DX ~~ $])
- print enter
    MOV DL, CR (CR EQU 0DH)
    +
    MOV DL, LF (LF EQU 0AH)
    
# four arithmetic operations
- addtion (OP1 += OP2)
    add OP1, OP2
    
    add al, bl
    adc ah, bh (carry flag)
- subtration (OP1 -= OP2)
    sub OP1, OP2
- multiplication
    size | source1 | source 2 | destination
     DB  |   AL    |   r/m8   |    AX
     DW  |   AX    |   r/m16  |   DX:AX (DX needs to be initialized)
- division
    size | dividend | divisor | quitient | remainder | maximum quotient
     DB  |    AX    |  r/m8   |    AL    |    AH     |      255
     DW  |    AX    |  r/m8   |    AL    |    AH     |      255
     DW  |   DX:AX  |  r/m16  |    AX    |    DX     |     65535 (DX needs to be initialized)

# compare
- usage
    cmp OP1, OP2
- OP1 > OP2 (above, great)
    ja ~
    jg ~
- OP1 < OP2 (below, less)
    jb ~
    jl ~
- OP1 == OP2 (equal)
    je ~
- OP1 != OP2 (not equal)
    jne ~

# loop
- usage
    mov cx, N

    order:
        (auto cx--)
    loop order

# stack
- push (OP1 into stack)
    push OP1
    pushf
- pop (top into OP2)
    pop OP2
    popf

# address index
- usage (use any index register)
    opcode [di]

# create variable
- 1byte   
    VAR1 DB ?
- 2byte   
    VAR1 DW ?

# skeleton code
    CODE SEGMENT
        ASSUME CS:CODE, DS:CODE

    INIT:
        MOV AX, CS
        MOV DS, AX

        <your code here>

        MOV AH, 4C00H
        INT 21H

        VAR1 DB ? (1byte)
        VAR2 DW ? (2byte)
        VAR3 DW 15, 53, 34, ...
        VAR4 DB 'hello world$'
    CODE ENDS
        END INIT

# print decimal
    ; https://www.geeksforgeeks.org/8086-program-to-print-a-16-bit-decimal-number/
    ;8086 program to print a 16 bit decimal number
    .MODEL SMALL
    .STACK 100H
    .DATA
    ; printable range [0 65535]
    d1 dw 65535
    .CODE
    MAIN PROC FAR
        MOV AX,@DATA
        MOV DS,AX   
        
        ;load the value stored
        ; in variable d1
        mov ax,d1      
        
        ;print the value
        CALL PRINT     
        
        ;interrupt to exit              
        MOV AH,4CH
        INT 21H

    MAIN ENDP
    PRINT PROC          
        
        ;initialize count
        mov cx,0
        mov dx,0
        label1:
            ; if ax is zero
            cmp ax,0
            je print1     
            
            ;initialize bx to 10
            mov bx,10       
            
            ; extract the last digit
            div bx                 

            ; div == ax / bx 
            ; ax /= bx
            ; dx = ax % bx

            ;push it in the stack
            push dx             
            
            ;increment the count
            inc cx             
            
            ;set dx to 0
            xor dx,dx
            ; dx는 자신과 같으니, xor dx, dx == always zero.
            jmp label1
        print1:
            ; cx == stack size

            ;check if count
            ;is greater than zero
            cmp cx,0
            je exit
            
            ;pop the top of stack
            pop dx
            
            ;add 48 so that it
            ;represents the ASCII
            ;value of digits
            add dx,48
            
            ;interrupt to print a
            ;character
            mov ah,02h
            int 21h
            
            ;decrease the count
            dec cx
            jmp print1
    exit:
    ret
    PRINT ENDP
    END MAIN

# print hexadecimal
    ; https://www.geeksforgeeks.org/8086-program-to-print-a-16-bit-decimal-number/
    ;8086 program to print a 16 bit hex number
    .MODEL SMALL
    .STACK 100H
    .DATA
    ; printable range [0 65535]
    d1 dw 0faa1h
    .CODE
    MAIN PROC FAR
        MOV AX,@DATA
        MOV DS,AX   
        
        ;load the value stored
        ; in variable d1
        mov ax,d1      
        
        ;print the value
        CALL PRINT     
        
        ;interrupt to exit              
        MOV AH,4CH
        INT 21H

    MAIN ENDP
    PRINT PROC          
        
        ;initialize count
        mov cx,0
        mov dx,0
        label1:
            ; if ax is zero
            cmp ax,0
            je printorder     
            
            ;initialize bx to 10
            mov bx,16  
            
            ; extract the last digit
            div bx                 

            ; div == ax / bx 
            ; ax /= bx
            ; dx = ax % bx

            ;push it in the stack
            push dx             
            
            ;increment the count
            inc cx             
            
            ;set dx to 0
            xor dx,dx
            ; dx는 자신과 같으니, xor dx, dx == always zero.
            jmp label1

        printorder:
            ; cx == stack size
            ;check if count
            ;is greater than zero
            cmp cx,0
            je exit
            pop dx
            cmp dx, 10
            jb print1
            jmp printh
        print1:
            add dx,'0'
            mov ah,02h
            int 21h
            dec cx
            jmp printorder
        printh:
            add dx,'A'-10
            mov ah,02h
            int 21h
            dec cx
            jmp printorder

    exit:
    ret
    PRINT ENDP
    END MAIN