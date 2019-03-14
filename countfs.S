
#include <data.h>
#include <asm.h>

    .text
    .globl countf
    .p2align 0x4
    /* countf(uint8_t p[2*N], uint64_t index); */
countf:

    /* index >= (2*N) ? */
    cmp $(2*N), %rsi
    jae basecase

    /* if index < 2*N */
    
    push %rbx
    push %r12
    push %r13
    sub $0x8, %rsp

    /* %r12 = &p[0] */
    lea (%rdi), %r12
    
    /* %r13 = index */
    lea (%rsi), %r13

    /* %bl = min = 0 */
    //xor %bl, %bl
    mov $0x0, %bl
    
    /* index == 0 ? */
    test %rsi, %rsi
    jz zeroindex

    /* if index > 0 */

    /* search of min */
L(1):
    /* if i > 0 then min = 1 in first loop */
    inc %bl
    /* %rcx = j = index */
    mov %rsi, %rcx
L(2):
    /* min == p[j-1] ? */
    cmpb -0x1(%rdi, %rcx, 1), %bl
    je 1b
    /* while --j>0 */
    sub $1, %rcx
    jnz 2b
    /* if j==0 then %bl the min is found */

    /* min will be linked with all his possibilities */
    /* p[index] = min; */
    mov %bl, (%rdi, %rsi, 1)

    /* n = min+1 */
    inc %bl

L(1):
    /* j = index */
    mov %rsi, %rcx
L(2):
    /* p[j-1] == n ? */
    cmpb -0x1(%rdi, %rcx, 1), %bl
    je 3f
    /* while --j>0 */
    sub $1, %rcx
    jnz 2b

    /* n is linked with min */
    /* p[index+1] = n */
    mov %bl, 0x1(%rdi, %rsi, 1)
    add $0x2, %rsi
    call countf

    /* %rdi = &p[0] */
    mov %r12, %rdi
    /* %rsi = index */
    mov %r13, %rsi

L(3):
    /* n++ */
    inc %bl
    /* while n<(2*N) */
    cmpb $(2*N), %bl
    jb 1b

    add $0x8, %rsp
    pop %r13
    pop %r12
    pop %rbx
    ret

L(zeroindex):
    /* index = 0 (%bl = min = 0) */

    /* p[0] = min */
    mov %bl, (%rdi)
    /* n = min+1 */
    inc %bl
L(1):
    /* n is linked with 0 */
    /* p[1] = n */
    mov %bl, 0x1(%rdi, %rsi, 1)
    add $0x2, %rsi
    call countf
    /* %rdi = &p[0] */
    mov %r12, %rdi
    /* %rsi = index */
    mov %r13, %rsi

    /* n++ */
    inc %bl
    /* while n<(2*N) */
    cmpb $(2*N), %bl
    jb 1b
    
    add $0x8, %rsp
    pop %r13
    pop %r12
    pop %rbx
    ret

L(basecase):
    /* index >= 2*N */
    /* TODO: call a function (it could be given as argument) */
    /* count++ */
    addq $0x1, count(%rip)
    ret

