title impressao e soma de matriz
.model small
.stack 100h
.data
    matriz db 1,2,3,4    ;=10
           db 0,1,0,0    ;=1
           db 1,5,0,0    ;=6
           db 1,2,5,7    ;=15
.code
main proc
                    mov  ax,@data
                    mov  ds,ax

                    call pegar_Matriz

                    call imprimir_Matriz

                    call somar_Matriz

                    call imprimir_Soma

                    mov  ah,4ch
                    int  21h

main endp

pegar_Matriz proc

                    xor  si,si
                    mov  cx,4
                    mov  ah,1

    loop_Colunas2:  
                    push cx
                    mov  cx,4
                    xor  bx,bx
    loop_Linhas2:   

                    int  21h
                    sub  al,30h
                    mov  byte ptr matriz[bx][si],al
                    inc  bx
                    loop loop_Linhas2

                    add  si,4

                    mov  ah,2
                    mov  dl,10
                    int  21h

                    mov  ah,1
                    pop  cx
                    loop loop_Colunas2


                    ret
pegar_Matriz endp

imprimir_Matriz proc

                    xor  si,si
                    xor  bx,bx
                    mov  cx,4
                    mov  ah,2

    loop_Colunas:   

                    push cx
                    mov  cx,4
                    xor  bx,bx

    loop_Linhas:    

                    mov  dl,matriz[bx][si]
                    inc  bx
                    add  dl,30h
                    int  21h
                    loop loop_Linhas

                    pop  cx
                    add  si,4
                    mov  dl,10
                    int  21h
                    loop loop_Colunas


                    ret
imprimir_Matriz endp

somar_Matriz proc

                    xor  bx,bx
                    xor  dx,dx
                    xor  si,si
                    mov  cx,4

    loop_Colunas1:  
                    push cx
                    mov  cx,4
                    xor  bx,bx
    loop_Linhas1:   
                    add  dl,matriz[bx][si]
                    inc  bx
                    loop loop_Linhas1

                    pop  cx
                    add  si,4
                    loop loop_Colunas1

                    ret
somar_Matriz endp

imprimir_Soma proc

                    mov  bx,10
                    mov  ax,dx
                    xor  dx,dx
                    xor  cx,cx

                   

    divisoes:       
                    div  bl
    ;ah esta com o resto ( dar push ) e al com resultado ( dividir dnv )
                    inc  cx
                    mov  dl,ah
                    push dx
                    mov  ah,0
                    cmp  al,0                          ;Ate resultado ser 0
                    jne  divisoes
                    mov  ah,2
    imprimir:       
                    pop  dx
                    add  dx,30h
                    int  21h
                    loop imprimir

                    ret
imprimir_Soma endp

end main