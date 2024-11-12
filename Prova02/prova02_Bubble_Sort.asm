title buble sort
.model small
.stack 100h
.data
    vetor db 1,3,8,2,7,5    ;Orndenar e ficar 1,2,3,5,7,8
.code

main proc

                      mov  ax,@data
                      mov  ds,ax

                      mov  cx,6                 ;Quantos numeros ha no vetor
                      lea  si,vetor

                      mov  di,si
                      add  di,5
                      

    loop_Roda_Vetor:  
    
                      lea  si,vetor
                      xor  dx,dx
                      xor  bx,bx

                      push cx

                      mov  bx,6
                      sub  bx,cx
                      add  si,bx

                      mov  cx,6
                      sub  cx,bx

                      mov  dl,[si]


    loop_Verifica:    

                      cmp  dl,[si]
                      jb   atualizar_Posicao

                      inc  si

                      loop loop_Verifica

                      jmp  proximo

    atualizar_Posicao:

                      xchg [si],dl
                      mov  ax,si
                      mov  bx,6
                      sub  bx,cx
                      sub  si,bx
                      mov  [si],dl
                      mov  si,ax

                      loop loop_Verifica

    proximo:          

                      pop  cx

                      loop loop_Roda_Vetor

                      lea  si,vetor
                      mov  dl,[si]
                      add  dl , 30h
                      mov  ah,2
                      int  21h
                      inc  si
                      mov  dl,[si]
                      add  dl , 30h
                      mov  ah,2
                      int  21h
                      inc  si
                      mov  dl,[si]
                      add  dl , 30h
                      mov  ah,2
                      int  21h


                      mov  ah,4ch
                      int  21h

main endp

end main