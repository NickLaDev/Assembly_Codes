title contagem de letras a na string
.model small
.stack 100h
.data
    string db "nicolas laredo alves$"
.code
main proc

                  mov  ax,@data
                  mov  ds,ax

                  lea  si,string

                  call contagem

                  call imprime_Tela

                  mov  ah,4ch
                  int  21h



contagem proc

                  mov  cx,20
                  xor  bx,bx

    loop_contagem:
    
                  mov  dl,[si]
                  cmp  dl,"a"
                  jne  pula_contagem

                  inc  bx

    pula_contagem:
                  inc  si

                  loop loop_contagem

                  ret
contagem endp

imprime_Tela proc

                  mov  ah,2
                  mov  dx,bx
                  add  dx,30h
                  int  21h


                  ret
imprime_Tela endp

        
main endp
end main