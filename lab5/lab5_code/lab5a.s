/* http://tigcc.ticalc.org/doc/gnuasm.html */
# lab5a.s
# Yunyi Ding, Andy Ly
# March 2, 2014	
	
#include <WProgram.h>

	

/* define all global symbols here */
	
.global myprog

/* define which section (for example "text")
     
 * does this portion of code resides in. Typically,
     
 * all your code will reside in .text section as
     
 * shown below.
    */
	
.text

	

/* This is important for an assembly programmer. This
     
 * directive tells the assembler that don't optimize
     
 * the order of the instructions as well as don't insert
     
 * 'nop' instructions after jumps and branches.
    */
	
.set noreorder



/*********************************************************************
 
 * main()
 
 * This is where the PIC32 start-up code will jump to after initial
 
 * set-up.
 
********************************************************************/



.ent myprog 
/* directive that marks symbol 'main' as function in ELF
           
 * output
           */



myprog:

jal 	EnableLED	# jump to subroutine to enable LED 5 (similar to JSR in LC3)
nop					# don't forget the nop

loop:
	

/* load register a0 with Serial object address */
	
la      $a0,Serial
	

/* load register a1 with string constant address */
	
la 	$a1,hello
	

/* call the C++ function to do Serial.println("Hello, world!") */
	
/* notice that the symbol name is "mangled" in C++ */
        
jal     _ZN5Print7printlnEPKc
nop

jal		LEDoff		# turn off led
nop

delay:
# clear $t0, counter
li		$t0, 0
# set constant1 to last for 1 second
li		$t1, 1000


loop1:
# when $t1 = $t0, then go to done
beq		$t1, $t0, done
nop
# increase counter by 1
addi	$t0, $t0, 1
# set constant2 80mhz/numbers of instructions
li		$t2, 25000
# go to loop2
b		loop2
nop

loop2:
# decrease constant2 by 1
addi	$t2, $t2, -1
# if $t2 is greater than 0, go back to loop2
bge		$t2, $0, loop2
nop
# otherwise, go back to loop1
b		loop1
nop

done:
jal		LEDon		# turn on led
nop	

j       loop
        nop
		
/* return to main */

################################
## Subroutine to enable LED 5 ##
################################
EnableLED:
	li 		$t9, 0x1			# li = pseudo op to load an immediate value into a register, 1 => $t9 
	li 		$t8, 0xbf886140  	# load address of TRISF into $t8 
	sw 		$t9, 4($t8)			# store $t9 into address defined by $t8 plus an offset of 4
								# this clears TRISF, making LED5 an output
	jr 		$ra					# jr is the return instruction (like RET in LC3), 
								# $ra is the return address (like R7 in LC3)
	nop
	
###########################
# turn on led5 subroutine #
###########################
LEDon:
	li 		$t9, 0x1
	li 		$t8, 0xbf886150		# load address of PORTF into $t8 
	sw 		$t9, 8($t8)			# store $t9 into PORTF with an offset of 8 to turn on LED5
	jr		$ra
	nop
	
###########################
# turn on led5 subroutine #
###########################
LEDoff:
	li 		$t9, 0x1
	li 		$t8, 0xbf886150
	sw 		$t9, 4($t8)			# store $t9 into PORTF with an offset of 4 to turn off LED5	
	jr		$ra
	nop	


.end myprog 
/* directive that marks end of 'main' function and registers
           
 * size in ELF output
           */
	

	

.data
hello:	
	

.ascii "Hello, world!\0"

