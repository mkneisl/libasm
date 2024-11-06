%include "src/macros.asm"

    global ft_write
%ifidn __OUTPUT_FORMAT__, macho64
    extern __error
%define getErrnoPtr __error
    WRITE_IDX equ 0x2000004
%elifidn __OUTPUT_FORMAT__, elf64
    extern __errno_location
%define getErrnoPtr __errno_location
    WRITE_IDX equ 1
%endif

    section .text
ft_write:
    isyscall WRITE_IDX, getErrnoPtr
;     mov rax, WRITE_IDX ; Syscall idx
;     clc
;     syscall
;     jb err
;     cmp rax, 0
;     js err
;     ret
; err:
;     neg rax
;     push rax
;     dycall getErrnoPtr
;     pop rcx
;     mov DWORD [rax], ecx
;     mov rax, -1
;     ret
