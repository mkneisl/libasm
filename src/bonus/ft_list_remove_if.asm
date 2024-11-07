%include "src/macros.asm"
%include "src/bonus/macros.asm"

	global ft_list_remove_if

	secion .text
ft_list_remove_if:
	push r12
	push r13
	push r14
	push r15
	mov r12, rbx	; cmp callback
	mov r13, rcx	; free callback
	mov r14, rsi	; data ref
	cmp rdi, 0
	je end
	mov rax, [rdi]
	cmp rax, 0
	je end
	
end:
	pop r15
	pop r14
	pop r13
	pop r12
	ret

