#sum.c
.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .string "\n"

.text 
main:
    addi x5, x0, 5 # let x5 be size and set it to 5
    addi x6, x0, 0  # let x6 be sop and set it to 0
    addi x8, x0, 0 # let x8 be i and set it to 0
    la x9, a # loading address of a to x9
    la x22, b # loading address of b to x22
    
loop1: 
    bge x8, x5, exit # if i > size of arr it wil goto exit
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address off a and put it to x19
    add x20, x18, x22 # add i*4 to the base address off a and put it to x20
    lw x19, 0(x19) # load a[i] into x19
    lw x20, 0(x20) # load b[i] into x20
    # a[i] * b[i]
    mul x21, x19, x20 
    add x6, x6, x21 # sop +=  a[i] * b[i]
    addi x8, x8, 1 # i++
    j loop1 
  
exit:
    #print int sum1
    addi a0, x0, 1
    add a1, x0, x6
    ecall
    
    # print a newline character use print string
    addi a0, x0, 4
    la a1, newline
    ecall
    
    #exit cleanly
    addi a0, x0, 10
    ecall
