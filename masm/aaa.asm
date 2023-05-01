MAIN SEGMENT
    ASSUME CS:MAIN, DS:MAIN
    ; CS, DS 나뉘어져 있지만, 해당 코드에선 둘 다 CS에 있기에 대입해줌.
    MOV AX, CS ; AX = CS
    ; >> AX == 0584 
    MOV DS, AX ; DS = AX = CS
    ; >> CS == 0584

    ; calcul
    MOV AX, A ; AX = A
    ; >> AX == 0002
    ADD AX, B ; AX = A + B
    ; >> AX == 0007
    MOV SUM, AX ; SUM = AX
    ; >> SUM == 0007

    ADD AL,'0' ; AL += '0'... int 7 + char '0' == char '7'
    ; >> AX == 0037
    MOV DL, AL ; DL = '7'
    ; >> DX == 0037
    MOV AH, 2 ; print의 sub function의 number가 _2__임. 이래야 출력함
    ; >> AX >> 0237
    INT 21H ; interrupt, 21(hex == 33), print(DL)

    ; process exit
    MOV AX, 4C00H ; 4C00(hex)
    ; >> AX == 4C00
    INT 21H ; interrupt, 21(hex == 33)
    ; TERMINATE

    ; set value
    A DW 2 ; init (Word Ptr [001B])
    B DW 5 ; init (Word Ptr [001D])
    SUM DW ? ; malloc
MAIN ENDS
    END

; AX = AH + AL

; 1. mount x [path]
; 2. x:\
; 3. ml [asm file name]
; 4. [asm file name]
; debug $ cv /s [name].exe

; < in debug>
; L segment address / R offset address... L+R = real address
; DS + IP == PC