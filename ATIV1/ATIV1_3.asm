TITLE Atividade1
.MODEL SMALL
.STACK 100h
.DATA
    MSG  DB 'Digite um caractere: $'
    MSG1 DB 10,13,'Caractere inserido: $'
.CODE

MAIN PROC

         MOV AX,@DATA
         MOV DS,AX
        ;Libera o acesso ao .data

         MOV AH,09
         LEA DX,MSG
         INT 21H
        ;Imprime a mensagem 1 para digitar o caracter


         MOV AH,01
         INT 21H
        ;Le o caracter digitado e salva em AL
         MOV BL,AL
        ;Salva o caracter em BL

         MOV AH,09
         LEA DX,MSG1
         INT 21H
        ;Imprime a mensagem 2 de qual caracter foi digitado


         MOV DL,BL
         MOV AH,02
         INT 21H
        ;Imprime o caracter digitado.

         MOV AH,4Ch
         INT 21H
         ;Finaliza o programa

MAIN ENDP
END MAIN