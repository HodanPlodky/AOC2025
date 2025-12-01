.global _start
.intel_syntax noprefix

_start:
    lea rdi, [input_file]

    call open_file
    mov r13, rax

    // curr
    mov r15, 50

    // zeroes
    xor r14, r14
    xor rax, rax

//int3

    loop:
        // store curr
        mov r8, r15
        add r15, rax
        // store line
        mov r9, rax
        // abs line
        mov rcx, rax
        neg rcx
        cmovs rcx, rax

        // mod new
        mov rax, r15
        mov rdi, 100
        // taken from godbolt
        // https://www.felixcloutier.com/x86/cwd:cdq:cqo
        cqo
        idiv rdi
        mov r15, rdx

        cmp r15, 0
        jge after_mod
            add r15, 100
        after_mod:

        // mod line
        mov rax, rcx
        mov rdi, 100
        // taken from godbolt
        // https://www.felixcloutier.com/x86/cwd:cdq:cqo
        cqo
        idiv rdi

        //calculation
        add r14, rax
        cmp r8, 0
        je after1
            cmp r9, 0
            jle after2
                cmp r8, r15
                jg do_inc
                jmp after1

            after2:
            cmp r8, r15
            jl do_inc
            cmp r15, 0
            je do_inc
            jmp after1
            do_inc:
                inc r14
        after1:
        


        mov rdi, r13
        call read_line
        cmp rax, 0
        jne loop

    lea rdi, [msg]
    mov rsi, 12
    call print_buffer


    mov rdi, r14
    call print_number

    mov rax, 60
    xor rdi, rdi
    syscall

open_file:
    mov rax, 2
    mov rsi, 0
    mov rdx, 0
    syscall
    ret

read_file:
    mov rax, 0
    syscall
    ret

print_buffer:
    mov rax, 1
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, 1
    syscall
    ret

print_number:
    sub rsp, 0x100

    // index
    mov r9, 0xff
    mov BYTE PTR [rsp+r9*1], '\n'
    dec r9

    print_number_loop:
        mov rax, rdi
        mov r8, 10
        cqo
        idiv r8
        mov rdi, rax

        add rdx, '0'
        mov BYTE PTR [rsp+r9], dl

        dec r9
        cmp rdi, 0
        jne print_number_loop

    lea rdi,[rsp+r9]
    mov rsi,0x100
    sub rsi,r9
    call print_buffer

    add rsp,0x100
    ret

nl:
    lea rdi, [new_line]
    mov rsi, 1
    call print_buffer
    ret

read_line:
    sub rsp, 0x1
    mov rsi, rsp
    mov rdx, 0x1
    call read_file
    movzx r9, BYTE PTR [rsp]

    // result
    xor r8, r8
    mov rax, '0'
    mov rcx, '\n'
    cmp r9,rcx
    je after

    loop_read_line:
        sub rax, '0'
        imul r8, r8, 10
        add r8, rax
        mov rsi, rsp
        mov rdx, 1
        call read_file
        movzx rax, BYTE PTR [rsp]
        mov rcx, '\n'
        cmp rax, rcx
        jne loop_read_line

    mov rcx, 'L'
    cmp r9, rcx
    jne after
        neg r8

    after:
    add rsp, 0x1
    mov rax, r8
    ret

input_file:
    .asciz "input.txt\0"

msg:
    .asciz "result is: \0"

new_line:
    .asciz "\n"
