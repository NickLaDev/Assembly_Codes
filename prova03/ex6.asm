title comparacao de vetores e retorno da quantidade e valores
.model small
.stack 100h
.data
    v1       db 1,5,8,9,7,2,3
    v2       db 1,6,7,9,2,6,4
    q_Iguais db 0
    n_Iguais db 7 dup(?)
.code
main proc

                   mov   ax,@data
                   mov   ds,ax
                   mov   es,ax

                   call  comparar_Vetor

                   mov   dl,q_Iguais
                   add   dl,30h
                   mov   ah,2
                   int   21h

                   mov   ah,4ch
                   int   21h
main endp

comparar_Vetor proc

                   lea   di,v1
                   lea   si,v2
                   xor   bp,bp
                   mov   Cx,7

                   
                   cld

    ;Vamos utilizar lod e sca
    segundo_Vetor: 
                   PUSH  CX
                   lea   di,v1
                   mov   cx,7
                   lodsb                    ;oque esta em si vai para al

    procurando:    
                   mov   ah,0
                   repne scasb              ;compara di com al
    ;ou cx = 0 ou achou igual
                   cmp   cx,0
                   je    proximo
 
                   add   q_Iguais,1
                   mov   dl,[di-1]
                   mov   n_Iguais[bp],dl
                   inc   bp
                   jmp   procurando

    proximo:       
                   POP   CX
                   LOOP  SEGUNDO_vETOR
    fim_Procura:   
                   ret
comparar_Vetor endp

end main