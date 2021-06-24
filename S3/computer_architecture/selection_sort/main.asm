;void selectionSort(int arr[], int n)
;{
;    int i, j, min_idx;
 
;    for (i = 0; i < n-1; i++)
;    {
;        min_idx = i;
;        
;        for (j = i+1; j < n; j++)
;           if (arr[j] < arr[min_idx])
;               min_idx = j;
 
;        swap(&arr[min_idx], &arr[i]);
;    }
;}

; jl    ->      <
; jg    ->      > 
; jge   ->      >=
; jle   ->      <=
; je    ->      =
; jmp   ->      incondicional
; jnz   ->      se for diferente de 0


global main


extern print_int
extern print_ln
extern get_int


section .bss
	array		resd 100			; 100 espaços p/ 4 bytes
	n		resd 1
	min_idx 	resd 1
	i 		resd 1
	j		resd 1


section .text
main:

	call 	get_int

	cmp	eax, 	100
	jge	exit						; só foi reservado 100 dwords

	mov 	[n],	eax
	call	gets_array

	call 	selection_sort
	call 	print_array
	call 	print_ln


exit:
	; return 0;
	mov eax, 0
	ret


; ---------------------------------------------
; Função para popular o array
; ---------------------------------------------
gets_array:
	mov 	edi, 	0
	
	.whileLoop:
		cmp 	edi, 	dword[n]
		jge	retorne

		call 	get_int				; eax = get_int
		mov	[array + 4 * edi],	eax

		add	edi, 	1
		jmp	.whileLoop


; ---------------------------------------------
; Algorito de ordenação Selection Sort
; ---------------------------------------------
selection_sort:
	;i = 0;
    mov     dword[i], 0

    .while:
	;i < n-1;
	mov 	ebx,	dword[i]
        mov     eax,   	dword[n]
        sub     eax,  	1
	cmp 	ebx,	eax
	jge	retorne					; se i >= n, retorne

        ;min_idx = i;
	mov	[min_idx],	ebx
        
	;j = i + 1;
	add 	ebx,		1
	mov 	[j],		ebx
        
        call    findMinIndex
        
        ;swap(&arr[min_idx], &arr[i]);
        mov     edi,                dword[min_idx]
        mov     eax,                [array + 4 * edi]   ; array[min_idx]
        mov     esi,                dword[i]
        mov     ebx,                [array + 4 * esi]   ; array[i]
        mov     [array + 4 * edi],  ebx                 ; array[min_idx] = array[i]
        mov     [array + 4 * esi],  eax                 ; array[i] = array[min_idx]

	add 	dword[i],	1
        jmp   	.while


findMinIndex:
    cmp     ebx,        dword[n]
    jge     retorne

    ;if (arr[j] < arr[min_idx])
    mov     edi,        dword[min_idx]
    mov     eax,        [array + 4 * ebx]   		; array[j]
    cmp     eax,        [array + 4 * edi]   		; compara array[min_idx]
    jge     incrementJ
    ;min_idx = j;
    mov     [min_idx],  ebx
    jmp     incrementJ


incrementJ:
    add     ebx,    1
    jmp     findMinIndex


; ---------------------------------------------
; Função para imprimir os elementos do array
; ---------------------------------------------
print_array:
	mov 	edi, 	0
	
	.whileTrue:
		cmp 	edi, 	dword[n]
		jge	retorne

		mov 	eax, 	[array + 4 * edi]
		call 	imprime_inteiro
		add	edi, 	1
		jmp	.whileTrue


; ---------------------------------------------
; Função imprime um inteiro
; ---------------------------------------------
; Entrada: EAX com um inteiro
; ---------------------------------------------
imprime_inteiro:
	push dword eax
	call print_int
	add esp, 4
	ret


retorne:
    ret
