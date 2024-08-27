TITLE letras
.MODEL SMALL
.DATA
    MSG1 db 'Insira uma Letra:$'
    MSG2 db 10,13,'A Letra maiscula eh:$'
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

    ; Transforma em letra maiúscula
    SUB AL,20h
    MOV BL,AL

    ; Exibe a mensagem 2
    MOV AH,9
    LEA DX,MSG2
    INT 21h
    
    ; Exibe o caracter maisculo
    MOV AH,2
    MOV DL,BL
    INT 21h

    ; Finaliza o programa
    MOV AH,4Ch
    INT 21h
    MAIN ENDP
END MAIN


