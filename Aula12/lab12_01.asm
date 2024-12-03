title manipulacaom de strings
.model small
.stack 100h
.data
    str1   db 11 dup (?)
    str1_c db 11 dup (?)
    msg1   db 10,13,"nao eh igual$"
    msg2   db 10,13,"igual$"
    str2   db "abcdabcdab$"
    q_A    db 0
.code
main proc

                    mov   ax,@data
                    mov   ds,ax
                    mov   es,ax

                    cld

                    call  pegar_String

                    call  copiar_String

                    call  comparar_String

                    call  contar_A

                    mov   ah,4ch
                    int   21h
main endp

pegar_String proc

                    lea   di,str1
                    mov   cx,10
                    mov   ah,1

    loop_Pegar:     
                    int   21h
                    stosb
                    loop  loop_Pegar

                    mov   al,"$"
                    stosb

                    ret
pegar_String endp

copiar_String proc

                    lea   si,str1
                    lea   di,str1_c

                    mov   cx,11
                    rep   movsb

                    ret
copiar_String endp

comparar_String proc

                    lea   di,str1
                    lea   si,str2

                    mov   cx,11
                    repe  cmpsb
                    cmp   cx,0
                    je    Igual

                    lea   dx,msg1
                    mov   ah,9
                    int   21h
                
                    jmp   fim

    Igual:          

                    lea   dx,msg2
                    mov   ah,9
                    int   21h
    fim:            
                    ret
comparar_String endp

contar_A proc
    
                    mov   al,"a"
                    lea   di,str1
                    mov   cx,10

    continuar:      
                    repne scasb
                    jz    achou
                    jmp   fim_P

    achou:          
                    inc   q_A
                    jmp   continuar

    fim_P:          
                    ret
contar_A endp

end main
