%include "src/macros.asm"

    global ft_strcpy

    section .text
ft_strcpy:
    mov rax, rdi
loop:
    mov cl, BYTE [rsi]
    mov BYTE [rdi], cl
    inc rdi
    inc rsi
    cmp cl, 0
    jne loop
    ret