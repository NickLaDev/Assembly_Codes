TITLE   PROG PARA IMPRESSAO DE 'STRING'
.MODEL  SMALL
.STACK  100H
.DATA
    MSG     DB    'ALO! Como voces estao indo!$'
.CODE
MAIN    PROC
;
;inicializando o registrador DS
;
        MOV AX,@DATA
        MOV DS,AX    ;segmento dados inicializado
;
;obtendo offset posi??o  mem?ria de Msg
   
        LEA DX,MSG   ;offset endere?o vai para DX
                     ;exibindo a MENSAGEM
;
        MOV AH,9     ;funcao DOS para exibir 'string'
        INT 21H         ;exibindo
;
;retorno ao DOS
;
        MOV AH,4CH    ;funcao DOS para saida
        INT 21H              ;saindo
MAIN    ENDP
        END MAIN
