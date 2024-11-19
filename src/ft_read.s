%include "src/macros.s"

    global ft_read
%ifidn __OUTPUT_FORMAT__, macho64
    extern __error
%define getErrnoPtr __error
    SYS_read equ 0x2000003
%elifidn __OUTPUT_FORMAT__, elf64
    extern __errno_location
%define getErrnoPtr __errno_location
    SYS_read equ 0
%endif

    section .text
ft_read:
    isyscall SYS_read, getErrnoPtr
