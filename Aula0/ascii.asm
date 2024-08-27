TITLE   EXIBICAO DE CARACTERES ASCII
.MODEL  SMALL
.DATA
    LF EQU 0Ah
    CR EQU 0Dh
    pula_linha db LF,CR,'$'
    espaco db ' $'
.STACK   100H
.CODE
;inicializacao de alguns registradores
;
main proc
        MOV AX,@DATA
        MOV DS,AX
        
    
        MOV CX,256      ;contador com o numero total de caracteres
        MOV DL,00H          ;DL inicializado com o primeiro ASCII
        MOV BL,16
;
;definicao de um processo repetitivo de 256 vezes
;
PRINT_LOOP:
            MOV AH,2                ;funcao DOS para exibicao de caracter
            INT 21H                 ;exibir caracter na tela
            INC DL                  ;incrementa o caracter ASCII
            MOV BH,DL
            LEA DX, espaco
            MOV AH,09H
            INT 21H
            MOV DL,BH
            dec bl 
            jnz print_loop
            ;DEC CX
            ;decrementa o contador
            MOV BH,DL
            LEA DX, pula_linha
            MOV AH,09H
            INT 21H
            mov bl,16
            mov dl,bh
            LOOP PRINT_LOOP  ;continua exibindo enquanto CX nao for 0
;
;quando CX = 0, o programa quebra a sequencia do loop   ;saida para o DOS
;
        MOV AH,4CH
        INT 21H
main endp
END main
