	.ORIG	x3000
START:

; clear all the registers that we may use
	AND	R0, R0, 0
	AND	R1, R0, 0
	AND	R2, R0, 0
	AND	R3, R0, 0
	AND	R4, R0, 0
	AND	R5, R0, 0
	AND	R6, R0, 0
	AND	R7, R0, 0

; print out a prompt E/D
	LEA	R0, PROMPTED
	PUTS
; get the user's E/D input
	GETC
	PUTC
; store the input
	STI	R0, INPUTED
; print out a new line
	LEA	R0, NEWLINE
	PUTS
; print out another prompt Encryption Key
	LEA	R0, PROMPTEK
	PUTS
; initialize the return character
	LD	R1, RETURN 
	LEA	R2, NUMARRAY
ENCRYPTKEY:
; get the user's number from 0 to 31
	GETC
; store the input character in an array
	ST	R0, NUMARRAY
; print out the character
	PUTC
	ADD	R2, R0, 0
	LD	R3, 
	BRz	STOP
	BRnzp	ENCRYPTKEY
	STOP

	LD	R0,NUMARRAY
	PUTC
; quit if character = return
	ADD	R3, R0, R1
	BRz	ENDENCRYPTKEY
; store the character in the entered number in the array
	STI	R0, R2, 0
; increment the address of the array cell
	;ADD	R2, R2, #1
; return to read another character in the number
	BR	ENCRYPTKEY
ENDENCRYPTKEY:
; store the null character after the last input
	;STR	R3, R2, 0
; output the string
	LEA	R0, NUMARRAY
	PUTS
; store the number 
	STI	R0, INPUTEK
; print out a prompt Input Message
	LEA	R0, PROMPTIM
	PUTS



	
	HALT

; strings
PROMPTED:	.STRINGZ	"Please enter E/D: "
PROMPTEK:	.STRINGZ	"Please enter an integer number from 0 to 31: "	
PROMPTIM:	.STRINGZ	"Please enter your message here: "
NEWLINE:	.STRINGZ	"\n"

; variables
INPUTED:	.FILL	x3200
INPUTEK:	.FILL	x3201
RETURN:		.FILL	x-000D	; the enter key character in hex. (negated)
NUMBERS		.FILL	#-10
MAXCHAR:	.BLKW 20	; an array of maximum 20 characters including null
NUMARRAY:	.BLKW 2		; an array of maximum 2 characters in the number including null
; end the code
	.END