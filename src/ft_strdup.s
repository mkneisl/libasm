%include "src/macros.s"

    global ft_strdup
    extern malloc
    extern ft_strlen
    extern ft_strcpy

    section .text
ft_strdup:
    push rdi
    dycall ft_strlen
    inc rax
    mov rdi, rax
    dycall malloc
    cmp rax, 0
    jz end
    mov rdi, rax
    pop rsi
    dycall ft_strcpy
end:
    ret
