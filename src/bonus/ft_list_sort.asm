%include "src/macros.asm"
%include "src/bonus/list_macros.asm"

	global ft_list_sort
	extern ft_list_push_front

	struc stack
		.sortedList:	resq 1
		.listBegin:		resq 1
		.callback:		resq 1
	endstruc

	section .text
ft_list_sort:
	sub rsp, stack_size
	cmp rdi, 0
	je end
	mov rax, [rdi]
	cmp rax, 0
	je end
	mov [rsp + stack.listBegin], rdi
	mov [rsp + stack.callback], rsi
	lea rdi, [rsp + stack.sortedList]
	mov QWORD [rdi], 0
	mov rsi, [rax + s_list.data]
	push rax
	dycall ft_list_push_front
	pop r8
	
end:
	add rsp, stack_size
	ret
