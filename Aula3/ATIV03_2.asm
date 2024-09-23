TITLE vereficador
.MODEL SMALL
.STACK 100h
.DATA 
    MSG1 db "Digite um caracter, $"
    NUMERO db 10,13,"Oque foi digitado eh um numero! $"
    LETRA db 10,13,"Oque foi digitado eh uma letra! $"
    DESCONHECIDO db 10,13,"Oque foi digitado eh desconhecido! $"
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

    ;Comeca as comparacoes e pulos:
    CMP bl,47
    JA numor