
#include <data.h>
#include <asm.h>

    .text
    .globl _start
    .p2align 0x4
_start:

    .lcomm p, 2*N
    .globl count
    .lcomm count, 8

    xor %rsi, %rsi
    lea p, %rdi
    call countf

    mov count, %rdi
    call printhex
    call newline
    
L(exit):
    /* exit */
    mov %rax, %rdi
    mov $0x3c, %rax
    syscall

