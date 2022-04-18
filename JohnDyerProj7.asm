; JohnDyerProj7.asm - Bitwise Calculator

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD


.data 

;All strings used in the program
intro BYTE "Bitwise Multiplication of Unsigned Integers",0
enterTheMultiplicand BYTE "Enter the multiplicand: ",0
enterTheMultiplier BYTE "Enter the multiplier: ",0
theProductIs BYTE "The product is ",0
another BYTE "Do you want to do another calculation? y/n (all lower case): ",0
prompt BYTE "Press any key to continue...",0


.code
main PROC								

	MAINLOOP:

		;Intro title
			call Crlf									;Skips to new line
			mov edx,OFFSET intro						;Moves offset address of intro to edx register
			call WriteString							;Writes string from edx into console
			call Crlf
			call Crlf

		;Bitwise multiplier input
			mov edx,OFFSET enterTheMultiplicand						
			call WriteString
			call ReadDec								;Reads a user-entered number into eax
			mov ebx, eax								;Loads the value of eax into ebx so ReadDec can be called again
			mov edx, OFFSET enterTheMultiplier									
			call WriteString
			call ReadDec								;Stores value in eax
			call Crlf
			mov edx, OFFSET theProductIs		
			call WriteString
			call BitwiseMultiply
			call WriteDec								;Writes the decimal value located in eax (bitwise product)
			call Crlf

		;Asks user to continue program or not
			mov edx, OFFSET another						
			call WriteString	
			call ReadChar								;Reads the input from the user and stores in al register
			call Crlf											
			cmp al, 'y'									;Compares character typed by user to 'y'
			jne noContinue								;Jumps past the MAINLOOP repeat if user typed something not equal to 'y'
			jmp MAINLOOP								;Repeats MAINLOOP
			noContinue:
				
	
	;Exit procedure that waits for user to exit program
	call Crlf
	mov edx,OFFSET prompt						
	call WriteString							
	call ReadChar										;Pauses the program to wait for input from user
	exit												;Ends program after char is read

main ENDP


;Bit-shifting multiplier
BitwiseMultiply PROC USES ecx edx esi		
		
	;Preliminary
        mov edx, 0d										;edx used to store product and set to initial value of 0
        mov ecx, 32d									;Loops 32 times for all 32 bits 
	;Least significant bit test
	L1:     
		test ebx, 1										;Multiplicand AND 1 to set zero flag if least significant bit is 0
        jz L2											;Skips to L2 if zero flag is set
        add edx, eax									;Adds multiplier to edx if zero flag is set
	;Shifting section
	L2:
        shr ebx, 1										;Shifts multiplier right
        shl eax, 1										;Shifts Multplicand left
        loop L1				
	;Exit section
	L3:     
		mov eax, edx									;Final product is stored in eax
		ret												;Returns to the main program

BitwiseMultiply ENDP
		

END main