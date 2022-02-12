# conversion.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here
    li $t0 0 # i
    li $t1 0 # z
    li $t8 8 # constant 8
    loop:
        mult $a0 $t8
        mflo $t3
        sub $t1 $t1 $t3
        add $t1 $t1 $a1

        blt $a0 2 post_if
        addi $a1 $a1 -1
        post_if:

        addi $t0 $t0 1
        blt $t0 8 loop

    move $v0 $t1
    jr $ra

main:
	li $a0, 5
    li $a1, 7

    jal conv

	move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0 10
    syscall
