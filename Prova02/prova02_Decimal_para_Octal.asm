title pega decimal imprime octal
.model small
.stack 100h
.data
    valor dw 0
.code

main proc

                     mov  ax,@data
                     mov  ds,ax               ;Libera acesso ao barramento de memoria

                     call pegar_Numero        ;Funçao para pegar o vetor

    ;valor = numeros digitados em decimal

    ;->Transformar para hexa decimal

                     mov  bl,8                ;Conversão para base 8, tem que dividir para 8
                     mov  ax,valor
                     xor  dx,dx

    loop_Conversao:  

                     div  bl                  ;Divide Ax por bl ; AH = resto, AL = resultado
                     
                     mov  dl,ah
                     push dx
                     mov  ah,0                ;Zera o resto e deixa ax só como o resultado da divisao

                     cmp  al,0
                     jne  loop_Conversao      ;Tem que dividir o resultado até ele ser 0

    loop_Imprimir:   
    
                     pop  dx                  ;Taca para dx o ultimo resto de divisao

                     cmp  dx,7
                     ja   fim_Divisao
                     cmp  dx,0
                     jb   fim_Divisao         ;Verifica se já terminou a divisao

                     add  dx,30h
                     mov  ah,2
                     int  21h

                     jmp  loop_Imprimir


    fim_Divisao:     

                     mov  ah,4ch
                     int  21h


main endp

pegar_Numero proc

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
    fim_Loop:        



                     ret
pegar_Numero endp

                     end main