.ORIG x3000 
LD R3, N_VAL

Loop BRz Done ; check if last operation flagged z-bit
  LD R0, I_VAL ; load i
  LD R1, J_VAL ; load j

  ADD R2, R0, R1 ; t = i + j

  ST R1, I_VAL ; j = i (R1)
  ST R2, J_VAL ; j = t (R2)

  ADD R3, R3, -1 ; count down n
  BR Loop
	
Done ST R2, RESULT ; superfluous, fib(n) result already in J_VAL
 
HALT
	RESULT	.FILL x0000 
	I_VAL	.FILL x0001
	J_VAL	.FILL x0000
	N_VAL	.FILL 20 ; n -> fib(n)
	.END 