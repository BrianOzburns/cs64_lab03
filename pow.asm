# Pow.asm program
# Brian Ozawa Burns

# C++ (NON-RECURSIVE) code snippet of pow(x,n):
#	int x, n, pow=1; 
#   cout << "Enter a number x:\n"; 
#   cin >> x;
#   cout << "Enter the exponent n:\n"; 
#   cin >> n; 
#   for (int i = 1; i <= n; i++) { 
#   	pow = pow * x; 
#   } 
#   cout << "Power(x,n) is:\n" << pow << "\n";
#
# Assembly (NON-RECURSIVE) code version of pow(x,n):
#
.data
	# TODO: Write your initializations here
	x_prompt: .asciiz "Enter a number x:\n"
	n_prompt: .asciiz "Enter the exponent n:\n"
	answer: .asciiz "Power(x,n) is:\n"

#Text Area (i.e. instructions)
.text
main:
	# TODO: Write your code here
	li $v0 4
	la $a0 x_prompt
	syscall
	li $v0 5
	syscall
	move $t0 $v0

	li $v0 4
	la $a0 n_prompt
	syscall
	li $v0 5
	syscall
	move $t1 $v0

	li $t2 1 # answer
	blt $t1 1 print

loop:
	mult $t2 $t0
	mflo $t2
	addi $t1 -1
	bge $t1 1 loop

print:
	li $v0 4
	la $a0 answer
	syscall
	li $v0 1
	move $a0 $t2
	syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0 10
	syscall
