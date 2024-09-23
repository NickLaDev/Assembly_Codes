; Título do programa
TITLE fortester

; Modelo de memória utilizado (pequeno)
.MODEL SMALL

; Tamanho da pilha (100h)
.STACK 100h

; Seção de dados
.DATA
    ; String que representa um asterisco
    MSG1 db "* $"
    
    ; String que representa uma quebra de linha (CR+LF)
    PULA db 10, 13, "$"
    
    ; Quantidade de vezes que o loop vai rodar (50)
    COUNT dw 50

; Seção de código
.CODE

; Procedimento principal
main proc

    ; Libera o acesso à memória
    MOV ax, @DATA
    MOV ds, ax

    ; Prepara para primeira impressão
    mov ah,9
    LEA dx,MSG1

    ; Carregando a quantidade de vezes que o loop vai rodar no registrador CX
    mov cx,COUNT 

    ; Loop para imprimir asteriscos na mesma linha
    repete1:
        ; Imprimindo a mensagem na mesma linha
        int 21h 

        ; Decrementando o contador CX
        dec cx
        ; Verificando se CX é diferente de zero
        jnz repete1

    ; Reseta o contador CX
    mov cx,COUNT 

    ; Loop para imprimir asteriscos nas colunas
    repete2:
        ; Imprimindo a quebra de linha
        LEA dx,PULA
        int 21h

        ; Imprimindo a mensagem nas colunas
        LEA dx,MSG1
        int 21h 

        ; Decrementando o contador CX
        dec cx
        ; Verificando se CX é diferente de zero
        jnz repete2

    ; Fim do programa

    ; Configurando o registrador AH para sair do programa
    MOV ah, 4Ch
    ; Saindo do programa
    INT 21h

; Fim do procedimento principal
main endp

; Fim do programa
end main