.model small
.stack 100h
.data
    v1       db 1,5,8,9,7,2,3    ; Vetor 1
    v2       db 1,6,7,9,2,6,4    ; Vetor 2
    q_Iguais db 0                ; Quantidade de elementos iguais
    n_Iguais db 7 dup(?)         ; Valores iguais encontrados
.code
main proc

    ; Inicializa os segmentos
                   mov  ax, @data
                   mov  ds, ax

    ; Chama a sub-rotina de comparação
                   call comparar_Vetor

    ; Exibe a quantidade de iguais
                   mov  dl, q_Iguais
                   add  dl, 30h             ; Converte para ASCII
                   mov  ah, 2
                   int  21h

    ; Termina o programa
                   mov  ah, 4ch
                   int  21h
main endp

comparar_Vetor proc

                   lea  si, v2              ; Ponteiro para o vetor v2
                   xor  bp, bp              ; Índice para n_Iguais
                   mov  q_Iguais,0          ; Zera a contagem
                   mov  cx, 7               ; Tamanho do vetor v2

    compara_v2:    
    ; Para cada elemento em v2, busca em v1
                   mov  al, [si]            ; Carrega o elemento atual de v2 em AL
                   lea  di, v1              ; Ponteiro para o início de v1
                   mov  dx, 7               ; Tamanho do vetor v1

    procurar_v1:   
                   cmp  al, [di]            ; Compara AL com o elemento de v1
                   je   achou               ; Se igual, vai para achou
                   inc  di                  ; Avança para o próximo elemento de v1
                   dec  dx                  ; Decrementa o contador
                   jnz  procurar_v1         ; Continua enquanto há elementos em v1
                   jmp  continua            ; Não achou, vai para o próximo de v2

    achou:         
    ; Incrementa a quantidade de iguais
                   inc  q_Iguais
    ; Armazena o valor igual encontrado
                   mov  n_Iguais[bp], al
                   inc  bp

    continua:      
    ; Avança para o próximo elemento de v2
                   inc  si
                   loop compara_v2          ; Continua até comparar todos de v2

                   ret
comparar_Vetor endp

end main
