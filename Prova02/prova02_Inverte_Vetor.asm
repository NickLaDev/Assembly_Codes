title inverte vetor
.model small
.stack 100h
.data
    vetor db 10 dup (?)
.code
main proc

                      mov  ax,@data
                      mov  ds,ax

                      call pega_Vetor

                      call inverte_Vetor

                      call imprime_Vetor



                      mov  ah,4ch
                      int  21h

main endp

pega_Vetor proc

                      lea  si,vetor
                      mov  ah,1
                      mov  cx,10

    loop_Pega_Vetor:  
                      int  21h

                      cmp  al,0dh
                      je   fim_Pegar

                      mov  byte ptr [si],al
                      inc  si

                      loop loop_Pega_Vetor

    fim_Pegar:        

                      ret
pega_Vetor endp

inverte_Vetor proc

                      xor  bx,bx

                      lea  si,vetor

                      mov  bx,10
                      sub  bx,cx                ;Descobrir quantas vezes precisa inveter + a posicao do di

                      push bx

                      mov  ax,bx
                      mov  bx,2
                      div  bl                   ;Resultado esta em al

                      xor  cx,cx
                      mov  cl,al

                      pop  bx

                      mov  ax,bx                ;Salvar quantos numeros foram digitados em ax para usar depois usar para quantos numeros serao impressos
                      add  bx,si
                      mov  di,bx
                      dec  di

                      xor  dx,dx

    loop_Inverte:     
                     
                      mov  dl,[si]
                      xchg dl,[di]

                      mov  byte ptr [si],dl

                      inc  si
                      dec  di

                      loop loop_Inverte


                      ret
inverte_Vetor endp

imprime_Vetor proc

                      mov  cx,ax
                      lea  si,vetor
                      mov  ah,2
                      mov  dl,10
                      int  21h

    loop_Imprimir_Vet:

                      mov  dl,[si]
                      int  21h
                      inc  si

                      loop loop_Imprimir_Vet


                      ret
imprime_Vetor endp

end main