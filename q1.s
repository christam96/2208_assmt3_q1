		AREA proj1, CODE, READONLY 
		ENTRY
	
		LDR r0, =UPC							;Load r0 with 12-digit UPC string
		MOV r1, #0
		MOV r2, #1

LOOP
		
		LDRB r3, [r0, r1]					;Loads byte from memory location r0 at pointer r1 into r3
		LDRB r4, [r0, r2]					;Loads byte from memory location r0 at pointer r2 into r4
		
		SUB		r3, r3, #48
		SUB 	r4, r4, #48
		
		ADD		r5, r5, r3					; Adds up even integers	(first sum)		
		ADD		r6, r6, r4					; Adds up odd integers (second sum)
		
		ADD		r1, r1, #2					; Increments pointer r1 by two
		ADD		r2, r2, #2					; Increments pointer r2 by two
		
		CMP		r1, #12						; Checks if r1 equals to 12
		
		BNE	LOOP
		
		SUB		r6, r6, r4					; Subtracts last UPC digit from r4
		
		ADD 	r5, r5, LSL #1				; Multiplies first sum by two, then adds it into r5 (thus multiplying first sum by three)
		
		ADD 	r7, r5, r6					; Adds first sum and second sum, stores in r7
		
		SUB 	r7, r7, #1					; Subtract 1 from r7
		
		MOV		r0, #0						; Move literal 0 into r0
		
		B		MOD10

MOD10

		CMP 	r7, #9						; Compare r7 to literal 9
		SUBGT	r7, r7, #10					; If r7 is greater than 9, subtract 10 from r7	
		MOVLT	r0, #1						; If r7 is less than 9, move literal 1 into r0
		CMP		r0, #1						; Compare r0 to literal 1
		BNE		MOD10
		
		RSB		r1, r7, #9 					; Subtract 9 from r7
		CMP		r1, #0						; Check digit stored in r1
		BEQ 	VALID						; If r1 is 0, branch to VALID label
		BNE		INVALID						; If r1 is not equal to 0, branch to INVALID label
		
VALID	
		MOV 	r0, #1						; Move literal 1 into r0 if valid
		B		JUMP
		
INVALID
		MOV 	r0, #2						; Move literal 2 into r0 if invalid
		
JUMP

loop	b	loop
		
	
	
		AREA proj1, DATA, READWRITE
UPC		DCB "060383755577"   ;UPC string
		
		
		END
