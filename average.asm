


	.text
	.globl __start
	
__start:
	la $a0, prompt 		#load prompt string
	li $v0, 4		#print prompt string
	syscall
	
	li $v0, 5		#prompt an integer
	syscall
	move $t0, $v0		#move the integer to a temporary location
	move $t2, $0		#initialize $t2 to 0
	
	jal loop
	
	
	li $v0, 10
	syscall
	
	
loop: 	add $t2,$t2,1		#increment $t2, count of the loop
	la $a0, loopstr		#load loopstr string
	li $v0, 4		#print loopstr
	syscall 
	
	move $a0, $t2 		#load count
	li $v0, 1		#print count
	syscall
	
	la $a0, endl		#load endl
	li $v0, 4		#print endl
	syscall
	
	li $v0, 5		#prompt integer
	syscall
	
	add $t1,$t1, $v0	#add to sum
	sub $t0,$t0,1		#decrement loopy variable
	bgt $t0,0,loop		#check loop condition
avg:	div $t3,$t1,$t2
	la $v0, result
	li $v0, 4
	syscall
	
	move $a0, $t3
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
done: 	jr $ra


	.data
prompt:	.asciiz"Enter how many numbers you will take the average of\n"
loopstr:.asciiz"Enter number #"
endl:	.asciiz"\n"
result:	.asciiz"The result is "