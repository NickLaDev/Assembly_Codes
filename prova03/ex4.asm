.MODEL SMALL
.STACK 100h

.DATA
    vetor DB  1, 2, 3, 4, 5             ; Vetor original
    tam   EQU 5                         ; Tamanho do vetor
    k     DB  2                         ; Número de rotações
    msg   DB  'Vetor rotacionado: $'    ; Mensagem inicial

.CODE
MAIN PROC
                     MOV   AX, @DATA              ; Inicializa segmento de dados
                     MOV   DS, AX
                     MOV   ES, AX

    ; Exibe mensagem inicial
                     LEA   DX, msg
                     MOV   AH, 09h                ; Função de impressão do DOS
                     INT   21h

    ; Rotacionar o vetor
                     LEA   SI, vetor              ; SI aponta para o vetor
                     MOV   AL, k                  ; Carrega k no registrador AL
                     CALL  rotacionar_vetor       ; Chama o procedimento de rotação

    ; Imprimir vetor rotacionado
                     LEA   SI, vetor              ; SI aponta para o vetor
                     MOV   CX, tam                ; Configura tamanho do vetor
                     CALL  imprimir_vetor         ; Chama o procedimento de impressão

    ; Finaliza o programa
                     MOV   AH, 4Ch
                     INT   21h
MAIN ENDP

rotacionar_vetor PROC
    ; Entrada: SI aponta para o vetor, AL contém o número de rotações
    ; Saída: Vetor rotacionado (no local)

                     MOV   CL, AL                 ; CL recebe o número de rotações (k)

    rotacao:         
                     PUSH  CX                     ; Salva contador de rotações

    ; Copia o último elemento
                     LEA   DI, vetor + tam - 1    ; DI aponta para o último elemento
                     
                     MOV   AL, [DI]               ; AL recebe o último elemento

    ; Move os elementos para a direita
                     MOV   CX, tam - 1            ; Configura contador para mover 4 elementos
                     LEA   DI, vetor + tam - 2    ; DI aponta para o penúltimo elemento

    mover:           
                     MOV   DL, [DI]               ; DL recebe o valor atual
                     MOV   [DI + 1], DL           ; Move o valor para a próxima posição
                     DEC   DI                     ; Avança DI para o próximo elemento
                     LOOP  mover                  ; Continua até mover todos os elementos

    ; Coloca o último elemento na primeira posição
                     LEA   DI, vetor              ; DI aponta para o primeiro elemento
                     MOV   [DI], AL               ; Insere o valor em AL no início do vetor

    ; Restaura o contador de rotações
                     POP   CX
                     LOOP  rotacao                ; Repete até que todas as rotações sejam feitas

                     RET
rotacionar_vetor ENDP

imprimir_vetor PROC
    ; Entrada: SI aponta para o vetor, CX contém o tamanho
    ; Saída: Imprime os elementos do vetor

                     MOV   AH, 02h                ; Função de saída de caractere do DOS

    imprimir_loop:   
                     LODSB                        ; Carrega o próximo byte do vetor em AL
                     MOV   DL, AL                 ; Move o valor para DL
                     ADD   DL, 30h                ; Converte para ASCII
                     INT   21h                    ; Imprime o caractere
                     MOV   DL, ' '                ; Espaço entre os elementos
                     INT   21h
                     LOOP  imprimir_loop          ; Continua até imprimir todos os elementos

                     RET
imprimir_vetor ENDP

END MAIN
