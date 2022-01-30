# arithmetic.asm
# A simple calculator program in MIPS Assembly for CS64
# calculating 64*(x-y)+32 for first user input x and second user input y

.text
main:
	# TODO: Write your code here
	li $v0 5
	syscall
	move $t0 $v0 #x

	li $v0 5
	syscall
	move $t1 $v0 #y

	sub $t1 $t0 $t1
	sll $t1 $t1 6
	addi $t1 $t1 32

	li $v0 1
	move $a0 $t1
	syscall

exit:
	# Exit SPIM: Write your code here!
	li $v0 10
	syscall
