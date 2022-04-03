.data
argument: .word   7
str1:     .string "th number in the Fibonacci sequence is "

.text
main:
        lw  a0, argument   
        jal ra, Fabonacci   

        mv  a1, a0
        jal ra, Print

        li a7, 10
        ecall

Fabonacci:
        addi sp, sp, -16
        sw   a0, 0(sp)
        sw   ra, 8(sp)
        addi t0, a0, -2
        bge  t0, zero, nFabonacci
        addi sp, sp, 16
        jr ra

nFabonacci:
        addi a0, a0, -1
        jal  ra, Fabonacci
        addi t2, t1, 0
        addi t1, a0, 0
        lw   a0, 0(sp)
        lw   ra, 8(sp)
        addi sp, sp, 16
        add a0, t1, t2
        ret

Print:
        lw  a0, argument
        li a7, 1
        ecall
        la a0, str1
        li a7, 4
        ecall
        mv a0, a1
        li a7, 1
        ecall
        ret
