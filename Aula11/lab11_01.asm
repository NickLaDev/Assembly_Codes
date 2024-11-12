title Conversor de Bases
.model small

push_all macro

             push ax
             push bx
             push cx
             push dx
endm

pop_all macro

            pop dx
            pop cx
            pop bx
            pop ax

endm

    ; Aqui começam as macros
salto_linha macro
                push_all
   
    ; Usa a interrupção 21h para imprimir uma nova linha
                mov      ah, 2
                mov      dl, 10    ; Caractere de nova linha (LF)
                int      21h
                mov      dl, 13    ; Caractere de retorno de carro (CR)
                int      21h

                pop_all
endm

mostrar_pedir macro                    ; Macro que mostra uma mensagem e espera uma entrada do usuário
    ; Lembrando que dx precisa ter o endereço da mensagem
                  mov         ah, 9    ; Mostra a mensagem usando a interrupção 21h
                  int         21h

                  salto_linha          ; Pula uma linha para deixar o console mais organizado

                  mov         ah, 1    ; Espera um caractere do usuário
                  int         21h
endm

.data
    msg1       db "Escolha a base de entrada do numero:",10,"1. Binario",10,"2. Decimal",10,"3. Hexadecimal$"
    msg2       db "Selecione a base de saida desejada:",10,"1. Binario",10,"2. Decimal",10,"3. Hexadecimal$"
    tabela_hex db 30h, 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h                                               ; Tabela com caracteres ASCII de 0 a 9
               db 41h, 42h, 43h, 44h, 45h, 46h                                                                   ; Tabela com caracteres ASCII de A a F

.stack 100h
.code
main proc
                    mov           ax, @data          ; Inicializando o segmento de dados
                    mov           ds, ax

    ; Pegando o endereço da primeira mensagem
                    lea           dx, msg1
    ; Pegando o endereço da segunda mensagem
                    lea           si, msg2
    ; Chama a rotina para escolher as bases
                    call          escolha_bases

    ; Finaliza o programa corretamente
                    mov           ah, 4ch
                    int           21h
main endp

    ; Procedimento para escolher as bases de entrada e saída
escolha_bases proc
                    push_all
    
                    mostrar_pedir                    ; Mostra a mensagem e espera a entrada do usuário
                    salto_linha                      ; Pula uma linha para melhorar a visualização

                    cmp           al, 31h            ; Compara se o usuário escolheu '1' (Binário)
                    jz            entrada_bin

    ; Agora, verifica se o usuário escolheu Decimal
                    cmp           al, 32h
                    jz            entrada_dec

    entrada_hex:    
                    call          recebe_hex         ; Se chegou aqui, é Hexadecimal, chama a rotina apropriada
                    jmp           processar_saida    ; Vai para a próxima parte do processo
    
    entrada_dec:    
                    call          recebe_dec         ; Chama a rotina para entrada Decimal
                    jmp           processar_saida    ; Continua o processo
    
    entrada_bin:    
                    call          recebe_bin         ; Chama a rotina para entrada Binária
    processar_saida:
                    salto_linha                      ; Pula outra linha para organizar
                    mov           dx, si             ; Pega o endereço da mensagem de saída
                    mostrar_pedir                    ; Mostra a mensagem para escolher a base de saída

                    salto_linha                      ; Mais uma linha em branco para espaçar

    ; Verifica se o usuário escolheu Binário como saída
                    cmp           al, 31h
                    jz            exibir_bin
    ; Verifica se o usuário escolheu Decimal como saída
                    cmp           al, 32h
                    jz            exibir_dec

    exibir_hex:     
                    call          mostrar_hex        ; Se não é Binário ou Decimal, deve ser Hexadecimal
                    jmp           fim_processo       ; Termina o processo de conversão
    
    exibir_dec:     
                    call          mostrar_dec        ; Chama a rotina para mostrar em Decimal
                    jmp           fim_processo       ; Termina o processo de conversão
    
    exibir_bin:     
                    call          mostrar_bin        ; Chama a rotina para mostrar em Binário

    fim_processo:   
    ; Restaura os valores originais dos registradores
                    pop_all
                    ret
escolha_bases endp

    ; Procedimento para receber um número Binário e armazená-lo em bx
recebe_bin proc
                    push          ax
                    push          cx
                    xor           bx, bx             ; Limpa bx para garantir que começamos do zero
                    mov           ah, 1
                    mov           cx, 16             ; Lê até 16 bits (tamanho de um número Binário de 16 bits)

    le_bin:         
                    int           21h                ; Recebe o próximo caractere
                    cmp           al, 0dh            ; Verifica se é o Enter (fim da entrada)
                    jz            saida_bin          ; Se for Enter, sai do loop
                    and           al, 0fh            ; Converte o caractere para um valor numérico
                    shl           bx, 1              ; Desloca bx 1 bit à esquerda
                    or            bl, al             ; Adiciona o bit lido a bx
                    loop          le_bin             ; Continua até cx chegar a zero
    saida_bin:      
                    pop           cx
                    pop           ax
                    ret
recebe_bin endp

    ; Procedimento para mostrar o número armazenado em bx no formato Binário
mostrar_bin proc
                    push_all

                    mov           cx, 16             ; Número de bits a serem mostrados
                    mov           ah, 2
    exib_bins:      
                    shl           bx, 1              ; Desloca bx à esquerda
                    jc            bit_um             ; Se o carry estiver definido, é um bit '1'
                    mov           dl, 30h            ; Caso contrário, é um bit '0'
                    jmp           imprimir_bins
    bit_um:         
                    mov           dl, 31h            ; Define dl para o caractere '1'
    imprimir_bins:  
                    int           21h                ; Imprime o bit atual
                    loop          exib_bins          ; Repete até cx ser zero
                    pop_all
                    ret
mostrar_bin endp

    ; Procedimento para receber um número Decimal e armazená-lo em bx
recebe_dec proc
                    push          ax
                    xor           bx, bx             ; Limpa bx para começar do zero
                    mov           ah, 1

    le_dec:         
                    int           21h                ; Recebe o próximo caractere
                    cmp           al, 13             ; Verifica se é Enter
                    jz            saida_dec          ; Sai do loop se for Enter
                    push          ax                 ; Salva ax na pilha
                    mov           ax, 10
                    mul           bx                 ; Multiplica bx por 10 para ajustar a posição decimal
                    mov           bx, ax             ; Guarda o resultado em bx
                    pop           ax                 ; Restaura ax
                    and           al, 0fh            ; Converte o caractere para um valor numérico
                    add           bl, al             ; Adiciona o número ao total em bx
                    jmp           le_dec
    saida_dec:      
                    pop           ax
                    ret
recebe_dec endp

    ; Procedimento para mostrar o número armazenado em bx no formato Decimal
mostrar_dec proc
                    push_all

                    mov           di, 10             ; Usaremos 10 como divisor para a conversão
                    xor           cx, cx             ; Limpa cx, que conta os dígitos
                    mov           ax, bx             ; Copia o valor de bx para ax
                    xor           dx, dx             ; Limpa dx para a divisão
    prepara_dec:    
                    div           di                 ; Divide ax por 10 (quociente em ax, resto em dx)
                    push          dx                 ; Guarda o dígito (resto) na pilha
                    xor           dx, dx             ; Limpa dx
                    inc           cx                 ; Incrementa o contador de dígitos
                    or            ax, ax             ; Verifica se ax ainda tem algum valor
                    jnz           prepara_dec        ; Continua até ax ser zero
    
                    mov           ah, 2              ; Função de impressão de caractere
    imprime_dec:    
                    pop           dx                 ; Recupera o dígito da pilha
                    or            dl, 30h            ; Converte o dígito para o caractere ASCII
                    int           21h                ; Imprime o caractere
                    loop          imprime_dec        ; Repete até não haver mais dígitos

                    pop_all
                    ret
mostrar_dec endp

    ; Procedimento para receber um número Hexadecimal e armazená-lo em bx
recebe_hex proc
                    push_all

                    xor           bx, bx             ; Limpa bx
                    mov           ah, 1
                    mov           cx, 4              ; Espera até 4 dígitos hexadecimais
    le_hex:         
                    int           21h                ; Recebe o próximo caractere
                    cmp           al, 0dh            ; Verifica se é Enter
                    jz            saida_hex          ; Sai do loop se for Enter
                    shl           bx, 4              ; Desloca bx 4 bits à esquerda para o próximo dígito
                    cmp           al, 39h            ; Verifica se o caractere é maior que '9'
                    jg            conv_letra_hex     ; Se for, converte as letras (A-F)
                    and           al, 0fh            ; Converte números de 0-9 para valores numéricos
                    jmp           soma_hex
    conv_letra_hex: 
                    sub           al, 37h            ; Converte letras A-F para valores de 10-15
    soma_hex:       
                    or            bl, al             ; Adiciona o valor convertido em bx
                    loop          le_hex
    saida_hex:      
                    pop_all
                    ret
recebe_hex endp

    ; Procedimento para mostrar o número armazenado em bx no formato Hexadecimal
mostrar_hex proc
                    push_all

                    mov           ah, 2              ; Função de impressão de caractere
                    mov           cx, 4              ; Vamos exibir 4 dígitos hexadecimais
    exib_hex:       
                    mov           dl, bh             ; Pega o byte mais significativo de bx
                    shr           dl, 4              ; Desloca dl 4 bits para a direita
                    push          bx                 ; Salva bx na pilha
                    lea           bx, tabela_hex     ; Carrega a tabela de caracteres hexadecimais
                    xchg          al, dl             ; Troca al com dl
                    xlat                             ; Converte o valor para o caractere ASCII
                    xchg          al, dl             ; Troca de volta
                    pop           bx                 ; Restaura bx
                    shl           bx, 4              ; Desloca bx para a próxima metade
                    int           21h                ; Imprime o caractere
                    loop          exib_hex           ; Repete até cx ser zero
                    pop_all
                    ret
mostrar_hex endp

end main
