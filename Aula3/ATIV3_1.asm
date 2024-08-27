    TITLE numero
    .MODEL SMALL
    .STACK 100h
    .DATA
        MSG1 DB "Digite 1 caracter: $"
        SIM DB 10,13,"Oque foi digitado eh um numero! $"
        NAO DB 10,13,"Oque foi digitado nao eh um numero! $"
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

        ;Compara oque foi lido com 48 ("0")
        CMP Bl,48

        ;Pula se for menor (nao eh numero)
        JB NAOENUMERO

        ;Compara oque foi lido com 57 ("9")
        CMP BL,57

        ;Pula se for maior (nao eh numero)
        JA NAOENUMERO

        ;Se passar por aqui eh numero
        MOV AH,9
        LEA DX,SIM
        int 21h
        jmp fim

        ;Cria parte de nao ser numero
        NAOENUMERO:
        MOV AH,9
        LEA DX,NAO
        int 21h   

        fim:
        MOV AH,4Ch
        int 21h
    ;

        MAIN ENDP
    END MAIN



    
