%pragma macho gprefix _

%macro dycall 1
    %ifidn __OUTPUT_FORMAT__, macho64
        call %1
    %elifidn __OUTPUT_FORMAT__, elf64
        call %1 wrt ..plt
    %endif
%endmacro

%macro isyscall 2
    mov rax, $1
    %ifidn __OUTPUT_FORMAT__, macho64
        clc
        syscall
        js %%error
    %elifidn __OUTPUT_FORMAT__, elf64
        syscall
        cmp rax, 0
        js %%error
    %endif
    ret
%%error:
    %ifidn __OUTPUT_FORMAT__, elf64
        neg rax
    %endif
    push rax
    dycall %2
    pop rcx
    mov DWORD [rax], ecx
    mov rax, -1
    ret
%endmacro
