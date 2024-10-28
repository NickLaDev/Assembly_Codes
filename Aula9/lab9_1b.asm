.MODEL SMALL 
.DATA
        VETOR DB 1, 1, 1, 2, 2, 2        ; Cria vetor de 6 posições
.CODE
MAIN PROC

                    MOV  AX, @DATA
                    MOV  DS,AX                ;Libera acesso ao data

                    XOR  DL, DL               ;Limpa DL

                    call imprime_Vet
      
                    MOV  AH,4CH
                    INT  21H                  ;saida para o DOS


imprime_Vet proc

                    MOV  CX,6                 ;Inicializa o contador como 6

                    XOR  BX, BX               ;Limpa BX

        VOLTA:      

                    MOV  DL, VETOR[BX]        ;Acessa o vetor na posição que BX está
                    INC  BX                   ;Vai para a próxima posição do vetor

                    ADD  DL, 30H
                    MOV  AH, 02
                    INT  21H                  ;Imprime o vetor na posição desejada

                    LOOP VOLTA                ;Loop ate cx ser 0

                    ret
imprime_Vet endp


MAIN ENDP
        END MAIN

        ;A diferença do programa A para B é quem em A utilizamos BX para armazenar o endereço de memória do vetor
        ;(como se fosse um ponteiro) em B, acessamos diretamente o vetor na posição desejada (BX)