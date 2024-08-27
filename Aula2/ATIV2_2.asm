TITLE subtracao
.MODEL SMALL
.DATA
    MSG1 db 'Insira o primeiro numero:$'
    MSG2 db 10,13,'Insira o segundo numero:$'
    MSG3 db 10,13,'O resultado da subtracao eh:$'
.CODE
    main proc
    ; Permite acesso ao .data
    MOV AX,@DATA
    MOV DS,AX

    ; Exibe a mensagem 1
    MOV AH,9
    LEA DX,MSG1
    INT 21h

    ; Lê um caracter e salva em AL
    MOV AH,1
    INT 21h

    ; Transforma o caracter em numero
    SUB AL,30h
    MOV BH,AL ; Armazena em BH o primeiro numero

    ; Exibe a mensagem 2
    MOV AH,9
    LEA DX,MSG2
    INT 21h

     ; Lê um caracter e salva em AL
    MOV AH,1
    INT 21h

    ; Transforma o caracter em numero
    SUB AL, 30h

    ;Calcula o resultado
    ADD BH,AL
    ADD BH,30h

    ;Imprime o resultado da soma
    ; Exibe a mensagem 2
    MOV AH,9
    LEA DX,MSG3
    INT 21h

    ; Exibe o resultado
    MOV AH,2
    MOV DL,BH
    INT 21h

    ; Finaliza o programa
    MOV AH,4Ch
    INT 21h
    MAIN ENDP
END MAIN







