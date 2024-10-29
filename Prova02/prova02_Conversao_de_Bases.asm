.MODEL SMALL
.STACK 100H
.DATA
    prompt   DB 'Digite um numero decimal (0-65535): $'
    result   DB 'Numero em hexadecimal: $'
    newline  DB 13, 10, '$'
    errorMsg DB 'Erro: Numero fora do limite! Por favor, insira um numero entre 0 e 65535.$'
    num      DW ?

    HEXSTR   DB '    $'                                                                         ; Buffer para armazenar o hexadecimal

.CODE
MAIN PROC
                      MOV  AX, @DATA
                      MOV  DS, AX
                      MOV  ES, AX

    ; Exibe o prompt
                      LEA  DX, prompt
                      MOV  AH, 9
                      INT  21H

    ; Lê o número decimal do usuário
                      CALL LE_NUMERO_DECIMAL

    ; Verifica se o número está no limite de 16 bits (0 - 65535)
                      CMP  num, 65535
                      JA   FORA_DO_LIMITE

    ; Converte para hexadecimal e exibe
                      MOV  AX, num
                      CALL CONVERTE_HEX

    ; Exibe o resultado
                      LEA  DX, result
                      MOV  AH, 9
                      INT  21H

    ; Exibe o número em hexadecimal
                      LEA  DX, HEXSTR
                      MOV  AH, 9
                      INT  21H

    ; Exibe uma nova linha
                      LEA  DX, newline
                      MOV  AH, 9
                      INT  21H

    ; Finaliza o programa
                      MOV  AH, 4CH
                      INT  21H

    FORA_DO_LIMITE:   
    ; Exibe mensagem de erro
                      LEA  DX, errorMsg
                      MOV  AH, 9
                      INT  21H

    ; Exibe uma nova linha e finaliza o programa
                      LEA  DX, newline
                      MOV  AH, 9
                      INT  21H
                      MOV  AH, 4CH
                      INT  21H

MAIN ENDP

    ;-------------------------------------
    ; Sub-rotina para ler um número decimal
    ;-------------------------------------
LE_NUMERO_DECIMAL PROC
                      MOV  CX, 0                 ; Limpa o valor acumulado
                      MOV  BX, 10                ; Base decimal

    LER_DIGITO:       
                      MOV  AH, 1
                      INT  21H                   ; Lê um caractere

                      CMP  AL, 13                ; Verifica se é Enter
                      JE   FIM_LEITURA

    ; Converte o caractere ASCII para o valor numérico
                      SUB  AL, '0'               ; Transforma o caractere em número
                      MOV  AX, CX                ; Move o valor acumulado para AX
                      MUL  BX                    ; AX = AX * 10 (base decimal)
                      ADD  AX, AX                ; Adiciona o novo dígito
                      MOV  CX, AX                ; Atualiza o valor acumulado

                      JMP  LER_DIGITO

    FIM_LEITURA:      
                      MOV  num, CX               ; Armazena o número final em 'num'
                      RET
LE_NUMERO_DECIMAL ENDP

    ;-------------------------------------
    ; Sub-rotina para converter AX em HEXSTR
    ;-------------------------------------
CONVERTE_HEX PROC
                      MOV  CX, 4                 ; Número de dígitos hexadecimais a exibir
                      LEA  DI, HEXSTR+4          ; Ponteiro para o final da string
                      MOV  BYTE PTR [DI], '$'    ; Adiciona o caractere de terminação

    CONVERTE_LOOP:    
                      DEC  DI
                      MOV  DX, 0
                      DIV  BX                    ; Divide AX por 16 (base hexadecimal)

                      ADD  DL, '0'
                      CMP  DL, '9'
                      JBE  EH_DIGITO
                      ADD  DL, 7                 ; Ajusta letras A-F

    EH_DIGITO:        
                      MOV  [DI], DL
                      DEC  CX
                      JNZ  CONVERTE_LOOP
                      RET
CONVERTE_HEX ENDP

END MAIN
