title soma matriz
.model small
.stack 100h
.data
    matriz      db 1,0,1,2
                db 1,0,1,0
                db 1,0,1,0
                db 1,0,1,0
    soma_Linha  db ?,?,?,?
    soma_Coluna db ?,?,?,?
.code
main proc

                   mov  ax,@data
                   mov  ds,ax

                   call soma_Linhas

                   call soma_Colunas

                   mov  dl,soma_Coluna[2]
                   add  dx,30h
                   mov  ah,2
                   int  21h

                   mov  ah,4ch
                   int  21h

main endp

soma_Linhas proc

                   lea  di,soma_Linha
                   mov  cx,4
    proxima_Linha: 
                   push cx
                   mov  cx,4
                   xor  bx,bx
                   xor  dx,dx
    percore_Linha: 

                   add  dl,matriz[bx][si]

                   inc  bx

                   loop percore_Linha

                   mov  byte ptr[di],dl
                   inc  di
                   pop  cx
                   add  si,4

                   loop proxima_Linha

                   ret
soma_Linhas endp

soma_Colunas proc

                   xor  si,si
                   xor  bx,bx
                   xor  dx,dx
                   lea  di,soma_Coluna
                   mov  cx,4

    proxima_Coluna:

                   push cx
                   mov  cx,4
    percore_Coluna:

                   add  dl,matriz[bx][si]
                   add  si,4

                   loop percore_Coluna
                   mov  byte ptr[di],dl
                   inc  di
                   pop  cx
                   xor  si,si
                   xor  dx,dx
                   inc  bx
                   loop proxima_Coluna

                   ret
soma_Colunas endp
end main