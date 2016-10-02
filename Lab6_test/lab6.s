/* Push a register*/
.macro  push reg
sw      \reg, ($sp)
addi    $sp, $sp, -4
.endm

/* Pop a register*/
.macro  pop reg
addi    $sp, $sp, 4
lw      \reg, ($sp)
.endm
	
#include <WProgram.h>

/* Jump to our customized routine by placing a jump at the vector 4 interrupt vector offset */
.section .vector_4,"xaw"
	j T1_ISR

/* The .global will export the symbols so that the subroutines are callable from main.cpp */
.global PlayNote
.global SetupPort
.global SetupTimer 

/* This starts the program code */
.text
/* We do not allow instruction reordering in our lab assignments. */
.set noreorder

	

/*********************************************************************
 * myprog()
 * This is where the PIC32 start-up code will jump to after initial
 * set-up.
 ********************************************************************/
.ent myprog

myprog:
/* This should set up Port D pin 8 for digital output */
SetupPort:
	li	$t0, 0x8
	la	$t1, TRISD
	sw	$t0, 4($t1)
	
	jr	$ra
	nop

/*loop:
*	la	$t0, PORTD
*	li	$t1, 0x8
*	sw	$t1, 12($t0)
*	li	$a0,1
*	jal	delay
*	nop
*	j	loop
*	nop
	
*	jr $ra
*	nop
	
*	j	done
*	nop
	
*delay:
*# clear $t3, counter
*li		$t3, 0
*# set constant1 to last for 1 second
*li		$t4, 1000

*loop1:
*# when $t1 = $t0, then go to done
*beq		$t4, $t3, done
*nop
*# increase counter by 1
*addi	$t3, $t3, 1
*# set constant2 80mhz/numbers of instructions
*li		$t2, 25000
*# go to loop2
*b		loop2
*nop

*loop2:
*# decrease constant2 by 1
*addi	$t2, $t2, -1
*# if $t2 is greater than 0, go back to loop2
*bge		$t2, $t3, loop2
*nop
*# otherwise, go back to loop1
*b		loop1
*nop

*done:
*	j	loop
*	nop
*/

/* This should configure Timer 1 and the corresponding interrupts,
 * but it should not enable the timer.
 */
 
 
SetupTimer:	
	
	jr $ra
	nop

	
/* This should take the following arguments:
*  $a0 = tone frequency
*  $a1 = tone duration
*  $a2 = full note duration ($a2 - $a1 is the amount of silence after the tone)
*/
PlayNote:
	
	push $ra
	push $s0
	push $s1

	
	pop $s1
	pop $s0
	pop $ra
	
	jr $ra
	nop
	


	
/* This procedure is not required, but I found it easier this way. It is not called from main.cpp. */
/* This turns on the timer to start counting */	
EnableTimer:
	jr $ra
	nop
	
/* This procedure is not required, but I found it easier this way. It is not called from main.cpp. */
/* This turns off the timer from counting */
DisableTimer:
	jr $ra
	nop
	
	
/* The ISR should toggle the speaker output value and then clear and re-enable the interrupts. */
T1_ISR:
	
	eret
	
	

.end myprog /* directive that marks end of 'myprog' function and registers
           * size in ELF output
           */

