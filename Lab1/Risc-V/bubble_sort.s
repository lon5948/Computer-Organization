.data
data: .word   5,3,6,7,31,23,43,12,45,1
N: .word 10
str1: .string "Array¡G\n"
str2: .string "\nSorted¡G\n"
str3: .string " "
.text
main:   
        # Print Array
        lw a2, N
        la a0, str1
        li a7, 4
        ecall
        la  a1, data
        jal ra, PrintArray
        
        mv a3, zero
        sub a1, a1, t1
        jal ra, bubblesort
        
        # Print Sorted
        la a0, str2
        li a7, 4
        ecall
        la  a1, data
        jal ra, PrintArray
        
        # Exit program
        li a7, 10
        ecall

bubblesort:
        lw t1, 0(a1)
        lw t2, 4(a1)
        bgt t1, t2, swap
        
        addi a4, a4, -1
        blt a4, zero, exit
        
        addi a1, a1, -4
        jal zero, bubblesort
        
swap:
        addi t0, t1, 0
        addi t1, t2, 0
        addi t2, t0, 0
        
        sw t1, 0(a1)
        sw t2, 4(a1)
        jal zero, bubblesort
        
exit:
        addi a3, a3, 1
        addi a4, a3, -1
        slli t0, a4, 2
        add a1, a1, t0
        
        blt a3, a2, bubblesort
        jr ra
        
PrintArray:
        slli t1, a2, 2
        add t0, a1, t1
        jal zero, PrintLoop
        
PrintLoop:
        lw a0, 0(a1)
        li a7, 1
        ecall
        la a0, str3
        li a7, 4
        ecall
        
        addi a1, a1, 4
        bne a1, t0, PrintLoop
        ret