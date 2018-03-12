		AREA question2, CODE, READONLY
		ENTRY
		
		ADR r0, STRING -1				; address of string into r0
		ADR r1, EoS							; address to end of string into r1
		
nextr2	LDRB r2, [r0, #1]!					; Load first index of string into r2 and increment
nextr3	LDRB r3, [r1, #-1]!					; Load last index of string into r3 and decrement

hi	
		; Check if characters in register are letters.
		; If not, skip.
		CMP r2, #65							; Check if r3 contains a letter
		LDRBLT r2, [r0, #1]
		ADDLT r0, #1
		
		CMP r3, #65							; Check if r3 contains a letter
		BLT	nextr3
		
		; Check if all letters have been read.
		CMP r0, r1
		BGT	check
		
		; Convert all letters to lowercase
		CMP r2, #97							; Compare r2 to 97 (decimal) or 61 (hexa)
		ADDLT r2, #32						; If less, r2 contains an uppercase letter. Add 32 (decimal) or 20 (hexa)

		CMP r3, #97							; Compare r3 to 97 (decimal) or 61 (hexa)
		ADDLT r3, #32						; If less, r3 contains an uppercase letter. Add 32 (decimal) or 20 (hexa)

		CMP r2, #64
		BEQ hi
		
		MOV r4, r2
		MOV r5, r3

		; Compare values in r2 and r3
		; If equal, loop back to increment r2 and decrement r3
		; If not equal, not a palindrome
		CMP r4, r5							; Compare values in r2 and r3
		BEQ nextr2
		BNE check 

check	CMP r4, r5
		MOVEQ r0, #1
		MOVNE r0, #2

loop	B loop
		
		AREA question2, DATA, READWRITE
STRING	DCB "Was it a car or a cat I saw?"		; String
EoS		DCB 0x00							; End of string
		END