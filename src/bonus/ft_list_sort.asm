%include "src/macros.asm"
%include "src/bonus/list_macros.asm"

	global ft_list_sort
	extern ft_list_push_front
	extern ft_list_new

	struc stack
		.sortedList:	resq 1
		.listBegin:		resq 1
		.callback:		resq 1
	endstruc

	section .text
ft_list_sort:
	push r12
	push r13
	push r14
	sub rsp, stack_size
	cmp rdi, 0							; Zero Checks
	je end
	mov rax, [rdi]
	cmp rax, 0
	je end
	mov [rsp + stack.listBegin], rdi
	mov [rsp + stack.callback], rsi
	lea rdi, [rsp + stack.sortedList]
	mov QWORD [rdi], 0
	mov rsi, [rax + s_list.data]		; Pushing first element of list into sorted list
	push rax
	dycall ft_list_push_front
	pop r8
	lea r12, [rsp + stack.sortedList]	; Save pointer to previous next ptr - in this case initial ptr

	mov r8, [r8 + s_list.next]			; Get next element of unsorted list
	cmp r8, 0
	je end
	;lea r12, [r9 + s_list.next]			; Save pointer to previous next ptr

	mov r9, [rsp + stack.sortedList]
search_value:
	mov r10, [r8 + s_list.data]			; Next value to insert into sorted list
	mov rsi, r10
	mov rdi, [r9 + s_list.data]
	push r8
	push r9
	call [rsp + stack.callback]
	pop r8
	pop r9
	cmp rax, 0
	jg search_value
	
	dycall ft_list_new


end:
	add rsp, stack_size
	pop r14
	pop r13
	pop r12
	ret

; void insert_sorted(t_list** begin, t_list* toInsert, )
insert_sorted:
	push r12
	push r13
	push r14
	mov r12, [rdi] ; r12 -> prev next
	mov r13, rsi
	mov r14, rdx

	mov 

	pop r14
	pop r13
	pop r12
