%include "src/macros.asm"

    global ft_strlen

    section .text
ft_strlen:
    cmp rdi, 0
    jz end
    xor rax, rax
loop:
    cmp BYTE [rdi], 0
    jz end
    inc rax
    inc rdi
    jmp loop
end:
    ret
