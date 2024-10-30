title conta quantos numeros impares e pares tem num vetor
.model small
.stack 100h
.data
    vetor db 20 dup(?)
.code

main proc

                         mov  ax,@data
                         mov  ds,ax

                         call pega_Vetor

                         call contar_Pares_Impares

                         call imprime_Resultado

                         mov  ah,4ch
                         int  21h

main endp

pega_Vetor proc

                         lea  si,vetor
                         mov  ah,1
                         mov  cx,20

    loop_Pega_Vetor:     

                         int  21h
                         cmp  al,0dh
                         je   fim_Pegar

                         sub  al,30h
                         mov  byte ptr [si],al
                         inc  si

                         loop loop_Pega_Vetor

    fim_Pegar:           

                         ret
pega_Vetor endp

contar_Pares_Impares PROC
                         mov  bx, 20
                         sub  bx, cx                  ; Calcula quantas vezes precisa rodar
                         mov  cx, bx
                         lea  si, vetor               ; Aponta SI para o início do vetor
                         xor  bx, bx                  ; Zera BX (BH = pares, BL = ímpares)

    loop_Contagem:       
                         mov  al, [si]                ; Carrega o valor do vetor em AL
                         test al, 1                   ; Testa o bit menos significativo (par/ímpar)
                         jz   par_Encontrado          ; Se ZF = 1, é par

                         inc  bl                      ; Incrementa a contagem de ímpares
                         jmp  continuar_Loop

    par_Encontrado:      
                         inc  bh                      ; Incrementa a contagem de pares

    continuar_Loop:      
                         inc  si                      ; Avança para o próximo elemento do vetor
                         loop loop_Contagem           ; Decrementa CX e repete o loop se CX > 0

                         ret
contar_Pares_Impares ENDP


imprime_Resultado proc

                         mov  ah,2
                         mov  dl,10
                         int  21h

                         mov  dl,bl
                         add  dl,30h
                         int  21h

                         mov  dl,10
                         int  21h

                         mov  dl,bh
                         add  dl,30h
                         int  21h

                         ret
imprime_Resultado endp

end main