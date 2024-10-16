TITLE INVERTE_VETOR
.model small
.stack 100h
.data
    MSG1 db 10,13,"Insira os valores do vetor (1 por vez e de 0 a 9) $"
    MSG2 db 10,13,"O vetor inserido foi: $"
    MSG3 db 10,13,"O vetor invertido eh: $"
    vetor db 7 DUP(?)

.code
    MAIN PROC
        
    mov ax,@data
    mov ds,ax ;Libera acesso ao data

    ;xor cx,cx ;Limpa cx
    ;mov cx,7 ;Inicializa cx com o tamanho do vetor

    xor si,si

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

    xor si,si
    mov ah,2

    imprime_Vetor:

        mov dl,vetor[si]
        int 21h ;Imprime cada posição do vetor
        inc si

        cmp si,6
        jbe imprime_Vetor ;Compara ate rodar 6 vezes, imprimindo todo vetor

        cmp cx,1
        je fim

    xor si,si
    xor dx,dx

    push_Vetor:

        mov dl, vetor[si]
        push dx ;Joga os valores do vetor para a pilha
        inc si ;Vai para a próxima posição do vetor

        cmp si,6
        jbe push_Vetor ;Roda 6 vezes para jogar todos os valores do vetor

    xor si,si
    xor dx,dx

    pop_Vetor :

        pop dx ;Tira os valores da pilha e joga no vetor, e, pelo funcionamento da pilha, já nos dá o vetor invertido
        mov vetor[si],dl
        inc si ;Vai para a próxima posição de si, e assim, do vetor

        cmp si,6
        jbe pop_Vetor ;Roda 6 vezes para passar por todas posições do vetor

    xor si,si
    xor dx,dx

    lea dx, msg3
    mov ah,9
    int 21h

    mov ah,2
    mov cx,1
    jmp imprime_Vetor

    fim:

    mov ah,4ch
    int 21h ;Finaliza o programa

    main endp
    end main