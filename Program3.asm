TITLE Program Template     (template.asm)

; Author: Sara Hovey 


;Date: 5/7/17

; Description: This program asks the user for
; numbers between -100 and -1, until they enter a non-neg
; With those numbers, the average, sum,
; and total number entered are displayed

; This program uses global variables
INCLUDE Irvine32.inc

;Boundaries for range-checking
LOWER = -100
UPPER = -1

.data

;User-given values
username	BYTE	30 DUP(0)
input		SDWORD	?

;Calculated values
accum		SDWORD	0		
sum			SDWORD	?
avg			SDWORD	?

;Text Output
intro_1		BYTE	"Name: Sara Hovey, CS271 Program 3", 0
intro_2		BYTE	"Hello, " , 0
ask_1		BYTE	"What's your name, friend? " , 0
ask_2		BYTE	"Please enter a number between -100 and -1 " , 0
too_low		BYTE	"Too low, try something above -101 ",0

testM2		BYTE	"Made it to non-neg", 0
testM1		BYTE	"Current accum value: ", 0
testM3		BYTE	"Current sum is: ",0
show_avg	BYTE	"The average is: ", 0
show_count	BYTE	"Here is how many numbers you've entered: ", 0
show_sum	BYTE	"The sum is: ", 0
special		BYTE	"You entered no negative numbers!", 0
bye			BYTE	"Goodbye, ", 0
quit		BYTE	"Press any key to quit", 0
; (insert variable definitions here)

.code
main PROC

;Display title and programmer name
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLf

;Get the user's name
	mov		edx, OFFSET ask_1
	call	WriteString
	mov		edx, OFFSET username
	mov		ecx, 32
	call	ReadString
;Greet the user
	mov		edx, OFFSET intro_2
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

;Prompt the user for a number between -100 and -1
prompt:
	mov		edx, OFFSET ask_2
	call	WriteString
	call	CrLf

;get data
	call	ReadInt
	mov		input, eax

;If it is non-negative, jump
	cmp		eax, UPPER ;Compare input to -1
	jg		showAccum	;If the input is >-1, jump

;If it is lower than -100, jump
	cmp		eax, LOWER
	jl		tooLow

	;Adds 1 to the accumulator variable
	mov		eax, accum
	add		eax, 1
	mov		accum, eax

	;; TESTING prints accum
	;mov		edx, OFFSET testM1
	;call	WriteString
	;mov		edx, accum
	;call	WriteInt
	;call	CrLf

	;Calculate sum
	mov		eax, sum
	mov		ebx, input
	add		eax, ebx
	mov		sum, eax

	;; TESTING prints sum
	;mov		edx, OFFSET testM3
	;call	WriteString	
	;mov		edx, sum
	;call	WriteInt
	;call	CrLf
	

	jmp		prompt ;jumps back up

;If the user does not enter any negative numbers
specialMessage:
	mov		edx, OFFSET special
	call	WriteString
	call	CrLf
	jmp		goodbye

;For input <-100
tooLow:
	mov		edx, OFFSET too_low
	call	WriteString
	call	CrLf
	jmp		prompt

;Stuff that happens when the loop exits
;Prints sum and accum
;and calculates avg
showAccum:
	;Show the number of ints entered
	cmp		accum, 0
	jle		specialMessage

	mov		edx, OFFSET show_count
	call	WriteString
	mov		eax, accum
	call	Writeint
	call	CrLf

ShowSum:
	;Show the sum
	mov		edx, OFFSET show_sum
	call	WriteString
	mov		eax, sum
	call	WriteInt
	call	CrLF

	;Calculate the average
	mov		eax, sum	;dividend
	cdq					;sign-extend eax into edx:eax
	mov		ebx, accum	;divisor
	idiv	ebx
	mov		avg, eax


	;Show the average
	mov		edx, OFFSET show_avg
	call	WriteString
	mov		edx, avg
	call	WriteInt
	call	CrLf


; Say Goodbye to the user
goodbye:
	mov		edx, OFFSET bye
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf
	mov		edx, OFFSET quit
	call	WriteString
	call ReadInt

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
