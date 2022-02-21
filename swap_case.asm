# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"

.text

main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal Swap_Case

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    # addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

#Swap_Case:
    #TODO: write your code here, $a0 stores the address of the string
    # upper +32 --> lower
    # lower -32 --> upper

    move $t1 $s0 # use t1 as address of string stored in s0
    
    lb $t0 0($t1)
    li $v0 11
    move $a0 $t0
    syscall

    addi $t1 $t1 4
    lb $t0 0($t1)
    move $a0 $t0
    syscall

    # Do not remove this line
    jr $ra

Swap_Case:
    #TODO: write your code here, $a0 stores the address of the string
    # upper +32 --> lower
    # lower -32 --> upper

    move $t1 $s0 # use t1 as address of string stored in s0
    li $t8 0
    

    loop:

        lb $t0 0($t1)
        move $t2 $t0

        bge $t0 65 upper
            j not_character

        upper:
            ble $t0 90 is_upper_character

        lower:
            ble $t0 96 not_character
            ble $t0 122 is_lower_character
            j not_character

        is_upper_character:
            addi $t0 $t0 32

        is_lower_character:
            addi $t0 $t0 -32

        print_convention:
            li $v0 11
            move $a0 $t2
            syscall
            lb $a0 newline
            syscall
            move $a0 $t0
            syscall
            lb $a0 newline
            syscall

            ori $v0 $0 4
            la $a0 convention
            syscall

        not_character:
            addi $t1 $t1 1
            addi $t8 $t8 1

        #beq $t1 100 post_loop
        beq $t8 25 post_loop
        j loop

    post_loop:
    # Do not remove this line
    jr $ra