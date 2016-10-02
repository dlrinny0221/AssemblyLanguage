	.ORIG	x3000
; branch to the start routine
BR	START
; clear all registers we may use
	AND	R0, R0, 0
	AND	R1, R0, 0
	AND	R2, R0, 0
	AND	R3, R0, 0
	AND	R4, R0, 0
	AND	R5, R0, 0
	AND	R6, R0, 0
	AND	R7, R0, 0

ED:	.FILL	x3200
EK:	.FILL	x3201
ASCII:		.FILL	#-48
NEWLINE:	.STRINGZ	"\n"


START:
; prints out the prompts and gets user's inputs
; load the address of PROMPTED into R0
	LEA	R0, PROMPTED
; prints out the prompt
	PUTS
; get E/D input into R0
	GETC
	PUTC
; store the input in the memory
	STI	R0, ED
; copy R0 and store it to R3
	ADD	R3, R0, 0
; prints out a new line
	LEA	R0, NEWLINE
	PUTS

; load address of PROMPTCK
	LEA	R0, PROMPTCK
; prints out the prompt
	PUTS
; get user's input
	GETC
	PUTC
; store the input in the memory
	STI	R0, EK
; LOAD ASCII #-48 into R1
	LD	R1, ASCII
; get real value of R1
	ADD	R2, R0, R1
; print out a new line
	LEA	R0, NEWLINE
	PUTS

; load address of PROMPTIM into R0
	LEA	R0, PROMPTIM
; print out PROMPTIM
	PUTS
; load starting point address of array
	LEA	R4, MSGARRAY
; clear R1
	AND	R1, R1, 0
; reads in the msg that the user wants to encrypt or decrypt. we need a loop because only one char can be read at a time.
; the ENTER key is the terminator to the loop.
; a counter keeps track of the number of chars that are read

; strings
PROMPTED:	.STRINGZ	"Please enter E if you want to encrypt your message.\nPlease enter D if you want to decrypt your message.\n"
PROMPTCK:	.STRINGZ	"Please enter an integer key you want to use from 0 to 31, and press ENTER when you are done.\n"
MSGARRAY:	.BLKW	20
PROMPTIM:	.STRINGZ	"Please enter your message with no more than 20 characters, and press ENTER when you are done.\n"


INCHAR:
; get a single char to R0
	GETC
	PUTC
; store the character in the memory one by one
	STI	R0, IM
; subtract by 10 because ENTER key is 10
	ADD	R5,R0, #-10
	;ADD	R0, R0, x1
; if gets zero, branch to check the char
	BRz	CHECK
; else, continue the loop
	STR	R0, R4, 0
; increment the length of the array by #1
	ADD	R4, R4, #1
; increment counter
	ADD	R1, R1, #1
; unconditional branch to INCHAR
	BR	INCHAR

; check if the user wants to encrypt or decrypt the msg
; if the user entered E then encrypt; D, then decrypt
; other options are illegal

CHECK:
; load negative 69 into R6
	LD	R6, ASCIIE
; add #-69 to R3
	ADD	R0, R3, R6
; if R0 gets zero, branch goes to encrypt
	BRz	ENCRYPT
; check if it is D if it is not E
; load	#-68 into R6
	LD	R6, ASCIID
; add #-68 to R3
	ADD	R0,R3, R6
; if zero, branch goes to decrypt
	BRz	DECRYPT
; if it is not E or D, ILLEGAL
	LEA	R0, ERRORED
	PUTS

;variables

ASCIIE:	.FILL	#-69
ASCIID:	.FILL	#-68
TWENTY:	.FILL	#20


; encryption has two routines: one is to set up mempry array and counter and another one is to loop over
; every char to encrypt it.

ENCRYPT:
; load address of array into R4
	LEA	R4, MSGARRAY
; copy number of chars in msg to R5. THE COUNTER
	LD	R5, TWENTY
; skip char if it is whitespace
ELOOP:	
; load array index into R0
	LDR	R0, R4, 0
; jumpt to flip bit routine and jump back when done
	JSR	FLIP
; add the key to the char and store encrypted char in R0
	ADD	R0, R6, R2
; store the encrypted char in the array
	STR	R0, R4, 0
; increment array index
	ADD	R4, R4, #1
; decrement counter
	ADD	R5, R5, #-1
; if positive, loop continues
	BRp	ELOOP
; else OUTPUT result
	BR	OUTPUT	

ERRORED:	.STRINGZ	"THAT IS AN ILLEGAL CHARACTER. PLEASE TRY AGAIN."

; DECRYPTION has two routines too. One is to set up memory array and counter.
; another one is to loop over every char to decrypt it

DECRYPT:
; load starting address of the array into R4
	LEA	R4, MSGARRAY
; copy number of chars in msg to R5, COUNTER
	ADD	R5,R1,0
; load TWENTY in R5, COUNTER
	LD	R5, TWENTY
; skip over if it is white space

DLOOP:
; load array index into R0
	LDR	R0, R4, 0
; invert key
	NOT	R2,R2
; add #1 to get negative value
	ADD	R2, R2, #1
; subtract key from char and store it in R0
	ADD	R0, R0,R2
; jump to flip bit routine and jump back when done
	JSR	FLIP
; store the decrypted char to the array
	STR	R6, R4, 0
; increment array index
	ADD	R4, R4, #1
; DECREMENT COUNTER
	ADD	R5, R5, #-1
; if possitive, continue loop
	BRp	DLOOP
; else branch to output
	BR	OUTPUT

FLIP:
	NOT	R3, R0
	AND	R3, R3, #1
	AND	R0, R0, #-2
	ADD	R6, R0, R3
	RET

; prints the encrypted or decrypted msg
OUTPUT:
; LOAD starting address of array
	LEA	R4, MSGARRAY

; ouput loop
OLOOP:
; load contents of address at array index into R0
	LDR	R0, R4, 0
; print character
	PUTC
; increment array index
	ADD	 R4, R4, #1
; decrement counter by #1
	ADD	R1, R1, #-1
; IF POSITIVE, loop continues
	BRp	OLOOP

; halt the program 
	HALT

; variables
IM:	.FILL	x3202

; end 
	.END