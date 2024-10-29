ReadFirstDigit:
    MOV AH,1          ; Lê um caractere do teclado
    INT 21h
    CMP AL,0Dh        ; Verifica se o caractere é "Enter" (13 ou 0Dh)
    JE ReadSecondDigit  ; Se for "Enter", pula para o próximo número
    
    SUB AL, '0'       ; Converte de ASCII para valor numérico
    MOV CL,AL
    MOV AX,Num1
    MOV BX,10          
    MUL BX            ; Multiplica Num1 por 10 (desloca os dígitos)
    ADD AX,CX        ; Adiciona o novo dígito
    MOV Num1,AX       ; Armazena o resultado em Num1
    
    JMP ReadFirstDigit ; Continua lendo o primeiro número