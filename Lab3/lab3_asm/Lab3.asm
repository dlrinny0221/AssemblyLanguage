; CMPE 12 - Winter 2014

; TA: Kendall Lewis

; Lab 3

; Lab3.asm

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

; greeting, prompt, and inputs
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

; SUBTRACTION
; subtract (R1 - R2)

; print out the subtraction result sentence
	LEA	R0, SUB_RESULT

	PUTS
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


; variable
ASCII:		.FILL	#48
; string
NEWLINE:	.STRINGZ	"\nThe number you entered is: "


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

; strings
GREETING:	.STRINGZ	"\nHello, there!\n"

PROMPT1:	.STRINGZ	"\nPlease enter a 1-digit number: \n"

PROMPT2:	.STRINGZ	"\nPlease enter another 1-digit number: \n" 


; variables
USERINPUT1:	.FILL	x4100

USERINPUT2:	.FILL	x4101



; DIVISION
; get ascii_offset -48
	LD	R5, ASCII_OFFSET
; get first entered number 
	LD	R1, USERINPUT1
; get real value of first number
	ADD	R1, R1, R5
; get second entered number
	LD	R2, USERINPUT2
; get real value of second number
	ADD	R2, R2, R5

; empty R6 division result
	AND	R6, R6, 0

; empty R4 (COUNTER) remainder
	AND	R4, R4, 0
; R3 stores the negative value of second number
	NOT	R3, R2
	ADD	R3, R3, #1

; First number subtract second number 
; until counter reaches 0 or negative
; start loop

LOOPD:
	ADD	R4, R4, #1
	ADD	R1,R1,R3
	BRn	NEGATIVE
	BRz	ZERO
	BRp	LOOPD

 
NEGATIVE:
	ADD	R4,R4,#-1
	ADD	R6,R1,R2
ZERO:	

	LD	R5,ASCII

; store division result and remainder in 
; the locations
	STI	R6, DIVISION
	STI	R4, R

; print out the result sentence
	LEA	R0,DIV_RESULT
	PUTS
; get the value of result
	ADD	R0,R4,R5
	PUTC

; print out the remainder sentence
	LEA	R0,REM
	PUTS
; get the value of remainder and print it out
	ADD	R0,R6,R5
	PUTC

; variables
DIVISION:	.FILL	x3102


R:		.FILL	x3103

	HALT

;variables
MULTIPLICATION	.FILL	x3101
SUBTRACTION:	.FILL	x3100
; strings
MULT_RESULT:	.STRINGZ	"\nThe MULTIPLICATION result of these two numbers is: \n"

SUB_RESULT:	.STRINGZ	"\nThe SUBTRACTION result of these two numbers is: \n"

; variables
FIRST:		.FILL	x2001
SECOND:		.FILL	x2000
ASCII_OFFSET:	.FILL	#-48
; strings
DIV_RESULT:	.STRINGZ	"\nThe DIVISION result of these two numbers is: \n"

REM:		.STRINGZ	"\nThe REMAINDER is: \n"


; end of code

	.END
