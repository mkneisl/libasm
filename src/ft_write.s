%include "src/macros.s"

    global ft_write
%ifidn __OUTPUT_FORMAT__, macho64
    extern __error
%define getErrnoPtr __error
    SYS_write equ 0x2000004
%elifidn __OUTPUT_FORMAT__, elf64
    extern __errno_location
%define getErrnoPtr __errno_location
    SYS_write equ 1
%endif

    section .text
ft_write:
    isyscall SYS_write, getErrnoPtr
