%include "src/macros.asm"

    ptr_str equ 0
    ptr_base equ ptr_str + 8
    base equ ptr_base + 8

    global ft_atoi_base
    extern ft_strlen

    section .text
ft_atoi_base:
    sub rsp, 24                 ; Save arguments to stack
    mov [rsp + ptr_str], rdi    ; char*  str 
    mov [rsp + ptr_base], rsi   ; char* base
    mov rdi, rsi
    dycall ft_strlen
    mov [rsp + base], rax       ; Save base to stack
    mov rdi,[rsp + ptr_str]     ; char* str
    mov r8,[rsp + ptr_base]     ; char* base
    xor rax, rax
data_loop:
    mov cl, BYTE [rdi]
    cmp cl, 0
    je end
    xor r9, r9
get_digit:
    mov r10b, BYTE [r8 + r9]
    cmp r10b, 0
    je add_digit
    cmp r10b, cl
    je add_digit
    inc r9
    jmp get_digit
add_digit:
    imul rax, [rsp + base]      ; Multiply value with base
    add rax, r9                 ; Add digit
    inc rdi
    jmp data_loop
end:
    add rsp, 24
    ret
