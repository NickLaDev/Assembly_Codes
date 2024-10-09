TITLE Contador_de_Caracters
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

    pega_carac: ; Label para pegar os carac

        lea dx,msg1
        mov ah,9 ;Imprime a MSG1
        int 21h

        mov ah,1
        int 21h ;Pega caracter
        mov bl,al

        cmp bl,0dh
        je saida_loop ;Verefica se foi digitado CR
        
        inc cx
        jmp pega_carac ;Continua o loop e conta

    saida_loop: ;Label para sair do loop

        mov ah,9
        lea dx,msg2 ;Imprime a mensagem 2
        int 21h

        lea dx,ast

        cmp cx,0
        je fim ;Vererica se nada foi digitado
    
    imprimir:

        int 21h

    loop imprimir ;Loop de imprimir

    fim:

        MOV ah, 4Ch
        INT 21h

; Fim do procedimento principal
main endp

; Fim do programa
end main