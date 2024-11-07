%include "src/macros.asm"
%include "src/bonus/list_macros.asm"

    global ft_list_push_front

    extern ft_list_new
    section .text
ft_list_push_front:
    push rdi
    mov rdi, rsi
    dycall ft_list_new
    cmp rax, 0
    pop rdi
    je end
    cmp [rdi], 0
    je set_start_node
    mov rdx, [rdi]
    mov [rax + s_list.next], rdx
set_start_node:
    mov [rdi], rax
end:
    ret