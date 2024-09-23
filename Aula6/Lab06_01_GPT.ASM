.MODEL SMALL
.STACK 100h

.DATA
    msg1 DB 'Digite caracteres. Pressione ENTER para encerrar:', '$'
    msg2 DB 0DH, 0AH, 'Numero de caracteres digitados: ', '$'
    star DB '*'
    newline DB 0DH, 0AH, '$'

.CODE
MAIN PROC
    MOV AX, @DATA         ; Inicializa o segmento de dados
    MOV DS, AX

    ; Exibe mensagem inicial
    MOV AH, 09h
    LEA DX, msg1
    INT 21h

    ; Inicializa contagem de caracteres
    MOV CX, 0             ; CX vai contar o número de caracteres

READ_LOOP:
    ; Lê um caractere do teclado
    MOV AH, 01h           ; Função para ler um caractere
    INT 21h
    CMP AL, 0DH           ; Verifica se é o caractere CR (Enter)
    JE EXIT_LOOP          ; Se for CR, sai do loop
    INC CX                ; Incrementa o contador de caracteres
    JMP READ_LOOP         ; Continua lendo caracteres

EXIT_LOOP:
    ; Exibe a mensagem com a contagem de caracteres
    MOV AH, 09h
    LEA DX, msg2
    INT 21h

    ; Imprime asteriscos baseados na contagem em CX
PRINT_STARS:
    CMP CX, 0             ; Verifica se CX (contador) é 0
    JE END_PROGRAM        ; Se for zero, finaliza
    MOV AH, 02h           ; Função de saída de caractere
    MOV DL, star          ; Caractere a ser impresso ('*')
    INT 21h
    DEC CX                ; Decrementa o contador
    JMP PRINT_STARS       ; Repete até imprimir todos os asteriscos

END_PROGRAM:
    ; Imprime nova linha
    MOV AH, 09h
    LEA DX, newline
    INT 21h

    ; Finaliza o programa
    MOV AH, 4Ch           ; Função para finalizar o programa
    INT 21h

MAIN ENDP
END MAIN
