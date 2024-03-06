.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
print_text: .asciiz "The dot product is: "

.text
main:
    # a0 = a, a1 = b, a2 = size
    la a0, a
    la a1, b
    addi a2, x0, 5
    jal dot_product_recursive
    
    # Print dot product
    addi a0, x0, 4
    la a1, print_text
    ecall
    
    # Print result
    mv a1, a0
    addi a0, x0, 1
    ecall
    
    # Exit cleanly
    addi a0, x0, 10
    ecall

dot_product_recursive:
    # Base Case
    addi t0, x0, 1
    beq a2, t0, base_case
    
    # Recursive Case
    addi sp, sp, -16 # Prepare Stack Pointer
    sw ra, 0(sp) # Save ra into stack
    sw a0, 4(sp) # Save a0 into stack
    sw a1, 8(sp) # Save a1 into stack
    sw a2, 12(sp) # Save a2 into stack
    
    # Call dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, 4 # a + 1
    addi a1, a1, 4 # b + 1
    addi a2, a2, -1 # size - 1
    jal dot_product_recursive
    lw ra, 0(sp) # Restore ra
    lw a0, 4(sp) # Restore a0
    lw a1, 8(sp) # Restore a1
    lw a2, 12(sp) # Restore a2
    addi sp, sp, 16 # Restore Stack Pointer
    
    # Calculate a[0] * b[0] + result from recursion
    lw t1, 0(a0) # a[0]
    lw t2, 0(a1) # b[0]
    mul t5, t1, t2 # a[0] * b[0]
    lw t3, 0(a0) # Load previous result
    add a0, t5, t3 # Add result from recursion
    
    jr ra # Return

base_case:
    # Calculate a[0] * b[0] and return
    lw t1, 0(a0) # a[0]
    lw t2, 0(a1) # b[0]
    mul a0, t1, t2 # a[0] * b[0]
    jr ra # Return
