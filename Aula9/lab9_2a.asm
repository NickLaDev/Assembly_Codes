TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI 
.MODEL SMALL 
.DATA
        VETOR DB 1, 1, 1, 2, 2, 2        ;Cria um vetor de 6 posições
.CODE
MAIN PROC

                    MOV  AX, @DATA
                    MOV  DS,AX              ;Libera acesso ao data

                    XOR  DL, DL             ;Limpa dl

                    call imprime_Vet


                    MOV  AH,4CH
                    INT  21H                ;saida para o DOS

imprime_Vet proc

                    MOV  CX,6               ;Inicializa cx como 6

                    LEA  SI, VETOR          ;Passa o endereço de memoria para o index SI

        VOLTA:      
                    MOV  DL, [SI]           ;Acessa o endereço de memória armazenado em SI ( Vetor )
                    INC  SI                 ; Vai para a próxima posição da memória ( próxima posição do vetor )

                    ADD  DL, 30H
                    MOV  AH, 02             ;Imprime o vetor na posição desejada
                    INT  21H

                    LOOP VOLTA              ;Loop até cx ser 0 ( Vetor por completo )
        
                    ret
imprime_Vet endp

MAIN ENDP
        END MAIN