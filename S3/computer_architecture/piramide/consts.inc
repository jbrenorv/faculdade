; -----------------------------------
; Biblioteca para constantes x86
; -----------------------------------

segment .data
    LF          equ 0xA     ; Line Feed | quebra de linha | '\n'
    NULL        equ 0x0     ; Final da String | Nulo
    EXIT_SUCESS equ 0x0     ; Operação com sucesso
    SYS_EXIT    equ 0x1     ; Código de chamada para finalizar

    STD_IN      equ 0x0     ; Entrada padrão
    STD_OUT     equ 0x1     ; Saída padrão
    STD_ERR     equ 0x2     ; Erro padrão
    
    SYS_READ    equ 0x0     ; read
    SYS_WRITE   equ 0x4     ; write
    SYS_CALL    equ 0x80    ; inteiro final
