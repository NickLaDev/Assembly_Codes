title valor medio de um vetor
.model small
.stack 100h
.data
    vetor db 1,2,3,1,2,0
.code
main proc

               mov   ax,@data
               mov   ds,ax
               mov   es,ax
               xor   dx,dx
    ;usar lodsb para tacar do vetor para al

               lea   si,vetor
               mov   cx,6
               cld

    calc_Media:
               lodsb

               add   dl,al

               loop  calc_Media

               
               mov   ah,2
               add   dl,30h
               int   21h

               mov   ah,4ch
               int   21h

main endp
end main