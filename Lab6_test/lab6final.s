# Lab 6, Timers and Interrupts
# lab6.s
# Yunyi Ding, Andy Ly
# 3/12/14
# Section 2, MW 12:30-2:30
# TA: Kendall Lewis

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

/* This should set up Port D pin 8 for digital output */
SetupPort:

	/* use knowledge gained from lab5 
	 * Virtual address: 0xBF88_ 
	 * TRISD: 0xBF88_60C0; 
	 * PORTD: 0xBF88_60D0; 
	 * LATD:  0xBF88_60E0; 
	 * ODCD:  0xBF88_60F0 
	 */
	 
#clear bit 3 of TRISD
	li		$t0, 0x8
	la		$t1, TRISD
	sw		$t0, 4($t1)

/* To test port D create a loop
 * and toggle PORTD. Connect speaker to the correct pin
 * and listen for sound. WE GET RID OF IT AFTER WE TESTED
*/
	 
/*loop:
*	la		$t0, PORTD
*	li		$t1, 0x8
*	sw		$t1, 12($t0)
*	li		$a0, 1
*	jal		delay
*	nop
*	j		loop
*	nop
*	
*	jr $ra
*	nop
*	j	Done
*/	

/*delay:
*	# clear $t4, counter
*	li		$t4, 0
*	# set constant1 to last for 1 second
*	li		$t5, 1000
*	loop1:
*# when $t1 = $t0, then go to done
*	beq		$t5, $t4, done
*	nop
*	# increase counter by 1
*	addi	$t4, $t4, 1
*	# set constant2 80mhz/numbers of instructions
*	li		$t3, 25000
*	# go to loop2
*	b		loop2
*	nop
*
*	loop2:
*	# decrease constant2 by 1
*	addi	$t3, $t3, -1
*	# if $t3 is greater than 0, go back to loop2
*	bge		$t3, $0, loop2
*	nop
*	# otherwise, go back to loop1
*	b		loop1
*	nop
*
*done:
*j       loop
*        nop
*/			
#	jr		$ra

#	nop

	jr 		$ra
	nop

/* This should configure Timer 1 and the corresponding interrupts,
 * but it should not enable the timer.
 */
SetupTimer:	
	/* Section 14 - 16-Bit Synchronous counter initialization steps */
	/* Lecture slide about interrupts */

	/* SETTING UP TIMER1 */
	/*******************************************************************************/
	/* T1CON = 0xBF80_0600
	 * TMR1 = 0xBF80_0610
	 * PR1 = 0xBF80_0620
	 * TCKPS = T1CON[5:4] = 0b11 to divide sysclk by 256
	 * TMR1 is current timer value (16 bits)
	 * PR1 is period value (16 bits)
	 */

	/* clear T1CON - put it in known state */
	li		$t0, 0xFFFF
	la		$t1, T1CON
	sw		$t0, 4($t1)
	/* Set T1CKPS - set the prescaler */
	li		$t2, 48
	sw		$t2, 8($t1)
	
	/* Clear TMR1 value - clear the counts if it was used */
	la		$t3, TMR1
	sw		$t0, 4($t3)
	
	/* Set PR1 - set the period */
	li $t4, 255
	la $t5, PR1
	sw $t4, 8($t5)
	
	
	/* SETTING UP TIMER1 CORRESPONDING INTERRUPTS */
	/*******************************************************************************/
	/* IEC0 = oxBF88_1060
	 * IFS0 = 0xBF88_1030
	 * IPC1 = 0xBF88_10A0
	 * T1IE - timer1 interrupt enable (IEC04)
	 * T1IF - timer1 interrupt signal (IFSO4)
	 * T1IP<2:0> - timer 1 interrup priority (IPC1[4:2])
	 */
  
	/* Set T1IP - set the interrupt priority */
	li $t0, 16
	la $t1, IPC1
	sw $t0, 8($t1)
	
	/* ISR priority should be 4 */	
	/* Clear T1IF - clear any prior interrupt */
	li $t2, 16
	la $t3, IFS0
	sw $t2, 4($t3)
	/* Enable T1IE - enable the interrupts */
	la $t4, IEC0
	sw $t2, 8($t4)
	
	
	/* DO NOT TURN ON THE TIMER HERE (T1CON[15])(NOTE: Maybe later) */
	
	#add in
	li $t3, 32768
	la $t4, T1CON
	
	/* To test interrupt and T1_ISR, turn on timer here.
	 * Toggle port D in T1_ISR. Connect speaker in correct pin and
	 * listen for sound.
	 */
	  
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

	/* what should be done here? */
	/* use delay subroutine for tone duration and silence */

	#156250, MAKES IT SOUND MORE 8 BIT, 62500 is 16,000,000/256
	# li $t0,312500
	li $t0,62500 			
	beq $a0, 0, dur
	nop
	div $t0, $a0
	mflo $t1
	
	la $t2, PR1
	sw $t1, 4($t2)
	
	la $t2, PR1
	sw $t1, 8($t2)
	
	li $t3, 32768
	la $t4, T1CON
	sw $t3, 8($t4)
		
#this implements the delay and tone
dur:
	and $a0, $a0, 0
	add $a0, $a0, $a1

	jal delay
	nop
	
	sw $t3, 4($t4)
	
	sub $a0, $a2, $a1
	
	jal delay
	nop
	
	#clear period
	la $t2, PR1
	sw $t1, 4($t2)
	
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
	/* Your program will go to ISR everytime an interrupt occurs, no matter which part you are in your program */
	/* So be carefull because it may overwrite your registers. So, OBEY REGISTER CALLING CONVENTIONS!!! */
	/* Save including t0-t9 */
	/* push */
	push $t0
	push $t1
	push $t2
	push $t3
	push $t4
	push $t5
	push $t6
	push $t7
	push $t8
	push $t9
	/* ISR body here */
	
	
	#change order later if needed
	#toggles portD	
	li $t4, 0x8
	la $t5, PORTD
	sw $t4, 12($t5)	
	
	/* Clear T1IF - clear any prior interrupt */
	li $t0, 16
	la $t1, IFS0
	sw $t0, 4($t1)
	#loads timer1
	li $t2, 0xFFFF
	la $t3, TMR1
	sw $t2, 4($t3)
	
	/* pop registers */
	pop $t9
	pop $t8
	pop $t7
	pop $t6
	pop $t5
	pop $t4
	pop $t3
	pop $t2
	pop $t1
	pop $t0
	
	/* ERET is return instruction */
	eret


.end myprog /* directive that marks end of 'myprog' function and registers
           * size in ELF output
           */

.data
hello: 	.ascii	"hello\0"
