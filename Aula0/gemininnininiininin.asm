Title imprimi uma string (cadeia de caracter)

.model small
.data
    texto1 db 'Contagem Regressiva:', 13, 10, '$'
    texto2 db '','$'
    texto3 db 'Fim da contagem.', 13, 10, '$'

.code
main proc

mov ax, @data
mov ds, ax

mov cx, 10
mov dl, '0'
mov ah, 2

mov dx, offset texto1
mov ah, 9
int 21h

mov dx, offset texto2
mov ah, 9
int 21h

mov ah, 2
mov dl, '0'
imprime:
    int 21h

    mov bl, dl
    mov dl, 10
    int 21h

    mov dl, bl
    inc dl
loop imprime

mov dx, offset texto3
mov ah, 9
int 21h

mov ah, 4ch
int 21h

main endp
end main