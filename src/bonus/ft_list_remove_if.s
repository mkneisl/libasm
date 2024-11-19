%include "src/macros.asm"
%include "src/bonus/list_macros.asm"

	global ft_list_remove_if
	extern free

	struc stack
		.cmpCallback:	resq 1
		.freeCallback:	resq 1
		.dataRef:		resq 1
	endstruc

	section .text
ft_list_remove_if:
	push r12
	push r13
	sub rsp, stack_size
	mov [rsp + stack.cmpCallback], rdx	; cmp callback
	mov [rsp + stack.freeCallback], rcx	; free callback
	mov [rsp + stack.dataRef], rsi		; data ref
	cmp rdi, 0
	je end
	mov r12, rdi						; pPrevNext
	mov r13, [rdi]						; Current node
loop_nodes:
	cmp r13, 0
	je end
	mov rdi, [r13 + s_list.data]
	mov rsi, [rsp + stack.dataRef]
	call [rsp + stack.cmpCallback]
	cmp rax, 0
	je remove_node
	lea r12, [r13 + s_list.next]
	mov r13, [r13 + s_list.next]
	jmp loop_nodes
remove_node:
	mov rcx, [r13 + s_list.next]
	mov [r12], rcx
	mov rdi, [r13 + s_list.data]
	call [rsp + stack.freeCallback]
	mov rdi, r13
	dycall free
end:
	add rsp, stack_size
	pop r13
	pop r12
	ret

