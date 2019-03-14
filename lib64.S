
#include <asm.h>

    .text
    .p2align 0x4
    .globl print
    /* print(char*) */
print:
    xor %rdx,%rdx
    lea (%rdi), %rsi
    jmp 1f
L(2):
    inc %rdx
    inc %rdi
L(1):
    movb (%rdi), %al
    testb %al, %al
    jnz 2b
    
    mov $0x1, %rdi
    mov $0x1, %rax
    syscall

    ret


    .p2align 0x4
    .globl printhex
    /* printhex(uint64_t) */
printhex:
    sub $0x10, %rsp

    xor %rdx, %rdx
    lea 0xf(%rsp), %rsi

L(1):
    inc %rdx

    mov %edi, %eax
    and $0xf, %al
    cmp $0xa, %al
    jb 2f
    add $('a'-'0'-0xa), %al
L(2):
    add $'0', %al

    movb %al, (%rsi)

    shr $0x4, %rdi
    jz 3f
    dec %rsi
    jmp 1b
L(3):
    
    /* rdx = number of nonzero digits */
    /* rsi = pointer to string */
    inc %rdi
    /* rdi = 1 */
    mov $0x1, %eax
    syscall

    add $0x10, %rsp
    ret


    .p2align 0x4
    .globl newline
    /* newline() */
newline:
    sub $0x10, %rsp
    movb $'\n', (%rsp)

    mov $0x1, %rdi
    lea (%rsp), %rsi
    mov $0x1, %rdx
    mov $0x1, %rax
    syscall

    add $0x10, %rsp
    ret

