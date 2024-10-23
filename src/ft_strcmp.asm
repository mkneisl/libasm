    global ft_strcmp

    section .text
ft_strcmp:
    xor rax, rax
    xor rcx, rcx
    mov al, BYTE[rsi]
    mov cl, BYTE[rdi]
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