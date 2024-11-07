%include "src/macros.asm"

    global ft_atoi_base
    extern ft_strlen

    struc stack
        .strPtr:  resq 1
        .basePtr: resq 1
        .base:    resq 1
    endstruc

    section .text
ft_atoi_base:
    sub rsp, stack_size              ; Save arguments to stack
    mov [rsp + stack.strPtr], rdi    ; char*  str 
    mov [rsp + stack.basePtr], rsi   ; char* base
    mov rdi, rsi
    dycall ft_strlen
    mov [rsp + stack.base], rax      ; Save base to stack
    mov rdi,[rsp + stack.strPtr]     ; char* str
    mov r8,[rsp + stack.basePtr]     ; char* base
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
    imul rax, [rsp + stack.base]    ; Multiply value with base
    add rax, r9                     ; Add digit
    inc rdi
    jmp data_loop
end:
    add rsp, stack_size
    ret
