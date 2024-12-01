title imprimir matriz transposta
.model small
.stack 100h
.data
    matriz db 1,2,3,5
           db 4,5,6,8    ; 00 - 00 / 10 -> 30 -> 20 ->06
           db 7,8,9,3
           db 1,2,3,4
.code
main proc

                    mov  ax,@data
                    mov  ds,ax

                    call transpor_Matriz

                    mov  cx,16

                    lea  si,matriz
                

    loop_Imprimir:  
                    mov  dl,[si]
                    inc  si
                    mov  ah,2
                    add  dl,30h
                    int  21h

                    loop loop_Imprimir



                    mov  ah,4ch
                    int  21h

main endp

transpor_Matriz proc

                    xor  bx,bx
                    xor  si,si
                    xor  dx,dx
                    xor  ax,ax

    ;[0][0] -> [0][0]
    ;[1][0] -> [0][2]




    ;[0][2] -> [1][0]
    ;[1][2] -> [1][2]

    ;Multiplicar linha por 2 e tacar na coluna
    ;Dividir coluna por 2 e tacar na linha

    ;for para colunas
    ; porem precisa pensar nos que ja foram invertidos

                    mov  cx,3                 ;Colunas -1 ( pq a ultima sempre ja vai estar certa )
                    mov  ax,4

    loop_Colunas:   

                    PUSH cx
    ;for para linhas

                    mov  cx,ax
    loop_Linhas:    

                    mov  dl,matriz[bx][si]

                    push bx
                    push si

                    mov  al,bl
                    mov  bx,4
                    mul  bl
                    mov  bl,al

                    push bx

                    mov  ax,si
                    mov  bx,4

                    div  bl                   ;Resultado esta em al e resto em ah
                    mov  ah,0
                    mov  si,ax
                    pop  bx

                    xchg matriz[si][bx],dl

                    pop  si
                    pop  bx

                    mov  matriz[bx][si],dl

                    inc  bx

                    loop loop_Linhas

                

                    add  si,4

                    pop  cx

                    dec  cx

                    mov  ax,3
                    sub  ax,cx
                    mov  bx,ax
                    mov  dx,4
                    sub  dx,ax
                    mov  ax,dx
                 

    ;  pop  cx

                    cmp  cx,0
                    jne  loop_Colunas

                    ret
transpor_Matriz endp

end main