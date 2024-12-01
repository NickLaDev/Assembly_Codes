title remover valor de um vetor
.model small
.data
    v1   db 1,2,3,4,5
.code
main proc

                  mov   ax,@data
                  mov   ds,ax
                  mov   es,ax

                  mov   ah,1               ;Pega valor que vai ser apagado
                  int   21h                ;al esta com o valor a ser retirado
                  sub   al,30h

                  call  apaga_Valor

                  call  imprime_Valor

    fim:          
                  mov   ah,4ch
                  int   21h

main endp

apaga_Valor proc

                  lea   di,v1
                  cld
                  mov   cx,7

                  repne scasb
                  jz    remover_Valor

                  jmp   fim

    remover_Valor:

                  mov   ah,1
                  int   21h
                  lea   dx,v1
                  add   dx,5
                  push  di

                  dec   di

                  sub   dx,di              ;calcula valor de quantas casas precisam ser reposicionadas
                  mov   cx,dx

    loop_Apaga:   

                  mov   dl,[di+1]
                  mov   byte ptr[di],dl
                  inc   di

                  loop  loop_Apaga

                  pop   di


                  ret
apaga_Valor endp

imprime_Valor proc

                  lea   si,v1
                  mov   cx,5
    loop_Imprime: 
                  mov   ah,2
                  mov   dl,[si]
                  add   dl,30h
                  int   21h
                  inc   si
                  loop  loop_Imprime


                  ret
imprime_Valor endp

end main