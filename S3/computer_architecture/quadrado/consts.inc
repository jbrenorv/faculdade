; -----------------------------------
; Biblioteca para constantes x86
; -----------------------------------

segment .data
    LF          equ 10      ; Line Feed | quebra de linha | '\n'
    NULL        equ 0       ; Final da String | Nulo
    EXIT_SUCESS equ 0       ; Operação com sucesso
    SYS_EXIT    equ 1       ; Código de chamada para finalizar

    STD_IN      equ 0       ; Entrada padrão
    STD_OUT     equ 1       ; Saída padrão
    STD_ERR     equ 2       ; Erro padrão
    
    SYS_READ    equ 0       ; read
    SYS_WRITE   equ 4       ; write
    SYS_CALL    equ 0x80    ; inteiro final
