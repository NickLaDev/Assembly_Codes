TITLE Contador_de_Caracters_Do_While
.model small
.stack 100h
.data
    MSG1 db 10,13, "Digite os caracters dejados. Pressione CR para encerrar. $"
    MSG2 db 10,13, "Vc digitou essa quantidade de caracters (em *):  $"
    ast db "* $"
.code
main proc

    mov ax,@data ;Libera acesso a memoria
    mov ds, ax

    mov cx,0 ;Inicia o contador como 0

    pega_carac:

        inc cx

        lea dx,msg1
        mov ah,9
        int 21h

        mov ah,1
        int 21h
        mov bl,al

        cmp bl,0dh
        jne pega_carac

        dec cx

        mov ah,9
        lea dx,msg2
        int 21h

        lea dx,ast

        cmp cx,0
        je fim
    
    imprimir:

        int 21h

    loop imprimir

    fim:

        MOV ah, 4Ch
        INT 21h

; Fim do procedimento principal
main endp

; Fim do programa
end main