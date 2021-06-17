; ---------------------------
; Quadrados
; ---------------------------

%include 'consts.inc'

section .data
    star    db '*', LF, NULL
    side    equ 2

section .text

global _start

_start:
    mov edi, side
    .whileLoop:
        call printLine
        sub edi, 1
        cmp edi, 0
        jle exit
        loop .whileLoop

exit:
    mov eax, SYS_EXIT       ; diz que a operação será de exit
    mov ebx, EXIT_SUCESS    ; indica que executou com sucesso
    int SYS_CALL            ; avisa ao kernel

; FUNCAO: imprime (side) estrelas
printLine:
    mov esi, side
    .whileLoop:
        sub esi, 1
        
        cmp esi, 0
        jle last

        call printStar
        loop .whileLoop

last:
    call printLastStar
    ret

printStar:
    mov edx, 1          ; tamanho da string
    mov ecx, star       ; a string
    mov eax, SYS_WRITE  ; diz que a operação será de escrita
    mov ebx, STD_OUT    ; indica onde escrever
    int SYS_CALL        ; manda escrever
    ret

printLastStar:
    mov edx, 2          ; tamanho da string
    mov ecx, star       ; a string
    mov eax, SYS_WRITE  ; diz que a operação será de escrita
    mov ebx, STD_OUT    ; indica onde escrever
    int SYS_CALL        ; manda escrever
    ret
