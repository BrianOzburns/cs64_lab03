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