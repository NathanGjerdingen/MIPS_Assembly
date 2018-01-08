# Kjell, Chapter 25, Exercise 1. Use a=1, b=2, c=3.
#
# Write a program to evaluate 3ab - 2bc - 5a + 20ac - 16
# 
# Prompt the user for the values a, b, and c. Try to use a 
# small number of registers. Use the stack to hold 
# intermediate values. Write the final value to the monitor.
	.text
        .globl  main

main: 	# Print prompt01
	li	$v0,4
	la	$a0,prompt01
	syscall	
	
	# Read in 'a' and store in $t0
	li	$v0,5
	syscall	
	move	$t0,$v0

	# Print prompt02
	li	$v0,4
	la	$a0,prompt02
	syscall
	
	# Read in 'b' and store in s$t1
	li	$v0,5
	syscall	
	move	$t1,$v0
	
	# Print prompt03
	li	$v0,4
	la	$a0,prompt03
	syscall
	
	# Read in 'c' and store in $t3
	li	$v0,5
	syscall	
	move	$t2,$v0
	
	# Calculate 3ab
	mult 	$t0,$t1		# Compute ab
	mflo	$t3		# Store ab in $t3
	li	$t4,3		# Load 3
	mult	$t3,$t4		# Compute 3ab
	mflo	$t4		# Store 3ab in accumulator
	subu    $sp,$sp,4      	# move stack pointer
        sw      $t4,($sp)	# push 3ab onto stack
        
        # Calculate - 2bc
        mult	$t1,$t2		# Compute bc
        mflo	$t3		# Store bc in $t3
        li	$t4,-2		# Load - 2
        mult	$t3,$t4		# Computer 2bc
        mflo	$t4		# Store 2bc in accumulator
        subu    $sp,$sp,4      	# move stack pointer
        sw      $t4,($sp)	# push 2bc onto stack
        
        # Calculate - 5a
        li 	$t4,-5		# Load - 5
        mult 	$t0,$t4		# Computer 5a
        mflo	$t4		# Store 5a in accumulator
        subu    $sp,$sp,4      	# move stack pointer
        sw      $t4,($sp)	# push 5a onto stack
        
        # Calculate 20ac
        mult	$t0,$t2		# Compute ac
        mflo	$t3		# Store ac in $t3
        li	$t4,20		# Load 20
        mult 	$t3,$t4		# Compute 20ac
        mflo	$t4		# Store 20ac in accumulator
        subu    $sp,$sp,4      	# move stack pointer
        sw      $t4,($sp)	# push 20ac onto stack
        
        # - 16
        li	$t4,-16
        subu    $sp,$sp,4      	# move stack pointer
	sw      $t4,($sp)	# push - 16 onto stack
	
	# Add it all up.
	lw      $t0,($sp)     	# pop - 16
	add	$t4,$0,$t0	# add to accumulator
        addu    $sp,$sp,4	# move stack pointer
	lw      $t0,($sp)     	# pop 20ac
	add	$t4,$0,$t0	# add to accumulator
        addu    $sp,$sp,4	# move stack pointer
        lw      $t0,($sp)     	# pop - 5a
	add	$t4,$0,$t0	# add to accumulator
        addu    $sp,$sp,4	# move stack pointer
        lw      $t0,($sp)     	# pop 2bc
	add	$t4,$0,$t0	# add to accumulator
        addu    $sp,$sp,4	# move stack pointer
        
        # Print prompt04
	li	$v0,4
	la	$a0,prompt04
	syscall
	
	# Print accumulated answer
        li	$v0,1
	la	$a0,($t4)
	syscall
        
		.data
prompt01:	.asciiz "\nEnter the value for a...\n"
prompt02:	.asciiz "\nEnter the value for b...\n"
prompt03:	.asciiz "\nEnter the value for c...\n"
prompt04: 	.asciiz "\nThe answer is: "
