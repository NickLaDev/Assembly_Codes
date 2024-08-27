TITLE   PROG MAIOR
.MODEL  SMALL
.STACK  100H
.CODE
MAIN    PROC
;

    MOV AH,02H
    MOV DL,'*'
    MOV CX,80
FACA:
    INT 21H
    LOOP FACA
    ;DEC CX
    ;JNZ FACA 
    
;retorno ao DOS

    MOV AH,4CH    ;funcao DOS para saida
    INT 21H              ;saindo
MAIN    ENDP
        END MAIN
