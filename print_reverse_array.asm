# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"

.text
printA:
    # TODO: Write your function code here

	move $t0 $a0
	move $t8 $a0

	li $t1 4
	mult $a1 $t1
	mflo $t1
	addi $t1 $t1 -4 
	addu $t0 $t0 $t1 # index of last element in the array

	li $v0 1

	loop:
		lw $a0 0($t0)
		syscall

		addi $t0 $t0 -4
		bge $t0 $t8 loop

	jr $ra

main:
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printA

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0 10
	syscall

