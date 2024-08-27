TITLE Mensagens
.MODEL SMALL
.DATA
    MSG1 DB 'Mensagem 1.$''
    MSG2 DB 10,13,'Mensagem 2.$'
.CODE
MAIN PROC
    ; Permite acesso ao .data
    MOV AX,@DATA
    MOV DS,AX
    ; Exibe a mensagem 1
    MOV AH,9
    LEA DX,MSG1
    INT 21h
    ; Exibe a mensagem 2
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    ; Finaliza o programa
    MOV AH,4Ch
    INT 21h
    MAIN ENDP
END MAIN