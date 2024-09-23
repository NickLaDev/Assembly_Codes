; Título do programa
TITLE soma5

; Modelo de memória utilizado (pequeno)
.MODEL SMALL

; Tamanho da pilha (100h)
.STACK 100h

; Seção de dados
.DATA
    ; String que representa uma quebra de linha (CR+LF)
    MSG2 db 10, 13, "O resultado da soma dos 5 numeros eh: $"
    
    ; Quantidade de letras no alfabeto (26)
    COUNT dw 5
    
    ; Variavel que armazena a soma
    SOMA dw 0

    ; Mensagem 1
    MSG1 db 10,13, "Digite um numero para calcular a soma: $"

; Seção de código
.CODE

; Procedimento principal
main proc

    ; Libera o acesso à memória
    MOV ax, @DATA
    MOV ds, ax

    mov cx,COUNT

    pega_numeros:
    ;Começo real do código
        mov ah,9
        lea dx,MSG1 ;Imprime a primeira mensagem
        int 21h

        mov ah,1
        int 21h ; Salva em AL o numero lido
        mov bl,al
    
        sub bx,48
        push bx

    loop pega_numeros ; Loop de 5x

    mov cx,COUNT

    soma_numeros:

        pop bx
        add SOMA,bx

    loop soma_numeros

    add SOMA,48
    mov ah,9
    lea dx,MSG2 ; Imprime a mensagem 2
    int 21h

    mov dx,SOMA ; Imprime o resultado da soma
    mov ah,2
    int 21h



; Fim do programa

    MOV ah, 4Ch
    INT 21h

; Fim do procedimento principal
main endp

; Fim do programa
end main