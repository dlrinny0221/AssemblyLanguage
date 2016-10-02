; CMPE 12 - Winter 2014

; TA: Kendall Lewis

; Yunyi Ding
; Lab 3

; subtraction.asm

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



; print out the subtraction result sentence
	LEA	R0, SUB_RESULT

	PUTS



; SUBTRACTION

; subtract (R1 - R2)

; GET ascii 48
	LD	R4, ASCII

; get first number entered
	LD	R1, USERINPUT1

; get real value of first number
	ADD	R1, R1, R4

; get second number and keep its value now
	LD	R2, USERINPUT2



; create the negative of R2

	NOT	R2, R2
	
	ADD	R2, R2, #1
	

; subtract - R0 now holds the result of subtraciton

	ADD	R0, R1, R2

; store the result
	STI	R0, SUBTRACTION	

; print out the subtraction result

	PUTC



	HALT

; strings
GREETING:	.STRINGZ	"\nHello, there!\n"

PROMPT1:	.STRINGZ	"\nPlease enter a 1-digit number: \n"

PROMPT2:	.STRINGZ	"\nPlease enter another 1-digit number: \n" 

NEWLINE:	.STRINGZ	"\nThe number you entered is: "

SUB_RESULT:	.STRINGZ	"\nThe SUBTRACTION result of these two numbers is: \n"



; variables
SUBTRACTION:	.FILL	x3100
USERINPUT1:	.FILL	x4100

USERINPUT2:	.FILL	x4101

ASCII:		.FILL	#48
ASCII_OFFSET:	.FILL	#-48

; end of code

	.END

