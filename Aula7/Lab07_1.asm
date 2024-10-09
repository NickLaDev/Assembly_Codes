title divisao
.model small
.stack 100h

.data
 MSG1 db 'Digite o dividendo: $'
 MSG2 db 10,13,'Digite o divisor: $'
 MSG3 db 10,13,'Quociente: $'
 MSG4 db 10,13,'Resto: $'
 .code
main proc

    mov ax,@data ;Libera acesso a memoria
    mov ds, ax

    mov ax,9
    lea dx,MSG1
    int 21h ;Imprime a msg1

    mov ah,1
    int 21h
    sub al,30h
    mov bl,al ;Le um caracter e salva em bl

    mov ax,9
    lea dx,MSG2
    int 21h ;Imprime a msg2

    mov ah,1
    int 21h
    sub al,30h
    mov bh,al ;Le um caracter e salva em bh

    calculo:
    
    sub bl,bh
    cmp bl,bh
    inc cx
    jae calculo ; Realiza o calculo da divisão

    lea dx,MSG3
    mov ax,9
    int 21h ;Imprime a msg3

    mov dl,bl
    add dl,30h
    mov ah,1
    int 21h

    lea dx,MSG4
    mov ax,9
    int 21h ;Imprime a msg4

    mov dl,bh
    add dl,30h
    mov ah,1
    int 21h

    MOV ah, 4Ch
    INT 21h

; Fim do procedimento principal
main endp

; Fim do programa
end main

    






    