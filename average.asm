	.globl __start
	.text			#text segment of the program

__start:
	la $a0, prompt 		#load address of the string to be printed
				#to print strings, integers and all, load the printee to $a0, (argument zero)
	li $v0, 4		#syscall 4 --print the string whose address is given
	syscall
	
	li $v0, 5		#syscall 5 --prompt an integer
	syscall			#this integer is the number of integers whose average will be computed
				#the number pops up at $v0 after user enters it
	
	move $t0, $v0		#move the value at $v0 to $t0 // $v0 is used for function returns and syscalls
				#so you can't expect to store a variable in that register
				#now, $t0 is the number of integer inputs
	
	move $t2, $0		#initialize $t2 to 0, this will be the counter for the loop
	
	jal loop		#JUMP to loop AND LINK to current $pc (program counter) + 4
				# what it does is it jumps to loop and sets $ra (return address)
				# to $pc+4, when jr $ra is executed program returns to executing the
				# next instruction following $pc, in this case $pc => jal loop
				# it'll execute li $v0, 10

	li $v0, 10		#syscall to terminate program
	syscall
	
	
loop: 	add $t2,$t2,1		#increment $t2, count of the loop
	la $a0, loopstr		#load the address of loopstr string
	li $v0, 4		#print loopstr
	syscall 
	
	move $a0, $t2 		#move the value of $t2 to $a0
	li $v0, 1		#print how many numbers've been take so far, syscall 1 --prints integer
	syscall
	
	la $a0, endl		#load endl
	li $v0, 4		#print new line
	syscall
	
	##continue taking integer inputs
	li $v0, 5		#prompt integer
	syscall
	
	add $t1,$t1, $v0	#add the current integer input to sum of all so far
	sub $t0,$t0,1		#decrement $t0, which was originally the number of integer inputs,
				#if it equals zero, then no other integer input is left to be taken
	bgt $t0,0,loop		#if number of remaining inputs is greater than zero, continue the loop
				#otherwise it goes to the next line of instructions

avg:	div $t3,$t1,$t2		# divide $t1 (sum) by $t2 (num of integers) and put the result in $t3
	la $v0, result		# load the address of result string
	li $v0, 4		# print result string
	syscall			# syscall 4 --print string
	
	move $a0, $t3		# move the value of $t3 (average of given integers) to $a0 (argument for functions and syscalls)
	li $v0, 1		# syscall 1-- prints integer
	syscall
	
	la $a0, endl		#print new line
	li $v0, 4
	syscall
	
done: 	jr $ra			# go to return address, in this case it's the address of the next instruction from "jal loop"

	
	.data			#data segment of the program
prompt:	.asciiz"Enter how many numbers you will take the average of\n"
loopstr:.asciiz"Enter number #"
endl:	.asciiz"\n"
result:	.asciiz"The result is "
