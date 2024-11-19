%include "src/macros.s"

    global ft_strlen
    global ft_strlen_1

    section .text
ft_strlen:
    xor rax, rax
    xor rcx, rcx
    dec rcx
    cld
    repnz scasb
    sub rax, rcx
    sub rax, 2
    ret

ft_strlen_1:
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
