TITLE letras
; Definindo o modelo de memória e o tamanho da pilha
.MODEL SMALL
.STACK 100h

; Definindo o segmento de dados
.DATA
    ; Definindo uma string constante para pular linha
    PULA db 10,13, "$"
    ; Definindo uma variável para armazenar a quantidade de letras no alfabeto
    COUNT dw 26

; Definindo o segmento de código
.CODE

; Definindo o procedimento principal
main proc

    ; Liberando o acesso à memória
    MOV ax,@DATA
    mov ds,ax

    ; Carregando o caractere 'A' no registrador DX
    mov dx,"A"
    ; Carregando a quantidade de letras no registrador CX
    mov cx,COUNT
    ; Configurando o registrador AH para imprimir caracteres
    mov ah,2

    ; Loop para imprimir as letras maiúsculas
    MAIUSCULAS:
        ; Imprimindo o caractere no registrador DX
        int 21h
        ; Incrementando o registrador DX para apontar para o próximo caractere
        inc dx
    ; Repetindo o loop até que CX chegue a 0
    loop MAIUSCULAS

    ; Recarregando a quantidade de letras no registrador CX
    mov cx,COUNT
    ; Carregando o endereço da string PULA no registrador DX
    LEA dx,PULA
    ; Configurando o registrador AH para imprimir strings
    mov ah,9
    ; Imprimindo a string PULA
    int 21h
    ; Configurando o registrador AH para imprimir caracteres
    mov ah,2
    ; Carregando o caractere 'a' no registrador DX
    mov dx,"a"

    ; Loop para imprimir as letras minúsculas
    MINUSCULAS:
        ; Imprimindo o caractere no registrador DX
        int 21h
        ; Incrementando o registrador DX para apontar para o próximo caractere
        inc dx
    ; Repetindo o loop até que CX chegue a 0
    loop MINUSCULAS

    ; Configurando o registrador AH para sair do programa
    mov ah,4Ch
    ; Saindo do programa
    int 21h

; Fim do procedimento principal
main endp
; Fim do programa
end main