title teste de impressao
.model small
.stack 100h
.data
    MSG1 db "Bem Vindo ao Batalha Naval: $"
.code
main proc
    mov ax,@data
    mov ds,ax


    limpa_Tela proc

        MOV AH,0                        
        MOV AL,3
        INT 10H

    limpa_Tela endp

    MOV BH, 00h   ; Número da página de vídeo (geralmente 00h)
    MOV BL, 0ch   ; Atributo de cor (1Eh = fundo amarelo, texto azul claro)
    lea si,msg1


    imprime proc


        mov ah,2
        mov dh,0
        mov dl,27
        int 10h

        impressao_Loop:

        mov al,[si]
        MOV AH, 09h   ; Função para escrever caractere e atributo
        MOV CX, 1  ; Número de vezes para escrever o caractere
        INT 10h       ; Chama a interrupção de vídeo
        inc si

        mov ah,3 ;dh=linha dl=coluna
        int 10h
        inc dl
        mov ah,2
        int 10h

        mov dx,[si]
        cmp dx,'$'
        jne impressao_Loop

    imprime endp

    mov ah,4ch
    int 21h


    main endp
    end main
