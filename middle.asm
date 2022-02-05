# middle.asm program
# Brian Ozawa Burns

.data

        # TODO: Complete these declarations / initializations

    prompt: .asciiz "Enter the next number:\n"
    middle: .asciiz "Second Largest: "
    newline: .asciiz "\n"

#Text Area (i.e. instructions)
.text

main:
    # TODO: Write your code here
    # You can have other labels expressed here, if you need to
    # get three inputs
    la $a0 prompt
    li $v0 4
    syscall
    li $v0 5
    syscall
    move $t0 $v0

    li $v0 4
    syscall
    li $v0 5
    syscall
    move $t1 $v0

    li $v0 4
    syscall
    li $v0 5
    syscall
    move $t2 $v0

    la $a0 middle
    bgt $t0 $t1 t0_gt_t1
    bgt $t0 $t2 t0_gt_t2 # if reached, t0 is middle
    bgt $t2 $t1 t2_gt_t1 # if reached, t1 is middle
    j t2_is_middle # if reached, t2 is middle
    

t0_gt_t1:
    bgt $t2 $t0 t0_is_middle
    bgt $t1 $t2 t1_is_middle
    j t2_is_middle

t0_gt_t2:
    li $v0 4
    syscall
    move $a0 $t0
    li $v0 1
    syscall
    j exit

t2_gt_t1:
    li $v0 4
    syscall
    move $a0 $t1
    li $v0 1
    syscall
    j exit

t0_is_middle:
    li $v0 4
    syscall
    move $a0 $t0
    li $v0 1
    syscall
    j exit

t1_is_middle:
    li $v0 4
    syscall
    move $a0 $t1
    li $v0 1
    syscall
    j exit

t2_is_middle:
    li $v0 4
    syscall
    move $a0 $t2
    li $v0 1
    syscall
    j exit

exit:
    # TODO: Write code to properly exit a SPIM simulation
    li $v0 10
    syscall
