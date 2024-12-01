title menor e maior valor matriz word
.model small
.stack 100h
.data
    matriz dw 1,2,3,4
           dw 5,6,7,8
           dw 9,1,1,1
           dw 1,1,1,19
    menor  db 0
    maior  db 0
.code
main proc

                    mov  ax,@data
                    mov  ds,ax

                    call procura_Valores

                    call imprime_Valores

                    mov  ah,4ch
                    int  21h

main endp

procura_Valores proc

                    xor  bx,bx
                    xor  si,si
                    mov  cx,4

    percore_Colunas:                          ;for que tem que rodar 4x para as colunas
                    push cx
                    xor  bx,bx

                    mov  cx,4
    percore_Linhas:                           ;for que tem que rodar 4x

                    mov  al,menor
                    cmp  matriz[bx][si],ax
                    jb   atualizar_Menor

                    mov  al,maior
                    cmp  matriz[bx][si],ax
                    jg   atualizar_Maior

                    add  bx,2

                    loop percore_Linhas

                    add  si,8
                    pop  cx

                    loop percore_Colunas

                    jmp  fim_Procura

    atualizar_Menor:

                    mov  ax,matriz[bx][si]
                    mov  menor,al

                    add  bx,2

                    loop percore_Linhas

                    add  si,8
                    pop  cx

                    loop percore_Colunas

                    jmp  fim_Procura

    atualizar_Maior:


                    mov  ax,matriz[bx][si]
                    mov  maior,al

                    add  bx,2

                    loop percore_Linhas

                    add  si,8
                    pop  cx

                    loop percore_Colunas

    fim_Procura:    

                    ret
procura_Valores endp

imprime_Valores proc


    ;Dividir até o resultado ser 0

    ;imprime maior:

                    xor  ax,ax
                    xor  dx,dx
                    xor  cx,cx
                    mov  al,maior
                    mov  bx,10

    loop_Maior:     

                    div  bl                   ;Resultado em al e resto em ah
                    inc  cx

                    mov  dl,ah
                    push dx
                    
                    cmp  al,0
                    je   fim_Maior

                    mov  ah,0

                    jmp  loop_Maior

    fim_Maior:      

                    pop  dx

                    mov  ah,2
                    add  dx,30h
                    int  21h


                    loop fim_Maior

                    mov  dl,10
                    int  21h

                    xor  ax,ax
                    xor  dx,dx
                    xor  cx,cx
                    xor  bx,bx
                    mov  al,menor
                    mov  bx,10

    loop_Menor:     

                    div  bl                   ;Resultado em al e resto em ah
                    inc  cx

                    mov  dl,ah
                    push dx
                    
                    cmp  al,0
                    je   fim_Menor

                    mov  ah,0

                    jmp  loop_Menor
                    
    fim_Menor:      

                    pop  dx

                    mov  ah,2
                    add  dx,30h
                    int  21h


                    loop fim_Menor

    ;  fim_Total:

                    ret
imprime_Valores endp

end main