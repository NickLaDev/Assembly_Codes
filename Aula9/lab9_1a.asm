TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO BX
.MODEL SMALL
.DATA
    VETOR DB 1, 1, 1, 2, 2, 2    ;Cria um vetor de 6 posições
.CODE
MAIN PROC

                MOV  AX, @DATA
                MOV  DS,AX          ;Libera acesso ao data

                XOR  DL, DL         ;Limpa DL

                call imprime_Vet

                MOV  AH,4CH
                INT  21H            ;saida para o DOS

imprime_Vet proc

                MOV  CX,6           ;Inicializa o contador com 6

                LEA  BX, VETOR      ;Passa o endereço de memoria inical do vetor

    VOLTA:      

                MOV  DL, [BX]       ;Passa para DL a posição do vetor
                INC  BX             ;Vai para a proxima posição da memória

                ADD  DL, 30H
                MOV  AH, 02
                INT  21H            ;Imprime o caracter da posição do vetor

                LOOP VOLTA          ;Loop ate Cx ser 0

                ret

imprime_Vet endp

MAIN ENDP
END MAIN
