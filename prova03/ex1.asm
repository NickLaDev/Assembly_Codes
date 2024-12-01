title quantidade de numeros maiores que 15 em um vetor
.model small
.stack 100h
.data
    vetor db 10 dup(?)
.code
main proc
    ;utilizaremos o comando scasb com cld

                       mov  ax,@data
                       mov  ds,ax

    ;tem que preencher o vetor
                       lea  si,vetor

                       call pegar_Vetor

                       call testar_Numeros

                       add  dl,30h

                       mov  ah,2
                       int  21h

                       mov  ah,4ch
                       int  21h
main endp

pegar_Vetor proc

                       mov  cx,10                 ;tem que pegar 10 valores

    loop_Geral:        
                       mov  ah,1
                       xor  dx,dx
                       mov  bl,10
                       push cx


    loop_Pegar:        

                       xor  cx,cx
                       mov  cx,10

                       mov  ah,1
                       int  21h                   ;Al esta com o valor

                       cmp  al,0dh
                       je   fim_Pegar

                       sub  al,30h

                       mov  bl,al

                       mov  ah,0
                       mov  al,dl
                       mul  cx                    ;Multiplica oq esta em al pelo valor colacado
                       mov  dl,al

                       mov  al,bl

                       add  dl,al

                       jmp  loop_Pegar

                

    fim_Pegar:         

                       pop  cx

                       mov  [si],dl
                       inc  si

                       loop loop_Geral

                       ret
pegar_Vetor endp

testar_Numeros proc

                       lea  si,vetor

                       mov  cx,11
                       xor  dx,dx

    inicio_Verificacao:

                       dec  cx
                       cmp  cx,0
                       je   fim_Comparacao

                       cmp  byte ptr[si],15
                       jg   maior_15

                       inc  si

                       jmp  inicio_Verificacao

    maior_15:          
                       inc  dx
                       inc  si

                       jmp  inicio_Verificacao
                   
    fim_Comparacao:    
                       ret
testar_Numeros endp

end main