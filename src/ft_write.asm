    global ft_write
    extern __errno_location

    section .text
ft_write:
    mov rax, 1 ; Syscall idx
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
