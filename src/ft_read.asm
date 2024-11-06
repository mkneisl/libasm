    READ_IDX equ 0

    global ft_read
    extern __errno_location

    section .text
ft_read:
    mov rax, READ_IDX ; Syscall idx
    syscall
    cmp rax, 0
    js err
    ret
err:
    neg rax
    push rax
    call __errno_location wrt ..plt
    pop rcx
    mov DWORD [rax], ecx
    mov rax, -1
    ret
