.MODEL small
.STACK 100h
.DATA
    ; Definir a matriz 20x20 (400 posições) para o campo de batalha
    matrix db 400 DUP(0) ; 0 indica vazio, 1-4 indicam tipos de embarcações

    ; Embarcações (tamanhos)
    encouracadoSize dw 5 ; Encouraçado ocupa 5 espaços
    fragataSize dw 4 ; Fragata ocupa 4 espaços
    submarinoSize dw 3 ; Submarino ocupa 3 espaços
    hidroaviaoSize dw 2 ; Hidroavião ocupa 2 espaços
    
    ; Mensagens
    msgWelcome db 'Batalha Naval - 8086 Assembly', 0Dh, 0Ah, '$'
    msgInput db 'Digite as coordenadas do tiro (linha e coluna, de 0 a 19): $'
    msgMiss db 'Errou! Tente novamente.', 0Dh, 0Ah, '$'
    msgHit db 'Acertou! Parabens.', 0Dh, 0Ah, '$'
    msgEnd db 'Fim de jogo! $'
    msgInvalid db 'Coordenadas invalidas! Tente novamente.', 0Dh, 0Ah, '$'

    ; Coordenadas do tiro
    linha dw ?
    coluna dw ?

    ; Contador de navios restantes
    shipsRemaining db 11 ; 1 encouraçado + 1 fragata + 2 submarinos + 2 hidroaviões = 11

.CODE
MAIN:
    ; Inicializar o programa
    MOV AX, @DATA
    MOV DS, AX

    ; Mostrar mensagem de boas-vindas
    MOV AH, 09h
    LEA DX, msgWelcome
    INT 21h

    ; Inicializar o campo e as embarcações
    CALL initShips

GAME_LOOP:
    ; Exibir a matriz ao jogador
    CALL displayMatrix

    ; Receber coordenadas do tiro
    CALL getInput

    ; Verificar se acertou uma embarcação
    CALL checkHit

    ; Verificar fim de jogo
    CALL checkEnd

    JMP GAME_LOOP

END_GAME:
    ; Finalizar o jogo
    MOV AH, 09h
    LEA DX, msgEnd
    INT 21h

    ; Sair
    MOV AH, 4Ch
    INT 21h

; Função para inicializar as embarcações no campo de batalha
initShips:
    CALL placeEncouracado
    CALL placeFragata
    CALL placeSubmarino
    CALL placeHidroaviao
    RET

placeEncouracado:
    ; Alocar o encouraçado (tamanho 5)
    MOV CX, encouracadoSize
    CALL placeShip
    RET

placeFragata:
    ; Alocar a fragata (tamanho 4)
    MOV CX, fragataSize
    CALL placeShip
    RET

placeSubmarino:
    ; Alocar dois submarinos (tamanho 3)
    MOV CX, submarinoSize
    CALL placeShip
    CALL placeShip
    RET

placeHidroaviao:
    ; Alocar dois hidroaviões (tamanho 2)
    MOV CX, hidroaviaoSize
    CALL placeShip
    CALL placeShip
    RET

placeShip:
    ; Função para colocar uma embarcação aleatoriamente na matriz
    MOV DX, 20 ; tamanho da matriz (20x20)

    ; Gerar posição inicial aleatória
    CALL getRandom
    MOV SI, AX

    ; Verificar se o espaço está livre (0) e colocar o navio
    MOV DI, SI
    MOV BX, CX ; tamanho do navio
NEXT_CELL:
    MOV AL, matrix[DI]
    CMP AL, 0
    JNE placeShip ; Se a célula não estiver vazia, tentar outra posição
    MOV matrix[DI], 1 ; Marcar a posição como ocupada pelo navio
    ADD DI, 1
    DEC BX
    JNZ NEXT_CELL
    RET

; Função para exibir a matriz (campo de batalha)
displayMatrix:
    MOV SI, 0
    MOV CX, 400 ; Tamanho total da matriz
PRINT_LOOP:
    MOV AL, matrix[SI] ; Usar SI como índice de 16 bits para acessar a matriz
    ; Mostrar '.' para vazio, 'X' para navio ou acerto
    CMP AL, 0
    JE PRINT_EMPTY
    MOV AL, 'X' ; Marcar como posição de navio ou acerto
    JMP PRINT_CHAR
PRINT_EMPTY:
    MOV AL, '.'
PRINT_CHAR:
    ; Imprimir o caractere
    MOV AH, 02h
    MOV DL, AL
    INT 21h

    ; Adicionar nova linha a cada 20 colunas
    MOV AX, SI
    MOV BX, 20
    DIV BX
    CMP DX, 0
    JNE NO_NEWLINE
    ; Imprimir nova linha
    MOV AH, 02h
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

NO_NEWLINE:
    INC SI
    LOOP PRINT_LOOP
    RET

; Função para obter coordenadas do tiro do jogador
getInput:
    MOV AH, 09h
    LEA DX, msgInput
    INT 21h

    ; Obter linha
    MOV AH, 01h
    INT 21h
    SUB AL, '0' ; Converter para número
    MOV linha, Ax

    ; Obter coluna
    MOV AH, 01h
    INT 21h
    SUB AL, '0' ; Converter para número
    MOV coluna, Ax

    ; Verificar se as coordenadas são válidas
    CMP linha, 20
    JAE invalidInput
    CMP coluna, 20
    JAE invalidInput
    RET

invalidInput:
    MOV AH, 09h
    LEA DX, msgInvalid
    INT 21h
    JMP getInput

; Função para verificar se o tiro acertou uma embarcação
checkHit:
    ; Calcular o índice da matriz com base nas coordenadas
    MOV AX, linha
    MOV BX, 20
    MUL BX
    ADD AX, coluna
    MOV SI, AX

    ; Verificar se acertou
    MOV AL, matrix[SI]
    CMP AL, 0
    JE miss
    ; Se acertou, marcar o acerto
    MOV matrix[SI], 0 ; Marcar como "acertado"
    DEC shipsRemaining ; Diminuir o contador de navios
    MOV AH, 09h
    LEA DX, msgHit
    INT 21h
    RET

miss:
    MOV AH, 09h
    LEA DX, msgMiss
    INT 21h
    RET

; Função para verificar o fim de jogo
checkEnd:
    CMP shipsRemaining, 0
    JNE continueGame
    JMP END_GAME

continueGame:
    RET

; Função para gerar um número aleatório
getRandom:
    ; Gerar um número aleatório entre 0 e 399 (para o campo 20x20)
    ; Usar a interrupção de tempo do BIOS para obter aleatoriedade simples
    MOV AH, 2Ch
    INT 21h
    XOR AH, AH
    MOV BX, 400
    DIV BX
    RET

END MAIN
