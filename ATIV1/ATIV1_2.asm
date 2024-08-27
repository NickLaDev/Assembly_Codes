TITLE Eco
    .MODEL SMALL
    .CODE
MAIN PROC
    ; Exibe ? na tela
    MOV AH,2
    MOV DL,'?'
    INT 21h
    ; Lê um caracter e salva em AL
    MOV AH,1
    INT 21h
    ; Copia o caracter lido para BL
    MOV BL,AL
    ; Exibe o caracter Line Feed
    MOV AH,2
    MOV DL,10 ; O código ASC do caracter Line Feed é 10
    INT 21h
    ; Exibe o caracter Carriage Return
    MOV AH,2
    MOV DL,13 ; O código ASC do caracter Carriage Return é 13
    INT 21h
    ; Exibe o caracter lido
    MOV AH,2
    MOV DL,BL
    INT 21h
    ; Finaliza o programa
    MOV AH,4Ch
    INT 21h
    MAIN ENDP
END MAIN