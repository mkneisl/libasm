%include "src/macros.asm"
%include "src/bonus/list_macros.asm"

	global ft_list_sort
	extern ft_list_push_front
	extern ft_list_new
	extern free

	struc stack
		.sortedList:	resq 1
		.unsortedList:	resq 1
		.callback:		resq 1
		.currentNode	resq 1
	endstruc

	section .text
ft_list_sort:
	sub rsp, stack_size + 8
	cmp rdi, 0							; Zero Checks
	je end
	mov rax, [rdi]
	cmp rax, 0
	je end
	mov [rsp + stack.unsortedList], rdi
	mov [rsp + stack.callback], rsi
	lea rdi, [rsp + stack.sortedList]
	mov QWORD [rdi], 0
	mov rsi, [rax + s_list.data]		; Pushing first element of list into sorted list
	mov [rsp + stack.currentNode], rax
	dycall ft_list_push_front
	mov rsi, [rsp + stack.currentNode]
loop_unsorted:
	mov rsi, [rsi + s_list.next]		; Get next element of unsorted list
	cmp rsi, 0
	je end
	mov [rsp + stack.currentNode], rsi
	lea rdi, [rsp + stack.sortedList]
	mov rdx, [rsp + stack.callback]
	call insert_sorted					; Insert element sorted
	mov rsi, [rsp + stack.currentNode]
	; mov rsi, [rsi + s_list.next]
	jmp loop_unsorted
end:
	mov rdi, [rsp + stack.unsortedList]
	mov rdi, [rdi]
	call deallocate_list
	mov rsi, [rsp + stack.unsortedList]
	mov rdi, [rsp + stack.sortedList]
	mov [rsi], rdi
	add rsp, stack_size + 8
	ret

insert_sorted:
	push r12
	push r13
	push r14
	push r15
	mov r12, rdi	; r12 -> p prev next
	mov r13, rsi	; r13 -> node to insert
	mov r14, rdx	; r14 -> cmp callback
	mov r15, [rdi]	; r15 -> current node
	mov rdi, [r13 + s_list.data]
	dycall ft_list_new
	mov r13, rax
insertion_loop:
	cmp r15, 0
	je insert_sorted_end
	mov rdi, [r13 + s_list.data]
	mov rsi, [r15 + s_list.data]
	call r14
	cmp rax, 0
	jle insert_node
	lea r12, [r15 + s_list.next]
	mov r15, [r15 + s_list.next]
	jmp insertion_loop 				; if greater - get next node else insert
insert_node:
	mov [r13 + s_list.next], r15
	mov [r12], r13
insert_sorted_end:
	pop r15
	pop r14
	pop r13
	pop r12
	ret

deallocate_list:
	mov rcx, [rdi + s_list.next]
	push rcx
	dycall free
	pop rcx
	cmp rcx, 0
	je deallocate_list_end
	mov rdi, rcx
	jmp deallocate_list
deallocate_list_end:
	ret
