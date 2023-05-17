CODE SEGMENT   
    ASSUME CS:CODE
    MOV CL, 0 ; INIT
NEXT: 
    CALL PUTNUM ; CALL SUBROUTINE ; 되돌아올 두소 0005h를 stack에 pysh
    INC CL ; CL ++
    CMP CL, 26 ; IF CL < 10
    JB NEXT ; GO TO NEXT

    MOV AH, 4CH
    INT 21H
PUTNUM:
    MOV DL, CL
    ADD DL, 'a' ; INT2STR
    MOV AH, 2
    INT 21H
    RET ; stack에서 pop해서 0005H를 ip값으로 바꿈
CODE ENDS
END

; 응용문제 >> 거꾸로 출력하기, 홀수 or 짝수만 출력해보기
; 모음은 출력하지 말아라


; MOV DX, [STRING ADDRESS]
; MOV AH, 9
; INT 21H >> WRITE STRING


; DX = 'H' ADDRESS 
; STRING END POINT == $
; "HELLOWORLD$"
