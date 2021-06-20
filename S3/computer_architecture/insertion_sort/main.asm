global main


extern print_int
extern print_ln
extern get_int


section .bss
	array	resd 100
	n		resd 1
	key 	resd 1
	i 		resd 1
	j		resd 1


section .text
main:

	call 	get_int

	cmp		eax, 	100
	jge		exit			; só foi reservado 100 dwords

	mov 	[n],	eax
	call	gets_array

	call insertion_sort
	call print_array
	call print_ln


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
		jge		retorne

		call 	get_int
		mov		[array + 4 * edi],	eax

		add		edi, 	1
		jmp		.whileLoop


; ---------------------------------------------
; Algorito de ordenação Insertion Sort
; ---------------------------------------------
insertion_sort:
    mov     dword[i], 1

    .while:
		mov 	ebx,		dword[i]
		cmp 	ebx,		dword[n]
		jge		retorne

		;key = arr[i];
		mov 	eax,		[array + 4 * ebx]
		mov		[key],		eax

		;j = i - 1;
		sub 	ebx,		1
		mov 	[j],		ebx

		call 	troca

		;arr[j + 1] = key;
		mov 	ebx,				dword[j]
		add		ebx,				1
		mov		eax,				dword[key]
		mov		[array + 4 * ebx],	eax

		add 	dword[i],	1
		jmp   	.while
    ret


troca:
	;j >= 0
    cmp     dword[j],   0
    jl      retorne
    
	;arr[j] > key
	mov 	ebx,		dword[j]
	mov		eax,		[array + 4 * ebx]
	cmp 	eax,		dword[key]
	jle		retorne
	
	;arr[j + 1] = arr[j];
	mov		[array + 4 + 4 * ebx], eax

	;j = j - 1;
	sub		ebx,		1
	mov		[j],		ebx
	jmp 	troca


; ---------------------------------------------
; Função para imprimir os elementos do array
; ---------------------------------------------
print_array:
	mov 	edi, 	0
	
	.whileTrue:
		cmp 	edi, 	dword[n]
		jge		retorne

		mov 	eax, 	[array + 4 * edi]
		call 	imprime_inteiro
		add		edi, 	1
		jmp		.whileTrue


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
