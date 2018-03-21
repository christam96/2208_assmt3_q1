		AREA proj1, CODE, READWRITE
		ENTRY
		
		ADR r0, STRING1 -1						; Address of String1 into r0
		ADR r1, EoS								; Address of end of String1 into r1
		ADR r12, STRING2
		
next	;LDRB r2, [r0, #1]!						; Load first index of String1 into r2 and increment
		
		; Check for substring " the "
		;MOV r3, #32								; Move space ASCII character into r3
		;CMP r3, #32
		
		
		MOV r4, r0								; Take note of where we leave if we branch to alert1. r4 will store the returning point
		MOV r5, r0								; Notes where we will exit FALSE loop
		MOV r6, r0								; Notes beginning of String1 for reference
		ADD r6, #1
		
		LDRB r2, [r0, #1]!
		
		CMP r2, #0
		BEQ loop
		
		CMP r0, r6
		CMPEQ r2, #116							; If r2 is the first index of String1, does r2 contain "t"? If so, branch to alert2
		BEQ alert2
		CMP r2, #32								; If r2 is not the first index of String1, does it contain " "? If so, branch to alert
		BEQ alert1
		STRB r2, [r1, #1]!						; Process of moving String1 into String2. Store valid byte of r2 into the incremented index after null space character of String1. This will be String2
		CMP r2, #00								; Check if r2 has reached null character, meaning it has iterated over every element of String1
		BNE next

alert1	LDRB r2, [r0, #1]!						; Load next index of String1 into r2 to check if it is followed by "t"
		MOV r5, r0								; Notes where we will exit FALSE loop
		CMP r2, #116							; Check if " " is followed by "t". If so, branch to alert2
		BEQ alert2
		BNE false1

alert2	LDRB r2, [r0, #1]!						; Load next index of String1 into r2 to check if it is followed by "h"
		MOV r5, r0								; Notes where we will exit FALSE loop
		CMP r2, #104							; Check if "t" is followed by "h". If so, branch to alert3
		BEQ alert3
		BNE false1				
		
alert3	LDRB r2, [r0, #1]!						; Load next index of String1 into r2 to check if it is followed by "e"
		MOV r5, r0								; Notes where we will exit FALSE loop
		CMP r2, #101							; Check if "h" is followed by "e". If so, branch to alert4
		BEQ alert4
		BNE false1

alert4	LDRB r2, [r0, #1]!
		MOV r5, r0
		CMP r2, #32
		BEQ next
		CMP r2, #0
		BEQ loop
		BNE false1

false1	MOV r0, r4
false2	LDRB r2, [r0, #1]!
		STRB r2, [r1, #1]!
		CMP r0, r5
		BNE false2
		BEQ next



		;MOV r3, #32							; Move space ASCII character into r3
		;CMP r3, #32
		;LDRBEQ r2, [r0, #1]!
		;CMP  
		
		;BNE next		
		
		
	
		
loop	b	loop
		
		AREA proj1, DATA, READWRITE
;STRING1	DCB "and the man said they must go"		; String1
STRING1	DCB "the the theyre boys the"								; String1
EoS		DCB	0x00								; End of String1
STRING2	space 0xFF								; Allocates 255 bytes for String2
		END
