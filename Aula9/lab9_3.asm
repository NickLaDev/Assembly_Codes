TITLE INVERTE_VETOR
.model small
.stack 100h
.data
    MSG1 db 10,13,"Insira os valores do vetor (1 por vez e de 0 a 9) $"
    MSG2 db 10,13,"O vetor inserido foi: $"
    MSG3 db 10,13,"O vetor invertido eh: $" ;Cria todas as variáveis e mensagens para o programa
    vetor db 7 DUP(?)

.code
    MAIN PROC
        
    mov ax,@data
    mov ds,ax ;Libera acesso ao data

    xor si,si ;Limpa si

    pegaVetor:
        
        mov ah,9
        lea dx,MSG1 ;Imprime a mensagem 1
        int 21h

        mov ah,1
        int 21h ;Pega o caracter digitado em salva em AL

        mov vetor[si],al ;Passa o caracter lido para o vetor
        inc si ;Passa para a próxima posição do vetor

        cmp si,6
        jbe pegaVetor ;Roda até a ultima posição do vetor

    lea dx,MSG2
    mov ah,9 ;Imprime a mensagem 2:
    int 21h

    xor si,si ;Limpa si
    mov ah,2 ;Função 2 do int 21h

    imprime_Vetor:

        mov dl,vetor[si]
        int 21h ;Imprime cada posição do vetor
        inc si

        cmp si,6
        jbe imprime_Vetor ;Compara ate rodar 6 vezes, imprimindo todo vetor

        cmp cx,1 ;Compara cx com 1 para indicar que é para encerar o programa
        je fim ;Vai para o fim

    xor si,si
    xor di,di ;Limpa os indexs

    mov di,6
    xor dx,dx ;Limpa dx e coloca di na ultima posição do vetor

    inverte_Vetor:

        mov dl,vetor[si]
        mov dh,vetor[di]

        mov vetor[si],dh
        mov vetor[di],dl ;Inverte as posições do vetor por registradores

        inc si
        dec di ;Passa para as próximas posições do vetor

        cmp si,3
        jbe inverte_Vetor ;Ve se já passou por todas posições do vetor


    xor si,si
    xor dx,dx ;Limpa dx e si

    lea dx, msg3
    mov ah,9
    int 21h ;Imprime a mensagem 3

    mov ah,2
    mov cx,1
    jmp imprime_Vetor ;Imprime o vetor invertido

    fim:

    mov ah,4ch
    int 21h ;Finaliza o programa

    main endp
    end main