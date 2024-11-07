%include "src/macros.asm"
%include "src/bonus/list_macros.asm"

    global ft_list_new
    extern malloc

    section .text
ft_list_new:
    push rdi
    mov rdi, s_list_size
    dycall malloc
    cmp rax, 0
    pop rdi
    je end
    mov [rax + s_list.data], rdi
    mov QWORD[rax + s_list.next], 0
end:
    ret