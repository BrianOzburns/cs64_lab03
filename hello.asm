# hello.asm
# A "Hello World" program in MIPS Assembly for CS64
#
#  Data Area - allocate and initialize variables
.data
	# TODO: Write your string definitions here
	prompt: .asciiz "Enter an integer: "

#Text Area (i.e. instructions)
.text
main:
	# TODO: Write your code here
	li $v0 4
	la $a0 prompt
	syscall

	li $v0 5
	syscall
	move $t0 $v0
	andi $t1 $t0 1 #mask with 1 and store in register t1

	beq $t1 $0 if_even
	j if_odd

if_even:
	li $t2 6
	mult $t0 $t2
	j after_if

if_odd:
	li $t2 9
	mult $t0 $t2
	j after_if

after_if:
	mflo $t0
	li $v0 1
	move $a0 $t0
	syscall

exit:
	# Exit SPIM: Write your code here!
	li $v0 10
	syscall
