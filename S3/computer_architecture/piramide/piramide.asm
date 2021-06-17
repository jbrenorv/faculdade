; ---------------------------
; Piramide       *
;               ***
;              *****
;               ...
; ---------------------------

%include 'consts.inc'

section .data
    asterisc    db '*', LF, NULL
    space       db ' ', LF, NULL
    height      equ 5

section .text

global _start

_start:
    mov edi, height
    .whileLoop:
        sub edi, 1
        call printSpaces
        call printAsteriscs

        cmp edi, 0
        jle exit

        loop .whileLoop

exit:
    mov eax, SYS_EXIT       ; diz que a operação será de exit
    mov ebx, EXIT_SUCESS    ; indica que executou com sucesso
    int SYS_CALL            ; avisa ao kernel

; -------------------------------------
; Função.: Printa espaços
; -------------------------------------
; Entrada: ESI a quantidade de espaços
; -------------------------------------
printSpaces:
    mov     esi, edi
    .whileLoop:
        cmp esi, 0
        jle retorne
        
        call printSpace
        sub esi, 1
        loop .whileLoop

; ------------------------------------------------------
; Função.........: Printa asteriscos
; ------------------------------------------------------
; Entrada........: EDI o numero da linha atual.
; Num da primeira: height - 1
; Num da ultima..: 0
; ------------------------------------------------------
; IDEIA..........: ESI = ((2 * height) - 1 - (2 * EDI))
; ------------------------------------------------------
printAsteriscs:
    mov     esi, height
    imul    esi, 2
    sub     esi, 1
    sub     esi, edi
    sub     esi, edi
    .whileLoop:
        sub esi, 1

        cmp esi, 0
        jl retorne
        je printLastAsterisc

        call printAsterisc
        loop .whileLoop

retorne:
    ret

; -------------------------------------
; Função.: Printa um asterisc
; -------------------------------------
printAsterisc:
    mov edx, 1              ; o tamanho
    mov ecx, asterisc
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL
    ret

; -------------------------------------
; Função.: Printa um asterisc com '\n'
; -------------------------------------
printLastAsterisc:
    mov edx, 2              ; o tamanho
    mov ecx, asterisc
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL
    ret

; -------------------------------------
; Função.: Printa um space
; -------------------------------------
printSpace:
    mov edx, 1              ; o tamanho
    mov ecx, space
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    int SYS_CALL
    ret
