; CMPE 12 - Winter 2014

; Yunyi Ding
; TA: Kendall Lewis

; Lab 3

; multiplication.asm

;
; This program takes as input 2 1-digit decimal numbers from the user,

; and will then perform a subtraction, multiplication, and division of the

; two inputs.

;

; The results will be stored in the memory locations.

; x3100 SUBTRACTION

; x3101 MULTIPLICATION

; x3102 DIVISION

; x3103 REMAINDER OF DIVISION

;


; The code will begin in memory at the address

; specified by .orig <number>.


	
	.ORIG   x3000



START:
; clear all registers that we may use

	AND	R0, R0, 0

	AND	R1, R0, 0

	AND	R2, R0, 0

	AND	R3, R0, 0

	AND	R4, R0, 0


	AND	R5, R0, 0
	AND	R6, R0, 0
	AND	R7, R0, 0

; print out a greeting

	LEA	R0, GREETING

	PUTS



; print out a PROMPT

	LEA	R0, PROMPT1

	PUTS


; get a user-entered number
 
	GETC

	PUTC


; STORE the first number

	ST	R0, USERINPUT1


; print out a new line

	LEA	R0, NEWLINE

	PUTS


; print out the number entered

	LD	R0, USERINPUT1

	PUTC	
	


; print out another PROMPT

	LEA	R0, PROMPT2

	PUTS


; get a user-entered number

	GETC

	PUTC


; Store the second entered number

	ST	R0, USERINPUT2

; print out a new line

	LEA	R0, NEWLINE

	PUTS

; print out the number entered

	LD	R0, USERINPUT2

	PUTC






; MULTIPLICATION

; MULTIPLY (R1 * R2)


; R3 stores the sum

	AND	R3, R3, #0

; R4 is the COUNTER

	AND	R4, R4, #0

; inverse ascii offset

	LD	R5, ASCII_OFFSET


; get the first number

	LD	R1, USERINPUT1

; get real value of R1

	ADD	R1, R1, R5


; get second number

	LD	R2, USERINPUT2

	ADD	R2, R2, R5

; SET UP for multiplication LOOP

; fill COUNTER with multiplier


MULTIPLY:

	ADD	R3, R3, R1

; let R2 be the COUNTER

	ADD	R2, R2, #-1
 
	BRp	MULTIPLY


	
STI	R3, MULTIPLICATION


; print out correct 2-digit decimal result
; we need a loop like division loop

; R4 is counter	
CORRECT:
	ADD	R4, R4, #1
	ADD	R3, R3, #-10
	BRn	NEG
	BRz	Z
	BRp	CORRECT

NEG:
	ADD	R4, R4, #-1
	ADD	R3, R3, #10
Z:
	LD	R5,ASCII
; store the second degit
	ST	R4, SECOND
;store the first digit
	ST	R3, FIRST

;print out the result sentence
	LEA	R0, MULT_RESULT
	PUTS	
; print out the second dight which is R4 * 10
	ADD	R0, R4,R5
	PUTC
; print out the first dight
	ADD	R0,R3,R5
	PUTC
	

	HALT

; strings
GREETING:	.STRINGZ	"\nHello, there!\n"

PROMPT1:	.STRINGZ	"\nPlease enter a 1-digit number: \n"

PROMPT2:	.STRINGZ	"\nPlease enter another 1-digit number: \n" 

NEWLINE:	.STRINGZ	"\nThe number you entered is: "

MULT_RESULT:	.STRINGZ	"\nThe MULTIPLICATION result of these two numbers is: \n"



; variables
MULTIPLICATION	.FILL	x3101
USERINPUT1:	.FILL	x4100

USERINPUT2:	.FILL	x4101

ASCII:		.FILL	#48
ASCII_OFFSET:	.FILL	#-48
FIRST:		.FILL	x2001
SECOND:		.FILL	x2000

; end the code
	.END


