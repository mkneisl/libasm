%include "src/macros.asm"
%include "src/bonus/list_macros.asm"

	global ft_list_size

	section .text
ft_list_size:
	xor rax, rax
loop:
	cmp rdi, 0
	je end
	inc rax
	mov rdi, [rdi + s_list.next]
	jmp loop
end:
	ret
