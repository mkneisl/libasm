    global ft_strdup
    extern malloc
    extern ft_strlen
    extern ft_strcpy

    section .text
ft_strdup:
    push rdi
    call ft_strlen wrt ..plt
    inc rax
    mov rdi, rax
    call malloc wrt ..plt
    cmp rax, 0
    jz end
    mov rdi, rax
    pop rsi
    call ft_strcpy wrt ..plt
end:
    ret
