; Manipulação de Vetor: Entrada, armazenamento, impressão, comparação e cópia de vetor
; O programa recebe um string, armazena, compara com outro string fixo, copia e busca caracteres.

.MODEL SMALL                  ; Define o modelo de memória como SMALL
.STACK 100H                   ; Define o tamanho da pilha como 256 bytes

; Macros para facilitar o salvamento/restauração de registradores
PUSH_4 MACRO R1, R2, R3, R4
           PUSH R1
           PUSH R2
           PUSH R3
           PUSH R4
ENDM

POP_4 MACRO R1, R2, R3, R4
          POP R4
          POP R3
          POP R2
          POP R1
ENDM

; Macro para pular uma linha
PULAR_LINHA MACRO
                PUSH AX
                PUSH DX
                MOV  AH, 2
                MOV  DL, 10    ; Código ASCII para linha nova
                INT  21H
                MOV  DL, 13    ; Código ASCII para retorno de carro
                INT  21H
                POP  DX
                POP  AX
ENDM

.DATA
    TAMANHO_VETOR          DW 0                                                       ; Quantidade de caracteres no vetor
    MSG_DIGITE             DB 10, 13, "Digite: $"                                     ; Mensagem para entrada de dados
    MSG_IMPRIMIR           DB 10, 13, "O digitado foi: $"                             ; Mensagem para saída
    MSG_STRINGS_IGUAIS     DB 10, 13, "Os dois strings sao iguais$"
    MSG_STRINGS_DIFERENTES DB 10, 13, "Os dois strings sao diferentes$"
    MSG_SEARCH             DB 10, 13, "Digite uma letra para procurar: $"
    MSG_SEARCH_COMPLETE    DB 10, 13, "Numero de vezes que o caractere aparece: $"
    VETOR                  DB 100 DUP(0)                                              ; Buffer para armazenar string digitado
    COPIA                  DB 100 DUP(0)                                              ; Buffer para armazenar string copiado
    COMPARACAO             DB "Lucas Kitsuta Sabino"                                  ; String fixo para comparação

.CODE
MAIN PROC
                         MOV    AX, @DATA                     ; Inicializa segmento de dados
                         MOV    DS, AX
                         MOV    ES, AX                        ; ES usado em operações de string

                         CALL   LER_ARMAZENAR_STRING          ; Lê e armazena string no vetor
                         CALL   COPIAR_STRING                 ; Copia string do vetor para outro
                         CALL   COMPARAR_STRING               ; Compara o vetor com string fixo
                         CALL   IMPRIMIR_STRING               ; Imprime o conteúdo do vetor
                         CALL   SEARCH_CARACTERE              ; Procura por um caractere no vetor

                         MOV    AH, 4CH                       ; Termina o programa
                         INT    21H
MAIN ENDP

    ; Lê string do teclado e armazena em VETOR
LER_ARMAZENAR_STRING PROC
                         PUSH_4 AX, DI, CX, DX
                         CLD                                  ; Define incremento para operações de string
                         MOV    AH, 9                         ; Função para exibir mensagem
                         LEA    DX, MSG_DIGITE                ; Mostra "Digite:"
                         INT    21H

                         XOR    DX, DX                        ; Zera DX (contador de caracteres)
                         MOV    CX, 100                       ; Limite de 100 caracteres
                         LEA    DI, VETOR                     ; Aponta DI para o buffer VETOR
                         MOV    AH, 1                         ; Função para entrada de caractere

    INPUT_STRING:        
                         INT    21H                           ; Lê um caractere
                         CMP    AL, 13                        ; Enter encerra a entrada
                         JZ     FIM_INPUT
                         CMP    AL, 8H                        ; Backspace
                         JNZ    CONTINUAR

                         DEC    DI                            ; Retrocede no buffer
                         XOR    AL, AL
                         STOSB                                ; Apaga caractere anterior
                         DEC    DX                            ; Decrementa contador
                         DEC    DI                            ; Ajusta ponteiro para próxima entrada
                         JMP    INPUT_STRING

    CONTINUAR:           
                         STOSB                                ; Armazena caractere no buffer
                         INC    DX                            ; Incrementa o contador de caracteres
                         LOOP   INPUT_STRING

    FIM_INPUT:           
                         MOV    TAMANHO_VETOR, DX             ; Salva o número de caracteres digitados
                         POP_4  AX, DI, CX, DX
                         RET
LER_ARMAZENAR_STRING ENDP

    ; Imprime o conteúdo do vetor VETOR
IMPRIMIR_STRING PROC
                         PUSH_4 AX, SI, CX, DX
                         CLD
                         LEA    SI, VETOR                     ; Ponteiro para o vetor
                         MOV    AH, 9
                         LEA    DX, MSG_IMPRIMIR              ; Mostra "O digitado foi:"
                         INT    21H

                         MOV    CX, TAMANHO_VETOR             ; Quantidade de caracteres no vetor
                         CMP    CX, 0                         ; Se vazio, não imprime nada
                         JZ     IMPRIMIR_VAZIO
                         MOV    AH, 2
    OUTPUT_STRING:       
                         LODSB                                ; Carrega caractere de [SI] para AL
                         MOV    DL, AL                        ; Prepara DL para saída
                         INT    21H                           ; Imprime caractere
                         LOOP   OUTPUT_STRING

    IMPRIMIR_VAZIO:      
                         POP_4  AX, SI, CX, DX
                         RET
IMPRIMIR_STRING ENDP

    ; Copia o conteúdo de VETOR para COPIA
COPIAR_STRING PROC
                         PUSH_4 AX, SI, CX, DI
                         LEA    SI, VETOR
                         LEA    DI, COPIA
                         CLD
                         MOV    CX, TAMANHO_VETOR             ; Quantidade de caracteres a copiar
                         CMP    CX, 0
                         JZ     COPIA_VAZIO
    COPY_STRING:         
                         MOVSB                                ; Copia byte de [SI] para [DI]
                         LOOP   COPY_STRING
    COPIA_VAZIO:         
                         POP_4  AX, SI, CX, DI
                         RET
COPIAR_STRING ENDP

    ; Compara o vetor VETOR com COMPARACAO
COMPARAR_STRING PROC
                         PUSH_4 AX, SI, CX, DI
                         LEA    SI, VETOR
                         LEA    DI, COMPARACAO
                         CLD

                         MOV    CX, TAMANHO_VETOR             ; Quantidade de caracteres a comparar
                         CMP    CX, 0
                         JZ     COMPARA_VAZIO
    COMPARE_STRING:      
                         CMPSB                                ; Compara [SI] e [DI]
                         JNZ    DIFERENTE                     ; Se diferente, sai do loop
                         LOOP   COMPARE_STRING

                         LEA    DX, MSG_STRINGS_IGUAIS        ; Strings iguais
                         INT    21H
                         JMP    COMPARA_VAZIO

    DIFERENTE:           
                         LEA    DX, MSG_STRINGS_DIFERENTES    ; Strings diferentes
                         INT    21H

    COMPARA_VAZIO:       
                         POP_4  AX, SI, CX, DI
                         RET
COMPARAR_STRING ENDP

    ; Busca um caractere no vetor e conta suas ocorrências
SEARCH_CARACTERE PROC
                         PUSH_4 AX, SI, CX, DI

                         XOR    BX, BX                        ; Zera contador
                         MOV    CX, TAMANHO_VETOR             ; Quantidade de caracteres no vetor
                         CMP    CX, 0
                         JZ     SEARCH_VAZIO

                         LEA    SI, VETOR                     ; Ponteiro para o vetor
                         CLD
                         MOV    AH, 9
                         LEA    DX, MSG_SEARCH                ; Mostra mensagem para busca
                         INT    21H

                         MOV    AH, 1
                         INT    21H                           ; Lê caractere a ser procurado
                         CMP    AL, 60H
                         JG     LETRA_MINUSCULA               ; Determina maiúscula/minúscula
                         MOV    DH, AL
                         MOV    DL, AL
                         ADD    DL, 20H
                         JMP    SEARCH_STRING

    LETRA_MINUSCULA:     
                         MOV    DH, AL
                         MOV    DL, AL
                         SUB    DH, 20H

    SEARCH_STRING:       
                         LODSB
                         CMP    AL, DH
                         JZ     LETRA_ENCONTRADA
                         CMP    AL, DL
                         JNZ    LETRA_NAO_ENCONTRADA
    LETRA_ENCONTRADA:    
                         INC    BX
    LETRA_NAO_ENCONTRADA:
                         LOOP   SEARCH_STRING

                         MOV    AH, 9
                         LEA    DX, MSG_SEARCH_COMPLETE
                         INT    21H
                         CALL   SAIDADECIMAL                  ; Imprime número de ocorrências
    SEARCH_VAZIO:        
                         POP_4  AX, SI, CX, DI
                         RET
SEARCH_CARACTERE ENDP

    ; Imprime número decimal armazenado em BX
SAIDADECIMAL PROC
                         PUSH_4 AX, BX, CX, DX
                         MOV    AX, BX                        ; Copia número para AX
                         MOV    BX, 10                        ; Base decimal
                         XOR    CX, CX
                         XOR    DX, DX
    OUTPUTDECIMAL:       
                         DIV    BX                            ; Divide por 10
                         PUSH   DX                            ; Empilha resto (dígito)
                         XOR    DX, DX
                         INC    CX
                         OR     AX, AX
                         JNZ    OUTPUTDECIMAL

                         MOV    AH, 2
    IMPRIMIRDECIMAL:     
                         POP    DX                            ; Desempilha dígitos
                         OR     DL, 30H                       ; Converte para ASCII
                         INT    21H
                         LOOP   IMPRIMIRDECIMAL
                         POP_4  AX, BX, CX, DX
                         RET
SAIDADECIMAL ENDP
END MAIN
