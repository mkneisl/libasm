    global ft_atoi_base
    extern ft_strlen

    section .text
ft_atoi_base:
    sub rsp, 24                 ; Save arguments to stack
    mov [rsp], rdi              ; char*  str 
    mov [rsp + 8], rsi          ; char* base
    mov rdi, rsi
    call ft_strlen wrt ..plt
    mov [rsp + 16], rax         ; Save base to stack
    mov rdi,[rsp]               ; char* str
    mov r8,[rsp + 8]            ; char* base
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
    imul rax, [rsp + 16]        ; Multiply value with base
    add rax, r9
    inc rdi
    jmp data_loop
end:
    add rsp, 24
    ret
