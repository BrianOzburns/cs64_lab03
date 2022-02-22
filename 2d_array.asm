.data 
    array: 
            .word 1, 2, 9
            .word 1, 6, 2
            .word 1, 3, 2
            .word 1, 12, 2

    row_size: .word 4
    column_size: .word 3 

    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"
    space: .asciiz " "
    
.text

main: 
    jal print_2D

    la $a1, row_size
    lw $a1, 0($a1) 	# a1 stores row_size
    la $a2, column_size
    lw $a2, 0($a2) 	# a2 stores column_size 
    la $a0, array 	# a0 stores array address
    jal sort_by_row
    
    jal print_2D
    j Exit

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

print_2D: 
    li $t0, 0 	# row counter
    li $t1, 0 	# column counter 

    la $t2, row_size
    lw $t2, 0($t2) 	# t2 stores row_size
    la $t3, column_size
    lw $t3, 0($t3) 	# t3 stores column_size 

    la $t4, array 	# t4 stores array address

    iterate_row:
        #   reset column counter
        li $t1, 0 

        iterate_col:
            #   offset  =  ((colSize * curRow) + curCol) * 4
            mult $t3, $t0  
            mflo $t5
            add $t5, $t5, $t1
            sll $t5, $t5, 2
            add $t5, $t4, $t5 # add offset with array 
            
            #   start printing word at position 
            li $v0, 1
            lw $a0, 0($t5)
            syscall 

            li $v0, 4
            la $a0, space
            syscall 

            #   increment column counter
            addi $t1, $t1, 1
            blt $t1, $t3, iterate_col

        #   increment row counter
        addi $t0, $t0, 1

        # add new line 
        li $v0, 4
        la $a0, newline
        syscall

        blt $t0, $t2, iterate_row
    
    jr $ra 

average_row:
    # a0 stores row address return average of row in $v0

    move $t0, $a0

    la $t1, column_size
    lw $t1, 0($t1)

    li $t2, 0 	# $t2 is loop counter 
    li $t3, 0 	# total sum 
    sum_row_loop: 
        #   offset = loop counter * 4
        sll $t4, $t2, 2
        add $t4, $t4, $t0 
        lw $t4, 0($t4)

        add $t3, $t3, $t4

        #   increment loop counter 
        add $t2, $t2, 1 
        blt $t2, $t1, sum_row_loop
    
    div $t3, $t1
    mflo $v0 

    jr $ra 

swap_rows: #takes in the address of the rows you want to swap and swaps them.
    addi $sp, $sp, -20
    sw $s0, 0($sp) 
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $ra, 16($sp)

    move $s0, $a0 # address of row1
    move $s1, $a1 # address of row2

    la $s2, column_size
    lw $s2, 0($s2)

    li $s3, 0 # counter 

    swap_iterate: 
        sll $t0, $s3, 2 
        add $t1, $t0, $s0 
        add $t2, $t0, $s1

        # swap elements in array 
        lw $t3, 0($t1)
        lw $t4, 0($t2)
        sw $t3, 0($t2)
        sw $t4, 0($t1)

        # increment loop counter
        addi $s3, $s3, 1
        blt $s3, $s2, swap_iterate 

    jal ConventionCheck

    lw $s0, 0($sp) 
    lw $s1, 4($sp) 
    lw $s2, 8($sp) 
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addiu $sp, $sp, 20
    
    jr $ra

# COPYFROMHERE - DO NOT REMOVE THIS LINE

sort_by_row: 
    # a0 stores the array address, a1 and a2 store the size of row and column respectively

    # offset  =  ((column_Size * current_Row) + current_Column) * Data_size
    # For e.g., If you want to find the address of a12 in the above array, then
	# offset = (( 3 * 1) + 2) * 4 = 20         
    # Data_size=4 because we are working with integers

    addi $sp, $sp, -32
    sw $s0, 0($sp) 
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    sw $s6, 24($sp)
    sw $ra, 28($sp)

    move $s0 $a0
    move $s1 $a1
    move $s2 $a2
    
    li $s3 0 # outer loop counter
    li $s4 0 # inner loop counter

    outer_loop:

        inner_loop:

            #li $t0 0 # Let $t0 be the address offset
            #li $t1 4
            #mult $s2 $t1
            #mflo $t0
            #mult $t0 $s4
            #mflo $t0
            #add $s6 $t0 $s0
            mult $s2 $s3
            mflo $t0
            add $t0 $t0 $s4
            li $t1 4
            mult $t0 $t1
            mflo $t0
            add $s6 $t0 $s0

            move $a0 $s6 # Find average of row j
            jal average_row
            move $s5 $v0

            #addi $s6 $s6 12
            ##li $t0 0 # Let $t0 be the address offset
            ##li $t1 4
            ##mult $s2 $t1
            ##mflo $t0
            ##addi $t6 $s4 1
            ##mult $t0 $t6
            ##mflo $t0
            ##add $s6 $t0 $s0
            # offset  =  ((column_Size * current_Row) + current_Column) * Data_size
            addi $t6 $s3 1
            mult $s2 $t6
           #mult $s2 $s3
            mflo $t0
            add $t0 $t0 $s4
            li $t1 4
            mult $t0 $t1
            mflo $t0
            add $s6 $t0 $s0
            #addi $s6 $s6 12

            move $a0 $s6 # Find average of row (j+1)
            jal average_row
            move $t9 $v0

            li $v0 1
            lw $t8 0($s6)
            move $a0 $t8
            syscall

            li $t4 -4
            mult $t4 $s2
            mflo $t6
            add $s6 $s6 $t6

            li $v0 1
            lw $t8 0($s6)
            move $a0 $t8
            syscall
            j in_order

            bge $t9 $s5 in_order
            # move $a0 $s5 # need to move address of row j
            # move $a1 $t9 # need to move address of row (j+1)

            move $a0 $s6
            li $t4 -4
            mult $t4 $s2
            mflo $t6
            add $s6 $s6 $t6
            move $a1 $s6

            jal swap_rows
            #jal ConventionCheck

            in_order:

            addi $s4 $s4 1
            addi $t5 $s1 -1
            sub $t6 $t5 $s3 # inner_loop comparison

            blt $s4 $t6 inner_loop

        addi $t5 $s1 -1 # outer_loop comparison

        addi $s3 $s3 1
        blt $s3 $t5 outer_loop

    lw $s0, 0($sp) 
    lw $s1, 4($sp) 
    lw $s2, 8($sp) 
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $s5, 20($sp)
    lw $s6, 24($sp)
    lw $ra, 28($sp)
    addiu $sp, $sp, 32

    # Do not remove this line
    jr $ra