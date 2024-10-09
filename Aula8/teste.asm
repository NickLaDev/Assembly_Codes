.model small
.stack 100h
.data
    msg_in db 'Digite um numero hexadecimal (ate 4 digitos): $'
    msg_out db 'Numero hexadecimal lido: $'
.code
start:
    ; Inicializa DS e segmento de código
    mov ax, @data
    mov ds, ax
    
    ; Exibe mensagem de entrada
    mov ah, 9
    lea dx, msg_in
    int 21h

    ; Inicializa BX em 0
    xor bx, bx    ; Limpa o registrador BX

read_loop:
    ; Ler caractere do teclado
    mov ah, 1     ; Função de leitura de caractere
    int 21h       ; Chama interrupção do DOS
    ; Verifica se é ENTER (CR = 0Dh)
    cmp al, 0Dh
    je output_hex

    ; Converte caractere de ASCII para valor hexadecimal
    cmp al, '0'
    jl read_loop    ; Se menor que '0', ignora
    cmp al, '9'
    jg check_alpha  ; Se maior que '9', checa se é letra
    sub al, '0'     ; Converte '0'-'9' para 0-9
    jmp shift_left
    
check_alpha:
    cmp al, 'A'
    jl read_loop    ; Se menor que 'A', ignora
    cmp al, 'F'
    jg read_loop    ; Se maior que 'F', ignora
    sub al, 'A' 
    add al, 10      ; Converte 'A'-'F' para 10-15

shift_left:
    ; Desloca BX 4 bits à esquerda para acomodar o novo valor
    shl bx, 4
    ; Limpa AH para garantir que somente AL seja adicionado
    mov ah, 0
    ; Insere o valor convertido em BX (apenas os 8 bits de AL)
    add bx, ax
    jmp read_loop

output_hex:
    ; Exibe mensagem de saída
    mov ah, 9
    lea dx, msg_out
    int 21h
    
    ; Inicializa contador para exibir os 4 dígitos hexadecimais
    mov cx, 4

print_loop:
    ; Copia o valor dos 4 bits mais significativos para DL
    mov dl, bh
    shr dl, 4       ; Desloca os 4 bits mais significativos para os 4 bits inferiores

    ; Se DL < 10, converte para caractere '0' a '9'
    cmp dl, 9
    jbe convert_digit
    ; Caso contrário, converte para 'A' a 'F'
    add dl, 7       ; Agora DL está entre 10-15, então ajusta para 'A'-'F'

convert_digit:
    ; Adiciona '0' para converter de valor numérico para caractere ASCII
    add dl, '0'

    ; Exibe o caractere
    mov ah, 2
    int 21h

    ; Desloca BX 4 bits à esquerda para processar o próximo dígito
    shl bx, 4
    dec cx
    jnz print_loop

    ; Finaliza o programa
    mov ah, 4Ch
    int 21h

end start
