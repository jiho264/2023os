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