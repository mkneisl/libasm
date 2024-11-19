%include "src/macros.s"

    global ft_strcmp

    section .text
ft_strcmp:
    xor rax, rax
    xor rcx, rcx
    mov al, BYTE[rdi]
    mov cl, BYTE[rsi]
    inc rsi
    inc rdi
    cmp al, 0
    jz end
    cmp cl, 0
    jz end
    cmp al, cl
    je ft_strcmp
end:
    sub rax, rcx
    ret