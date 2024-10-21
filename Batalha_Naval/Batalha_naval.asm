title teste de impressao
.model small

push_all macro
             push ax
             push BX
             push cx
             push Dx
             push si
             push di
endm

pop_all macro
            pop di
            pop si
            pop dx
            pop cx
            pop bx
            pop ax
endm

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
    MSGINTRO1                  db "Bem vindo ao jogo de batalha naval! $"
    MSGINTRO2                  db "Regras para jogar: $"
    MSGINTRO3                  db "Terao de ser inseridos 1 encouracado, 1 fragata, 2 submarinos e 2 hidroavioes $"
    MSGINTRO4                  db "Encourada -> Ocupa 4 posicoes em linha reta $"
    MSGINTRO5                  db "Fragata -> 3 posicoes em linha reta $"
    MSGINTRO6                  db "Submarino -> 2 posicoes em linha reta $"
    MSGINTRO7                  db "Hidroaviao -> 3 posicoes em linha reta e uma na horizonta no meio dessas $"
    MSGINTRO8                  db "O jogador deve posicionar cada embarcacao com uma distancia minima de uma casa $"
    MSGINTRO9                  db "Ganha quem acertar o todos os navios do openente $"
    MSGINTRO10                 db "Pressione qualquer tecla para continuar! $"

    quebra_Linha               db 10,13,"$"
    ;------------------------------------------Mensagens-------------------------------------------------------------------------------------------------;
    MSGPEGARNOME               db "Digite o seu nome: $"
    ;--------------------------------------Declaracao das matrizes que serao utilizadas como tabuleiro-------------------------------------------------------------------------------------;
    matriz_Jogador             db 10 dup (10 dup (0))
    matriz_Adversario          db 10 dup (10 dup(0))
    matriz_Controle_Jogador    db 10 dup (10 dup (0))
    matriz_Controle_Adversario db 10 dup (10 dup (0))
    colunas                    db "[1] [2] [3] [4] [5] [6] [7] [8] [9] [10] $"
    colunas2                   db "1  2  3  4  5  6  7  8  9  10 $"
    linhas                     db "A B C D E F G H I$"
    DIV_1                      DB 218,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,191,"$"    ;Usando codigos ASCII para impressao
    DIV_2                      DB 192,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,217,"$"    ;das matrizes utilizadas no jogo
    DIV_3                      DB 195,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,180,"$"
    DIV_4                      DB 179, 10 dup (3 dup (" "), 179)
    ;--------------------------------------Variaveis de ambiente-------------------------------------------------------------------------------------------------------------------;

    nome_Jogador               db 15 dup (?)

    ;-----------------------------------------------------------------------------------------------------------------------------------------------------------------;
.code

main proc

                            mov      ax,@data
                            mov      ds,ax                      ;Libera acesso ao .DATA

    ;------------------------------------------------------TELA_INCIAL--------------------------------------------------------------------------;

                            call     limpa_Tela

                            move_XY  25,0                       ;Coloca o cursor no centro da tela

                            call     imprimir_Introducao        ;Imprime a introdução e fica travado até apertar alguma tecla

                            call     limpa_Tela                 ;Limpa tela apos sair da proc de cima

                            call     pega_Nome                  ;Pega o nome do jogador

                            call     limpa_Tela                 ;Limpa a tela

                            call     Imprime_tabuleiro          ;Começa a posiconar os navios
    
    ;---------------------------------FIM_DO_PROGRAMA--------------------------------------------------------------------------------------;
    
                            jmp      fim

    ;--------------------------------Procedimentos:----------------------------------------------------------------------------------------;
    
limpa_Tela proc                                                 ;Procedimento que limpa a tela:

                            push     ax
                            push     bx
                            push     cx
                            push     dx

                            MOV      AH,0
                            MOV      AL,3
                            INT      10H

                            pop      dx
                            pop      cx
                            pop      bx
                            pop      ax

                            ret


limpa_Tela endp

                
    ;------------------------------------------------------------------------------------------------------------------------------------;
imprime_Letras proc                                             ;Procedimento para impressao de caracters
    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )

                            push     ax
                            push     bx
                            push     cx
                            push     dx

                            MOV      BH, 00h                    ; Número da página de vídeo (geralmente 00h)


    impressao_Loop:         

                            mov      al,[si]
                            MOV      AH, 09h                    ; Função para escrever caractere e atributo
                            MOV      CX, 1                      ; Número de vezes para escrever o caractere
                            INT      10h                        ; Chama a interrupção de vídeo

                            mov      ah,3                       ;dh=linha dl=coluna
                            int      10h
                            inc      dl
                            mov      ah,2                       ;Passa o curso uma posicao para o lado
                            int      10h

                            inc      si
                            mov      dl,[si]
                            cmp      dl,"$"
                            jnz      impressao_Loop             ;Compara para ver se já terminou a string

                            call     pula_Linha                 ;Passa para a próxima linha dps da impressao

                            pop      dx
                            pop      cx
                            pop      bx
                            pop      ax

                            ret

imprime_Letras endp

imprime_Letras_Vertical proc

    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )

                            push     ax
                            push     bx
                            push     cx
                            push     dx

                            MOV      BH, 00h                    ; Número da página de vídeo (geralmente 00h)


    impressao_Loop_Vertical:

                            mov      al,[si]
                            MOV      AH, 09h                    ; Função para escrever caractere e atributo
                            MOV      CX, 1                      ; Número de vezes para escrever o caractere
                            INT      10h                        ; Chama a interrupção de vídeo

                            mov      ah,3                       ;dh=linha dl=coluna
                            int      10h
                            inc      dh
                            mov      ah,2                       ;Passa o curso uma posicao para o lado
                            int      10h

                            inc      si
                            mov      dl,[si]
                            cmp      dl,"$"
                            jnz      impressao_Loop_Vertical    ;Compara para ver se já terminou a string

                            call     pula_Linha                 ;Passa para a próxima linha dps da impressao

                            pop      dx
                            pop      cx
                            pop      bx
                            pop      ax

                            ret

imprime_Letras_Vertical endp

pula_Linha proc

                            push     ax
                            push     bx
                            push     cx
                            push     dx

                            mov      ah,9
                            lea      dx,quebra_Linha
                            int      21h

                            pop      dx
                            pop      cx
                            pop      bx
                            pop      ax

                            ret
pula_Linha endp

imprimir_Introducao proc

                            MOV      BL, 0ch                    ; Atributo de cor (0ch = texto vermelho)
                            lea      si,msgintro1
                            call     imprime_Letras

                            call     pula_Linha

                            MOV      BL, 0eh                    ; Atributo de cor (0Eh = texto amarelo)
                            lea      si,msgintro2
                            call     imprime_Letras

                            call     pula_Linha

                            lea      si,msgintro3
                            call     imprime_Letras

                            lea      si,msgintro4
                            call     imprime_Letras

                            lea      si,msgintro5
                            call     imprime_Letras

                            lea      si,msgintro6
                            call     imprime_Letras

                            lea      si,msgintro7
                            call     imprime_Letras

                            lea      si,msgintro8
                            call     imprime_Letras

                            lea      si,msgintro9
                            call     imprime_Letras

                            mov      bl,0bh
                            ADD      BL,128                     ;Faz ficar piscando
                            lea      si,msgintro10
                            move_XY  22,12
                            call     imprime_Letras

                            mov      ah,1
                            int      21h


                            ret

imprimir_Introducao endp

pega_Nome proc

                            move_XY  30,5
                            lea      si,MSGPEGARNOME
                            mov      bl,0ah
                            call     imprime_Letras

                            mov      ah,1
                            lea      si,nome_Jogador
                            move_XY  36,6
    loop_Letras:            

                            int      21h
                            cmp      al,13
                            je       fim_Loop
                            mov      [si],al
                            inc      si
                            jmp      loop_Letras

                        
    fim_Loop:               
                            mov      bx,"$"
                            mov      [si],bx

                            ret

pega_Nome endp

Imprime_tabuleiro proc

                            move_XY  35,5
                            lea      si,colunas
                            mov      bl,2h
                            call     imprime_Letras

                            move_XY  32,7
                            lea      si,linhas
                            mov      bl,3h
                            call     imprime_Letras_Vertical

                            move_XY  34,5
                            lea      si,div_1
                            call     imprime_Letras
                            move_XY  34, 6
                            lea      si, div_4
                            call     imprime_Letras

                            push_all
                            mov      Dx, 7
                            mov      cx,8
    Imprime_meio:           
                            move_XY  34,dl
                            lea      si, DIV_3
                            call     imprime_Letras
                            inc      dx
                            move_XY  34,dl
                            lea      si, div_4
                            call     imprime_Letras
                            inc      dx
                            loop     Imprime_meio
                            pop_all

                            move_XY  34, 21
                            lea      si, DIV_3
                            call     imprime_Letras

                            move_XY  34, 22
                            lea      si, div_4
                            call     imprime_Letras

                            move_XY  34, 23
                            lea      si, DIV_2
                            call     imprime_Letras

                            ret

Imprime_tabuleiro endp

    fim:                    
                            mov      ah,4ch
                            int      21h


main endp
    end main
