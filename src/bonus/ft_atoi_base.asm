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
    cmp rax, 1
    jle error
    mov [rsp + stack.base], rax      ; Save base to stack
    mov rdi, [rsp + stack.basePtr]
    call validate_input
    test rax, rax
    jnz error
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
error:
    xor rax, rax
end:
    add rsp, stack_size
    ret

validate_input:
    sub rsp, 256
    xor rax, rax
zero_stack:
    mov BYTE [rsp + rax], 0
    cmp rax, 255
    inc rax
    jbe zero_stack
    xor rdx, rdx
    xor rax, rax
    xor r8, r8
validate_input_loop:
    mov r8b, BYTE [rdi + rdx]
    cmp r8b, 0
    je validate_input_end
    cmp BYTE [rsp + r8], 0
    jne validate_input_error
    cmp r8b, ' '
    je validate_input_error
    cmp r8b, '+'
    je validate_input_error
    cmp r8b, '-'
    je validate_input_error
    inc rdx
    jmp validate_input_loop
validate_input_error:
    mov rax, 1
validate_input_end:
    add rsp, 256
    ret
