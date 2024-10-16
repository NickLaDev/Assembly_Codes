.MODEL small
.STACK 100h
.DATA

; Matriz 20x20 do jogo inicializada com zeros (0 = vazio)
matriz db 400 dup(0)

; Mensagens para o jogador
msg_inicial db "Bem-vindo ao Batalha Naval!", 0Dh, 0Ah, "$"
msg_erro db "Entrada invalida! Tente novamente.", 0Dh, 0Ah, "$"
msg_coordenadas db "Digite as coordenadas do tiro (linha e coluna):", 0Dh, 0Ah, "$"
msg_acerto db "Voce acertou um navio!", 0Dh, 0Ah, "$"
msg_erro_tiro db "Voce errou.", 0Dh, 0Ah, "$"
msg_final db "Jogo finalizado. Pressione qualquer tecla.", 0Dh, 0Ah, "$"

; Embarcações
encouracado db 5 dup(1)  ; Tamanho 5
fragata db 4 dup(2)       ; Tamanho 4
submarino db 3 dup(3)     ; Tamanho 3
hidroaviao db 2 dup(4)    ; Tamanho 2

.CODE
.STARTUP

; Exibir mensagem inicial
mov ah, 09h
lea dx, msg_inicial
int 21h

call inicializa_matriz ; Chama a função para inicializar a matriz (coloca os navios)

main_loop:

    ; Pergunta ao jogador as coordenadas do tiro
    mov ah, 09h
    lea dx, msg_coordenadas
    int 21h

    call le_coordenadas ; Lê a linha e coluna inserida pelo jogador

    ; Verifica se acertou um navio
    call verifica_acerto

    ; Volta para o loop principal até que o jogador decida sair
    jmp main_loop

; Finalizar o jogo
end_game:
    mov ah, 09h
    lea dx, msg_final
    int 21h
    mov ah, 00h
    int 16h  ; Espera uma tecla ser pressionada
    .EXIT

; Subrotinas

; Inicializa a matriz e posiciona as embarcações
inicializa_matriz proc
    ; Aqui você pode escrever o código para alocar as embarcações na matriz
    ; Aleatoriamente, garantindo que elas não fiquem sobrepostas
    ; E que não estejam encostadas umas nas outras

    ; Para fins de exemplo, vamos apenas colocar alguns valores fixos
    ; (como se fosse uma alocação manual)

    ; Posicionando encouraçado (tamanho 5) a partir de (1, 1)
    mov bx, 1            ; Linha 1
    mov si, 1            ; Coluna 1
    mov cx, 5            ; Tamanho 5
    mov al, 1            ; Valor do encouraçado
    call coloca_navio

    ; Posicionando fragata (tamanho 4) a partir de (5, 5)
    mov bx, 5            ; Linha 5
    mov si, 5            ; Coluna 5
    mov cx, 4            ; Tamanho 4
    mov al, 2            ; Valor da fragata
    call coloca_navio

    ; Posicionando submarino (tamanho 3) a partir de (10, 10)
    mov bx, 10           ; Linha 10
    mov si, 10           ; Coluna 10
    mov cx, 3            ; Tamanho 3
    mov al, 3            ; Valor do submarino
    call coloca_navio

    ; Posicionando hidroavião (tamanho 2) a partir de (15, 15)
    mov bx, 15           ; Linha 15
    mov si, 15           ; Coluna 15
    mov cx, 2            ; Tamanho 2
    mov al, 4            ; Valor do hidroavião
    call coloca_navio

    ret
inicializa_matriz endp

; Coloca um navio de tamanho cx a partir de uma posição na matriz
coloca_navio proc
    ; Aloca navio horizontalmente (para simplificação)
    ; bx = linha inicial, si = coluna inicial, cx = tamanho, al = valor do navio
    mov ax, bx           ; Carrega a linha em ax
    mov cx, 20           ; Multiplicador para 20
    mul cx               ; ax = linha * 20

    add ax, si           ; Adiciona a coluna ao índice

    ; Aloca o navio na posição correta da matriz
    mov matriz[ax], al   ; Coloca o valor do navio na matriz
    ret
coloca_navio endp

; Lê as coordenadas do jogador (linha e coluna)
le_coordenadas proc
    ; Aqui você pode implementar a lógica para ler a entrada do usuário
    ; A partir do teclado, em DOS, usamos a função 01h do int 21h
    ; Esta função deve ler duas coordenadas (linha e coluna) e convertê-las
    ; para índices na matriz 20x20
    
    ; Para este exemplo, vamos apenas usar valores fixos para a linha e coluna
    ; Na prática, você deve implementar a leitura de teclado.

    mov bx, 2    ; Linha (exemplo fixo)
    mov si, 1    ; Coluna (exemplo fixo)
    ret
le_coordenadas endp

; Verifica se o tiro foi um acerto ou erro
verifica_acerto proc
    ; Calcula o índice da matriz com base na linha (bx) e coluna (si)
    mov ax, bx           ; Carrega a linha em ax
    mov cx, 20           ; Multiplicador para 20
    mul cx               ; Multiplica a linha por 20
    add ax, si           ; Adiciona a coluna ao índice

    ; Agora podemos acessar a matriz corretamente
    mov al, matriz[ax]   ; Acessa o valor na matriz
    cmp al, 0            ; Verifica se é um acerto (0 significa água)
    je erro_tiro         ; Se for 0, é um erro

    ; Caso contrário, foi um acerto
    mov ah, 09h
    lea dx, msg_acerto
    int 21h
    jmp fim_verifica

erro_tiro:
    mov ah, 09h
    lea dx, msg_erro_tiro
    int 21h

fim_verifica:
    ret
verifica_acerto endp

END
