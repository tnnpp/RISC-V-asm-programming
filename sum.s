#sum.c
.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline: .string "\n"

.text 
main:
# Registers Not to be used x0 t0 x4 and x10 to x17
# Register that we can use x5 to x9 and x18 to x31
# int size = 10, i, sum1 = 0, sum2 = 0;
    addi x5, x0, 10 # let x5 be size and set it to 10
    addi x6, x0, 0  # let x6 be sum1 and set it to 0
    addi x7, x0, 0  #let x7 be sum2 and set it to 0
#   for(i = 0; i < size; i++)
#       arr1[i] = i + 1;
    addi x8, x10, 0 # let x8 be i and set it to 0
    la x9, arr1 # loading address of arr1 to x9
    
loop1: 
    bge x8, x5, exit1 # if i > size of arr it wil goto exit
    # we need to calculate &arr1[i]
    # we need the base address of arr1
    # then, we add an offset of i*4 to the base address 
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address off arr1 and put it to x19
    addi x20, x8, 1 # set x20 to i +1 
    sw x20, 0(x19) # arr[1] = i+1 (store x20 in x19's adress)
    addi x8, x8, 1 # i++
    j loop1 
  
exit1:
    addi x8, x8, 0 # set i to zero
    la x21, arr2 # loading the adress off arr1 and put it to x21
    
loop2:
    bge x8, x5, exit2 # if i > size of arr it wil goto exit
    # we need to calculate &arr1[i]
    # we need the base address of arr1
    # then, we add an offset of i*4 to the base address 
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x21 # add i*4 to the base address off arr2 and put it to x19
    add x20, x8, x8 # set x20 to i + i : (2*i) : x8+x8 = 2*x8
    sw x20, 0(x19) # arr[1] = i+1 (store x20 in x19's adress)
    addi x8, x8, 1 # i++
    j loop2
exit2:
    addi x8, x0, 0 #reset i to 0
loop3:
    bge x8, x5, exit3 
    # sum1 + arr1[i]
    # need &arr1[i]
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address off arr1 and put it to x19
    lw x20, 0(x19) # x20 has arr1[i]
    add x6, x6, x20 # sum1 + arr1[i]
    # sum2 + arr2[i]
    add x19, x18, x21 # add i*4 to the base address off arr1 and put it to x1
    lw x20, 0(x19) # x20 has arr2[i]
    add x7, x7, x20 # sum2 +arr2[i]
    addi x8, x8, 1 # i++
    j loop3
exit3:
    #print int sum1
    addi a0, x0, 1
    add a1, x0, x6
    ecall
    
    # print a newline character use print string
    addi a0, x0, 4
    la a1, newline
    ecall
    
    #print int sum2
    addi a0, x0, 1
    add a1, x0, x7
    ecall
    
    # print a newline character use print string
    addi a0, x0, 4
    la a1, newline
    ecall
    #exit cleanly
    addi a0, x0, 10
    ecall
