title teste de impressao
.model small

move_XY macro x,y        ;Macro para pocionar o cursor numa posicao desejada

            push ax
            push bx
            push cx
            push dx

            mov  ah,2
            mov  dh,y
            mov  dl,x
            int  10h

            pop  dx
            pop  cx
            pop  bx
            pop  ax
endm

.stack 100h
.data
    ;---------------------------MENSAGENS_DE_INTRODUCAO-------------------------------------------------------------------------------------------;
    MSGINTRO1         db "Bem vindo ao jogo de batalha naval! $"
    MSGINTRO2         db "Regras para jogar: $"
    MSGINTRO3         db "Terao de ser inseridos 1 encouracado, 1 fragata, 2 submarinos e 2 hidroavioes $"
    MSGINTRO4         db "Encourada -> Ocupa 4 posicoes em linha reta $"
    MSGINTRO5         db "Fragata -> 3 posicoes em linha reta $"
    MSGINTRO6         db "Submarino -> 2 posicoes em linha reta $"
    MSGINTRO7         db "Hidroaviao -> 3 posicoes em linha reta e uma na horizonta no meio dessas $"
    MSGINTRO8         db "O jogador deve posicionar cada embarcacao com uma distancia de uma casa minima entra elas em todos os sentidos $"
    MSGINTRO9         db "Ganha quem acertar o todos os navios do openente $"
    quebra_Linha      db 10,13,"$"
    ;--------------------------------------Declaracao das matrizes que serao utilizadas como tabuleiro-------------------------------------------------------------------------------------;
    matriz_Jogador    db 10 dup (10 dup (0))
    matriz_Adversario db 10 dup (10 dup(0))
            
.code

main proc

                        mov     ax,@data
                        mov     ds,ax                  ;Libera acesso ao .DATA

    ;------------------------------------------------------TELA_INCIAL--------------------------------------------------------------------------;

                        call    limpa_Tela

                        move_XY 25,0                   ;Coloca o cursor no centro da tela

                        call    imprimir_Introducao
    
    ;---------------------------------FIM_DO_PROGRAMA--------------------------------------------------------------------------------------;
    
                        jmp     fim

    ;--------------------------------Procedimentos:----------------------------------------------------------------------------------------;
    
limpa_Tela proc                                        ;Procedimento que limpa a tela:

                        push    ax
                        push    bx
                        push    cx
                        push    dx

                        MOV     AH,0
                        MOV     AL,3
                        INT     10H

                        pop     dx
                        pop     cx
                        pop     bx
                        pop     ax

                        ret


limpa_Tela endp

                
    ;------------------------------------------------------------------------------------------------------------------------------------;
imprime_Letras proc                                    ;Procedimento para impressao de caracters
    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )

                        push    ax
                        push    bx
                        push    cx
                        push    dx

                        MOV     BH, 00h                ; Número da página de vídeo (geralmente 00h)


    impressao_Loop:     

                        mov     al,[si]
                        MOV     AH, 09h                ; Função para escrever caractere e atributo
                        MOV     CX, 1                  ; Número de vezes para escrever o caractere
                        INT     10h                    ; Chama a interrupção de vídeo

                        mov     ah,3                   ;dh=linha dl=coluna
                        int     10h
                        inc     dl
                        mov     ah,2
                        int     10h

                        inc     si
                        mov     dl,[si]
                        cmp     dl,"$"
                        jnz     impressao_Loop

                        call    pula_Linha

                        pop     dx
                        pop     cx
                        pop     bx
                        pop     ax

                        ret

imprime_Letras endp

pula_Linha proc

                        push    ax
                        push    bx
                        push    cx
                        push    dx

                        mov     ah,9
                        lea     dx,quebra_Linha
                        int     21h

                        pop     dx
                        pop     cx
                        pop     bx
                        pop     ax

                        ret
pula_Linha endp

imprimir_Introducao proc

                        MOV     BL, 0ch                ; Atributo de cor (0ch = texto vermelho)
                        lea     si,msgintro1
                        call    imprime_Letras

                        call    pula_Linha

                        MOV     BL, 0eh                ; Atributo de cor (0Eh = texto amarelo)
                        lea     si,msgintro2
                        call    imprime_Letras

                        call    pula_Linha

                        lea     si,msgintro3
                        call    imprime_Letras

                        lea     si,msgintro4
                        call    imprime_Letras

                        lea     si,msgintro5
                        call    imprime_Letras

                        lea     si,msgintro6
                        call    imprime_Letras

                        lea     si,msgintro7
                        call    imprime_Letras

                        lea     si,msgintro8
                        call    imprime_Letras

                        lea     si,msgintro9
                        call    imprime_Letras

                        ret

imprimir_Introducao endp

    fim:                
                        mov     ah,4ch
                        int     21h


main endp
    end main
