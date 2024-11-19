%include "src/macros.s"
%include "src/bonus/list_macros.s"

	global ft_list_sort

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
	mov rsi, rax						; Pushing first element of list into sorted list
	mov rax, [rax + s_list.next]
	mov rcx, [rdi]
	mov [rsi + s_list.next], rcx
	mov [rdi], rsi
	mov rsi, rax
loop_unsorted:
	cmp rsi, 0
	je end
	mov rax, [rsi + s_list.next]		; Get next element of unsorted list
	mov [rsp + stack.currentNode], rax
	lea rdi, [rsp + stack.sortedList]
	mov rdx, [rsp + stack.callback]
	call insert_sorted					; Insert element sorted
	mov rsi, [rsp + stack.currentNode]
	jmp loop_unsorted
end:
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
	jmp insertion_loop				; if greater - get next node else insert
insert_node:
	mov [r13 + s_list.next], r15
	mov [r12], r13
insert_sorted_end:
	pop r15
	pop r14
	pop r13
	pop r12
	ret
