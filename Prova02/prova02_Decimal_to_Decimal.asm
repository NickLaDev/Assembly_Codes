title pega decimal imprime decimal
.model small
.stack 100h
.data
    valor dw 0
.code

main proc

                     mov  ax,@data
                     mov  ds,ax               ;Libera acesso ao barramento de memoria

                     mov  ah,1
                     xor  dx,dx
                     xor  cx,cx               ;Prepara para pegar os numeros

    loop_pega_numero:

                     MOV  AH,1
                     int  21h                 ; Salvo em al o valor inserido

                     cmp  al,0dh
                     je   fim_loop

                     sub  al,30h              ;Transforma no numero absoluto

                     mov  dl,al               ;Dl tem o numero que acabou de ser digitado

                     mov  ax,valor
                     mov  bl,10
                     mul  bl                  ; multiplica al por bx e salva em ax
                     
                     add  ax,dx               ;Salva o novo numero
                     mov  valor,ax

                     jmp  loop_pega_numero

                     

    fim_loop:                                 ;Agora temos que imprimir a varialvel valor

                     mov  ax,valor

                     xor  bx,bx
                     mov  bl,10
                     xor  dx,dx

                     div  bl                  ;Divide ax pelo valor digitado e salva o resultado em al e o resto em ah

                     mov  dl,ah               ;Salva o resto em dl

                     push dx                  ;Joga o resto na pilha

                     mov  ah,0                ;zera a parte alta do ax para poder passar sem lixo para o "valor"

                     mov  valor,ax            ;Atualiza oque ainda precisa ser divido

                     cmp  al,10
                     jae  fim_loop            ;Ve se já terminou as divisoes (resultado > 10)

    ;passou por aqui terminou a divsao

                     xor  dx,dx
                     mov  dl,al
                     mov  ah,2
                     add  dl,30h
                     int  21h                 ;Imprime o primeiro numero que o resultado da ultima divisao

    imprimir:        
                     pop  dx
                     add  dx,30h

                     cmp  dx,39h              ;Imprime os restos das divisoes, faz isso ate parar de achar numeros de 0 a 9 na pilha
                     ja   acabou

                     cmp  dx, 30h
                     jb   acabou


                     int  21h
                     jmp  imprimir
                    
    acabou:          

                     mov  ah,4ch              ;Encerra o programa
                     int  21h

main endp
end main

