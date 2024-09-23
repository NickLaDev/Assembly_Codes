; Título do programa
TITLE alphabetolinhas

; Modelo de memória utilizado (pequeno)
.MODEL SMALL

; Tamanho da pilha (100h)
.STACK 100h

; Seção de dados
.DATA
    ; String que representa uma quebra de linha (CR+LF)
    PULA db 10, 13, "$"
    
    ; Quantidade de letras no alfabeto (26)
    COUNT dw 26
    
    ; Quantidade de letras por linha (4)
    PULA_COUNT dw 4

; Seção de código
.CODE

; Procedimento principal
main proc

    ; Libera o acesso à memória
    MOV ax, @DATA
    MOV ds, ax

    ; Inicializa o registrador DL com o caractere "a"
    MOV dl, "a"
    
    ; Inicializa o registrador CX com a quantidade de letras no alfabeto
    MOV cx, COUNT

; Loop externo (loop1)
loop1:
        
    ; Salva o valor de CX em BX
    MOV bx, cx
    
    ; Inicializa o registrador CX com a quantidade de letras por linha
    MOV cx, PULA_COUNT
    
; Loop interno (loop2)
loop2:

    ; Imprime o caractere atual (DL) na tela
    MOV ah, 2
    INT 21h

    ; Incrementa o caractere atual (DL)
    INC dl
    
    ; Decrementa o valor de BX (quantidade de letras restantes)
    DEC bx
    
    ; Se BX for zero, salta para o fim do programa
    JZ fim

; Repete o loop interno (loop2)
LOOP loop2

    ; Imprime uma quebra de linha
    MOV ah, 9
    PUSH dx
    LEA dx, PULA ; Carrega o endereço da string PULA em DX
    INT 21h
    
    ; Restaura o valor de CX (quantidade de letras restantes)
    MOV cx, bx
    
    ; Restaura o valor de DX (caractere atual)
    POP dx

; Salta para o início do loop externo (loop1)
JMP loop1

; Fim do programa
fim:
    ; Termina o programa
    MOV ah, 4Ch
    INT 21h

; Fim do procedimento principal
main endp

; Fim do programa
end main