.data
argument1: .word 4
argument2: .word 8
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
    lw a0, argument1
    lw a1, argument2
    jal ra, gcd
    
    mv a1, a0
    jal ra, Print
    
    li a7, 10
    ecall
    
gcd:
    addi sp, sp, -8
    sw ra, 0(sp)
    bne a1, zero, ngcd
    addi sp, sp, 8
    jr ra
    
ngcd:
    addi t0, a1, 0
    rem a1, a0, t0
    addi a0, t0, 0
    jal ra, gcd
    lw ra, 0(sp)
    addi sp, sp, 8
    ret
    
Print:
    la a0, str1
    li a7, 4
    ecall
    lw a0, argument1
    li a7, 1
    ecall
    la a0, str2
    li a7, 4
    ecall
    lw a0, argument2
    li a7, 1
    ecall
    la a0, str3
    li a7, 4
    ecall
    mv a0, a1
    li a7, 1
    ecall
    ret
    