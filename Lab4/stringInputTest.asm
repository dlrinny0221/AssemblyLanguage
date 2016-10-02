;; Register usage:
; R0 = the input character
; R1 = the newline character
; R2 = base address of the array
; R3 = temporary working storage
.ORIG	x3000
; Main program code	
	LEA	R0, PROMPT	; Display the prompt
	PUTS
	LD 	R1, RT	          ; Initialize the return character
	LEA 	R2, ARRAY		; Get the base address of the array

WHILE	GETC			; Read and echo a character (stored in R0)
	OUT	
	ADD 	R3, R0, R1	; Quit if character = return
	BRz 	ENDWHILE
	STR 	R0, R2, #0	; Store that character in the array
	ADD 	R2, R2, #1	; Increment the address of the array cell
	BR 	WHILE	          ; Return to read another character
ENDWHILE	STR 	R3, R2, #0	; Store the null character after the last input

          LEA 	R0, ARRAY       	; Output the string
          PUTS
	HALT

; Main program data
RT	.FILL 	x-000D		; The return character (negated)
PROMPT	.STRINGZ 	"Enter your name: "
ARRAY	.BLKW 30		          ; Array of 30 characters (including null)

	.END
