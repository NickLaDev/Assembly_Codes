title troca 1 linha para 4 coluna
.model small
.stack 100h
.data
    matriz db 1,1,1,4
           db 2,2,2,4
           db 0,0,0,4
           db 3,3,3,4    ;[0][0]->[3][0]
    ; 10 - 34
    ;20 - 38
.code
main proc
                   mov  ax,@data
                   mov  ds,ax
                   mov  es,ax

    ;xchg nas posicoes

                   xor  si,si
                   xor  bx,bx
                   xor  di,di
                   xor  bp,bp
    ; mov  di,3
                   mov  cx,4

    loop_Inverte:  

                   mov  dl,matriz[bx][0]
                   xchg dl,matriz[3][si]
                   mov  matriz[bx][0],dl
                   add  bx,1
                   add  si,4



                   loop loop_Inverte

                   mov  cx,16
                   lea  si,matriz
    loop_Impressao:

                   mov  dl,[si]
                   inc  si
                   add  dl,30h
                   mov  ah,2
                   int  21h

                   loop loop_Impressao


                   mov  ah,4ch
                   int  21h


main endp
end main