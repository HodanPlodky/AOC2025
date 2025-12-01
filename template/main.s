.global _start
.intel_syntax noprefix


_start:
    // print
    mov rax, 1
    mov rdi, 1
    lea rsi, [msg]
    mov rdx, 23 + 2
    syscall

    // tmp
    mov rdi, 1
    add rdi, 2
    mov rax, rdi

    // return 0
    mov rax, 60
    xor rdi, rdi
    syscall

msg:
    .asciz "hello how are you doink\n"
