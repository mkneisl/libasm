%include "src/macros.asm"

    global ft_read
%ifidn __OUTPUT_FORMAT__, macho64
    extern __error
%define getErrnoPtr __error
    READ_IDX equ 0x2000003
%elifidn __OUTPUT_FORMAT__, elf64
    extern __errno_location
%define getErrnoPtr __errno_location
    READ_IDX equ 0
%endif

    section .text
ft_read:
    mov rax, READ_IDX ; Syscall idx
    clc
    syscall
    jb err
    cmp rax, 0
    js err
    ret
err:
    neg rax
    push rax
    dycall getErrnoPtr
    pop rcx
    mov DWORD [rax], ecx
    mov rax, -1
    ret
