title imprimir diagonal de uma matriz
.model small
.data
    matriz db 1,0,0,0
           db 0,2,0,0
           db 0,0,3,0
           db 0,0,0,4
.code
main proc

                     mov  ax,@data
                     mov  ds,ax

                     call imprime_Diagonal

                     mov  ah,4ch
                     int  21h

imprime_Diagonal proc
         
                     lea  si,matriz
                     mov  ah,2
                     mov  cx,4

    loop_Diagonal:   

                     mov  dl,[si]
                     add  dl,30h
                     int  21h
                     add  si,5

                     loop loop_Diagonal
                     
                     ret
imprime_Diagonal endp

main endp
end main
