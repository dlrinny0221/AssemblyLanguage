/* http://tigcc.ticalc.org/doc/gnuasm.html */
	
	
#include <WProgram.h>
/* define all global symbols here */
.global myprog	
.text	
.set noreorder

.ent myprog 
/* directive that marks symbol 'main' as function in ELF   
 * output
           */
myprog:
	
	jal		initTmp		/* initialize temp array 0*/
	nop
	
	/* Print original message */
	la      $a0,Serial 			
	la 		$a1, msg			
	jal     _ZN5Print7printlnEPKc
	nop 
	
	
/*loop:	*/	
/*	j       loop*/
/*   nop*/
	
		
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
/*	jr		$ra*/
/*	nop*/
	
/* counter $t4*/

	li		$t4, 0
	
	
getChar:
	la		$t0, msg
	
loop1:
	lb		$t0, 0($t0)
	beqz	$t0, stringEnd
	addi	$sp, $sp, -1
	sb		$t0, 0($sp)
	addi	$t1, $t1, 1
	j loop1
	
	stringEnd:
la $t1, msg

storeLoop:
	lb $t0, 0($t0)
	beqz $t0, end
	lb $t4, 0($sp)
	sb $t4, 0 ($t0)
	addi $t1, $t1, 1
	addi $sp, $sp, 1
	j storeLoop
	
end:
la $a0, ans
li $v0, 4
syscall

move $a0, $t4
li $v0, 4
syscall
	

	

	/* return to main */
	
.end myprog 
/* directive that marks end of 'main' function and registers
           
 * size in ELF output
           */
	

.data
zChar:	.byte	0					/* Used to clear the temporary array */
msg:	.ascii	"hello world\0"		/* will contain message to be reversed */ 	
tmp:	.space 	10					/* temporary array to contain reversed word */
ans: .asciiz "The string reversed is : " 



