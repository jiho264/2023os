CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
INIT:
    MOV AX, DATA
    MOV DS, AX

    MOV BX, OFFSET DATA1 ; START POINT
    XOR DI, DI ; INDEX초기화
    CMP NUMBER, 1 ; 만약 넘버 1이면, 바로 하나만 출력하면됨. >> EXIT로 바로 보내버리기.
    JE EXIT

RT:
    CMP BYTE PTR [BX + DI], '$' ; 달러 찾았는가
    JNE SKIP
        MOV BYTE PTR [BX + DI], '&' ; 달러면 &로 교체, 교체할때 마다 검사 진행
        SUB NUMBER, 1 ; 수행횟수 ++
        CMP NUMBER, 1 ; NUMBER가 1회 남으면 종료
        JBE EXIT
    SKIP: ; 달러 아니면 다음 인덱스로, 달러면 위에서 더했고, 다음 인덱스로
        ADD DI, 1

    JMP RT

EXIT:
    MOV DX, OFFSET DATA1
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
CODE ENDS
DATA SEGMENT
	NUMBER DB 5
	DATA1 DB "This is Test 1 of 5$"
	DATA2 DB "This sentence is Test 2 of 5$"
	DATA3 DB "This is Test 3 of 5$"
	DATA4 DB "This sentence is Test 4 of 5$"
	DATA5 DB "This is Test 5 of 5$"
DATA ENDS
END INIT

; 해설
; 1넣으면 첫째줄, 5넣으면 마지막줄 까지 다 출력됨.
; 데이터 세그먼트의 data1의 오프셋부터 한 바이트씩 넘어가며 '$'가 있는지 검사하고, 존재한다면 &로 바꾼다.
; 바꿀때마다 number를 줄여준다. num-1회 해야하므로, num==1일시 문자열 출력하고 종료한다.