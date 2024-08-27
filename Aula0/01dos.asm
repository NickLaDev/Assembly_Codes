Title imprimi uma string (cadeia de caracter)
.model small
.data 
    texto1 db 'Contagem Regressiva:',13,10,'$'
    texto2 db '','$'
.code
main proc

mov ax,@data
mov ds,ax

mov cx,10
mov dl,30h
mov ah,2


mov dx,offset texto1
mov ah,9
int 21h

mov dx,offset texto2
mov ah,9
int 21h

mov ah,2
mov dl,30h
imprime:
    int 21h

    mov bl,dl
    mov dl,10
    int 21h

    mov dl,bl
    inc dl
loop imprime

mov ah,4ch
int 21h

main endp
end main




