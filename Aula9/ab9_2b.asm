TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI 
.MODEL SMALL 
.DATA 
    VETOR DB  1, 1, 1, 2, 2, 2 ;Cria um vetor de 6 posições
.CODE 
MAIN PROC 

        MOV AX, @DATA 
        MOV DS,AX ;Libera acesso ao .DATA

        XOR DL, DL ;Limpa DL

        MOV CX,6 ;Incializa o contador com 6

        XOR DI, DI ;Limpa DI

VOLTA:    

        MOV DL, VETOR[DI] ;Transfere a posição do vetor para DL utilizando DI como index
        INC DI ;Vai para a próxima posição do index

        ADD DL, 30H 
        MOV AH, 02 
        INT 21H ;Imprime o vetor no index da vez

        LOOP VOLTA ;Loop até cx ser 0

        MOV AH,4CH 
        INT 21H             ;saida para o DOS 

MAIN ENDP 
        END MAIN 
 