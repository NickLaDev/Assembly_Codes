title soma dos elementos de um vetor
.model small
.stack 100h
.data
    vetor db 8 dup (?)
.code
main proc

                      mov  ax,@data
                      mov  dx,ax

                      call pega_Vetor

                      call soma_Vetor

                      call imprime_Resultado


                      mov  ah,4ch
                      int  21h

main endp

pega_Vetor proc

                      lea  si,vetor
                      mov  ah,1
                      mov  cx,8

    loop_Pega_Vetor:  
                      int  21h
                      sub  al,30h
                      mov  byte ptr [si],al
                      inc  si
                      loop loop_Pega_Vetor

                      ret
pega_Vetor endp

soma_Vetor proc

                      mov  cx,8
                      xor  bx,bx
                      lea  si,vetor
    loop_Soma:        
                   
                      add  bx,[si]
                      inc  si

                      loop loop_Soma

                      ret
soma_Vetor endp

imprime_Resultado proc

                      mov  dl,10
                      mov  ah,2
                      int  21h

                      mov  dl,bl
                      cmp  dl,9
                      jg   dois_Digitos

                      add  dl,30h
                      int  21h
                      jmp  fim

    dois_Digitos:     

                      xor  ax,ax
                      xor  bx,bx
                      xor  cx,cx

                      mov  al,dl
                      mov  bl,10

    loop_Divisao:     
                      div  bl                   ;Divide ax por al e salva o resultado em al e o resto em ah

                      mov  cl,ah
                      mov  ah,0
                      push cx

                      cmp  al,0
                      jne  loop_Divisao

                      xor  dx,dx
                      mov  ah,2

    loop_Impressao:   
                      pop  dx

                      cmp  dl,9
                      jg   fim
                      cmp  dl,0
                      jb   fim

                      add  dl,30h
                      int  21h

                      jmp  loop_Impressao

    fim:              
                      ret
imprime_Resultado endp

end main