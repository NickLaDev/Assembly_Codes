TITLE caractere
    .MODEL SMALL
    .STACK 100h
    .DATA
        MSG1 DB "Digite 1 caracter: $"
        NUM DB 10,13,"Oque foi digitado eh um numero! $"
        LET DB 10,13,"Oque foi digitado eh uma letra! $"
        DES DB 10,13,"Oque foi digitado eh desconhecido! $"
    .CODE
        main proc

        ;Libera o acesso a memoria
        MOV ax,@DATA
        mov ds,ax

        ;Exibe a mensagem 1
        mov ah,9
        LEA dx,MSG1
        int 21h

        ;Le um caracter do teclado e salva em AL
        mov ah,1
        int 21h

        ;Copia o caracter para bl
        mov bl,AL

        ;Verifica se eh um numero
        CMP Bl,48
        JB NAOENUMERO
        CMP BL,57
        JA NAOENUMERO
        ;Se passar por aqui eh numero
        MOV AH,9
        LEA DX,NUM
        int 21h
        jmp fim

        ;Verifica se eh uma letra
        NAOENUMERO:
        CMP BL,65
        JB NAOELETRA
        CMP BL,90
        JA VERIFICA_MINUSCULA
        ;Se passar por aqui eh letra maiuscula
        MOV AH,9
        LEA DX,LET
        int 21h
        jmp fim

        VERIFICA_MINUSCULA:
        CMP BL,97
        JB NAOELETRA
        CMP BL,122
        JA NAOELETRA
        ;Se passar por aqui eh letra minuscula
        MOV AH,9
        LEA DX,LET
        int 21h
        jmp fim

        ;Se nao for numero nem letra, eh desconhecido
        NAOELETRA:
        MOV AH,9
        LEA DX,DES
        int 21h

        fim:
        MOV AH,4Ch
        int 21h
    ;

        MAIN ENDP
    END MAIN