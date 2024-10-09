.MODEL SMALL
.STACK 100H
.DATA
    prompt DB 'Digite um numero binario (max 16 bits): $'
    newline DB 0DH, 0AH, '$'
    CR EQU 0DH  ; Código ASCII do Carriage Return (CR) ( equ = define )

.CODE
START:
    MOV AX, @DATA    ; Inicializa segmento de dados
    MOV DS, AX

    ; Exibe prompt para o usuário
    LEA DX, prompt
    MOV AH, 09H
    INT 21H

    ; Inicializa registrador BX com 0
    XOR BX, BX

READ_LOOP:
    ; Ler caractere do teclado
    MOV AH, 01H
    INT 21H
    CMP AL, CR        ; Verifica se é CR (fim da entrada)
    JE DONE

    ; Verifica se o caractere é '0' ou '1'
    CMP AL, '0'
    JB INVALID_CHAR
    CMP AL, '1'
    JA INVALID_CHAR

    ; Desloca BX 1 bit à esquerda
    SHL BX, 1

    ; Converte caractere '0' ou '1' para valor binário
    SUB AL, '0'
    
    ; Insere o valor no bit menos significativo de BX
    OR  BX, AX

    JMP READ_LOOP

INVALID_CHAR:
    ; Ignora caracteres inválidos
    JMP READ_LOOP

DONE:
    ; Adiciona nova linha para formatar a saída
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H

END START
