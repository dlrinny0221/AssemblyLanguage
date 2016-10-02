/* http://tigcc.ticalc.org/doc/gnuasm.html */
# lab5b.s
# Yunyi Ding, Andy Ly
# March 2, 2014	
	
#include <WProgram.h>
/* define all global symbols here */
.global myprog	
.text	
.set noreorder

.ent myprog 
/* directive that marks symbol 'main' as function in ELF   
 * output
 */

# start the program
myprog:
# jump to the initTmp, initialize temp array 0, and then jump back
	jal		initTmp		
	nop
	
# Print original message
	la      $a0,Serial 			
	la 		$a1, msg			
	jal     _ZN5Print7printlnEPKc
	nop 

# get characters one by one from the array	
getChar:
# clear counter $t4
	li		$t4, 0
# load the starting point of the address of the message "hello world" to $t0
	la		$t0, msg
# load 32 (ascii number of <space>) to $t2
	li		$t2, 32

# we need a loop to read characters in the array one by one until null in the end	
loop1:
# load byte: load the character in the current index to $t1
	lb		$t1, 0($t0)
# increment the address of the index of array by 1
# be ready to go read the next character
	addi	$t0, $t0, 1
# if there is no more character, go to nullLoop
	beq		$t1,0, nullLoop
	nop
# if there is a <space>, go to spaceLoop
	beq		$t1, $t2, spaceLoop
	nop

# increment the counter $t4 by 1
	addi	$t4, $t4, 1
# jump to push: push each of the characters onto a stack until null
	jal		push
	nop
# jump to loop1 to read next character
	j		loop1
	nop

# pop and print characters when there is no more character in the string	
nullLoop:
# load the starting point of the empty array to $t5
	jal		initTmp		
	nop
	la		$t5,tmp
# we need a loop to pop and print
loop3:
# jump to pop character
	jal		pop
	nop
# decrement counter $t4 by 1
	addi	$t4, $t4, -1
# if the counter is greater than 0 then go back into the loop3 and pop again
	bgt		$t4,0, loop3
	nop
# print out everything and end the program
	jal		printdone
	nop

# pop and print characters when meets a space	
spaceLoop:
# load the empty array to $t5
	jal		initTmp		
	nop
	la		$t5,tmp
# we need a loop to pop and print
loop2:
# jump to pop character	
	jal		pop
	nop
# decrement the counter by 1
	addi	$t4, $t4, -1
# if the counter is bigger than 0, go back into the loop2 until 0
	bgt		$t4,0, loop2
	nop
# jump to print everything and go back to loop1 to read characters after the <space>
	jal		printspace
	nop
	j		loop1
	nop
	
# push characters onto the stack 
# the top of stake contains the last character we push onto
# and the base contains the first	
push:
# let pointer $sp points to the address that is above the last one
# every time we've done one push
	addu	$sp, $sp, -4
# store the character in $t1 to current address of the stack
	sb		$t1, 0($sp)
# jump back
	jr		$ra
	nop

# pop characters
# pop and print from the top of the stack
# so we pop out and print out the last character first
# the last character we pop and print out should be the first character we pushed onto the stack
pop:
# load byte: load the the character on the top stack back to $t1
	lb		$t1, 0($sp)
# store $t1 to the starting/current index of tmp
	sb		$t1, 0($t5)
# go to the next index
	addi	$t5, $t5, 1
# let pointer points to the next address: make this as the top of the stack
	addi	$sp, $sp, 4
# jump back
	jr		$ra
	nop

# print when there is a <space>	
printspace:
# print out the characters before <space>
	la      $a0,Serial 			
	la 		$a1, tmp		
	jal     _ZN5Print7printlnEPKc
	nop 
# then jump to loop1 to read characters after the <space>
	j 	loop1
	nop

# print when there is no more characters
printdone:
# print out the characters before end of the string
	la      $a0,Serial 			
	la 		$a1, tmp		
	jal     _ZN5Print7printlnEPKc
	nop 
# after print everything, then program ends
	j 	Done
	nop
		
/********************************************************/
/* Function: Initialize temp array with zeros */
/********************************************************/
initTmp:
	addi	$t7, $0, 10
	la		$t9, tmp
	nop
	lb		$t8, zChar
	nop
inloop:
	sb		$t8, 0($t9)
	addi	$t9, $t9, 1
	addi	$t7, $t7, -1
	beq		$t7, $0, indone
	nop
	j		inloop
	nop

indone:
	jr		$ra
	nop
/* return to main */

# prigram is done 
Done:
.end myprog 

/* directive that marks end of 'main' function and registers
           
 * size in ELF output
           */
	

.data
zChar:	.byte	0					/* Used to clear the temporary array */
msg:	.ascii	"This is a sentence\0"		/* will contain message to be reversed */ 	
tmp:	.space 	28					/* temporary array to contain reversed word */


