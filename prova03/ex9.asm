title calculo sequencia de fibo
.model small
.stack 100h
.data
    fibo db 0
.code
main proc

              mov  ax,@data
              mov  ds,ax

    ;f(0) = 0
    ;f(1) = 1

              mov  ah,1
              int  21h          ;al esta com o valor
              sub  al,30h

              call calc_Fibo

              mov  dl,fibo
              mov  ah,2
              add  dl,30h
              int  21h

              mov  ah,4ch
              int  21h

main endp
calc_Fibo proc

              cmp  al,0
              je   zero

              cmp  al,1
              je   um

              mov  cl,al
              sub  cl,1
              mov  fibo,1
              xor  dx,dx

    loop_calc:
              mov  dh,fibo
              add  fibo,dl
              mov  dl,dh
              loop loop_calc

              jmp  fim

    zero:     
              mov  fibo,0
              jmp  fim

    um:       
              mov  fibo,1

    fim:      
              ret
calc_Fibo endp
end main