TITLE sexo_comASSEMBLY
.model small
.stack 100h
.DATA

    MSG1 db 10,13, "Escreva uma letra: $"
    MSG2 db 10,13, "A letra escrita foi: $"
    crc db "*", "$"

.code 
main proc 

mov ax,@data
mov ds,ax 

mov cx,4

loop_1:

mov ah,9
lea dx,MSG1
int 21h

mov ah,1
int 21h ; salva em al
mov bl,al

lea dx,msg2
mov ah,9
int 21h

mov ah,2

cmp bl,41h
jz n_a

cmp bl,61h
jz n_a

 mov dl,bl
int 21h

loop loop_1
jmp fim

n_a:

    lea dx,crc
    mov ah,9
    int 21h

    loop loop_1

fim : 
mov ah,4ch
int 21h


main endp
end main 