title pegar uma matriz e somar sua diagonal
.model small
.stack 100h
.data
    matriz db 9 dup (?)
.code
main proc

                        mov  ax,@data
                        mov  ds,ax

                        call pega_Matriz

                        call soma_Diagonal          ;Bx esta com a soma

                        call imprime_Soma

                        mov  ah,4ch
                        int  21h

main endp

pega_Matriz proc

                        xor  bx,bx
                        mov  cx,9
                        mov  ah,1
                        lea  si,matriz

    loop_Matriz:        

                        int  21h
                        sub  al,30h
                        mov  byte ptr [si],al
                        inc  si
                        inc  bx
                        cmp  bx,3
                        je   pular_Linha
                        loop loop_Matriz

    pular_Linha:        
                        mov  ah,2
                        mov  dl,10
                        int  21h
                        mov  ah,1
                        xor  bx,bx

                        loop loop_Matriz


                        ret
pega_Matriz endp

soma_Diagonal proc

                        lea  si,matriz
                        xor  bx,bx
                        mov  cx,3

    loop_Diagonal:      
                        add  bl,[si]
                        add  si,4
                        loop loop_Diagonal

                        ret
soma_Diagonal endp

imprime_Soma proc

                        mov  dl,bl
                        add  dl,30h
                        cmp  dl,"9"
                        ja   dois_Digitos

                        mov  ah,2
                        int  21h

                        jmp  fim_Impressao
                  

    dois_Digitos:       

    ;Tem que ficar dividindo por 10
                        xor  ax,ax
                        xor  bx,bx
                        xor  cx,cx

                        mov  al,dl
                        sub  al,30h
                        mov  bl,10

    loop_Impressao:     
                        div  bl                     ;Salva o resultado em al e o resto em ah
                
                        mov  cl,ah
                        mov  ah,0
                        push cx

                        cmp  al,0
                        jne  loop_Impressao

    loop_pops_and_bangs:
                        xor  dx,dx
                        pop  dx

                        cmp  dx,9
                        ja   fim_Impressao
                        cmp  dx,0
                        jb   fim_Impressao

                        mov  ah,2
                        add  dl,30h
                        int  21h

                        jmp  loop_pops_and_bangs


    fim_Impressao:      
                        ret
imprime_Soma endp

end main
