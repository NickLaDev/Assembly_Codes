title pega_e_salva_binario_e_imprime
.MODEL SMALL
.STACK 100H
.DATA
    prompt        DB   'Digite um numero binario (max 16 bits): $'
    newline       DB   0DH, 0AH, '$'                                  ; Carriage Return e Line Feed
    zero          DB   '0', '$'                                       ; Caractere '0'
    one           DB   '1', '$'                                       ; Caractere '1'
    CR            EQU  0DH                                            ; Código ASCII do Carriage Return (Enter)

    START:        
                  MOV  AX, @DATA                                      ; Inicializa segmento de dados
                  MOV  DS, AX

    ; Exibe prompt para o usuário
                  LEA  DX, prompt
                  MOV  AH, 09H
                  INT  21H

    ; Inicializa registrador BX com 0
                  XOR  BX, BX
                  XOR  CX,CX

                  MOV  CX,16

    READ_LOOP:    
    ; Ler caractere do teclado
                  MOV  AH, 01H
                  INT  21H
                  CMP  AL, CR                                         ; Verifica se é CR (fim da entrada)
                  JE   PRINT_BINARY

    ; Verifica se o caractere é '0' ou '1'
                  CMP  AL, '0'
                  JB   READ_LOOP
                  CMP  AL, '1'
                  JA   READ_LOOP                                      ;Verefica se o caracter inserido é 0 ou 1, se nao for, volta a ler

    ; Desloca BX 1 bit à esquerda
                  SHL  BX, 1

    ; Converte caractere '0' ou '1' para valor binário
                  SUB  AL, '0'
                  MOV  AH, 0                                          ; Limpa o registrador AX, mantendo o bit mais baixo
                  OR   BX, AX                                         ; Adiciona o bit em BX

                  DEC  CX
                  JNZ  READ_LOOP

    DONE:         
    ; Adiciona nova linha para formatar a saída
                  LEA  DX, newline
                  MOV  AH, 09H
                  INT  21H

    PRINT_BINARY: 
    ; Inicializa CX com o número de bits lidos (até 16)
                  MOV  CX, 16                                         ; Sempre imprime 16 bits, mesmo que menos tenham sido lidos

    PRINT_LOOP:   
    ; Rotaciona BX 1 bit à esquerda
                  ROL  BX, 1

    ; Verifica o valor do bit que foi para o CF
                  JC   PRINT_ONE                                      ; Se Carry Flag (CF) = 1, imprime '1'

    ; Imprime '0'
                  LEA  DX, zero
                  MOV  AH, 09H
                  INT  21H
                  JMP  CONTINUE_LOOP

    PRINT_ONE:    
    ; Imprime '1'
                  LEA  DX, one
                  MOV  AH, 09H
                  INT  21H

    CONTINUE_LOOP:
                  LOOP PRINT_LOOP                                     ; Repete até CX = 0 (até todos os bits lidos serem exibidos)

    ; Adiciona nova linha para formatar a saída
                  LEA  DX, newline
                  MOV  AH, 09H
                  INT  21H

    ; Finaliza o programa
                  MOV  AH, 4CH
                  INT  21H

END START
