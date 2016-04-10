.ORIG x3000
INPUT LEA R0,MESSAGE
      PUTS
      AND R0,R0,#0
      AND R1,R1,#0
      AND R6,R6,#0  ;preserve the address of memoryspace
      AND R3,R3,#0  ;preserve the number of digits
      LEA R6,MEMORYSPACE
      ADD R1,R6,#0
LOOP 
      GETC
      ST R0,COUNT
      OUT

      LD R7,COUNT
      LD R2,NEWLINE
      ADD R7,R7,R2
      BRz OUTPUT
      STR R0,R1,#0
      ADD R1,R1,#1
      ADD R3,R3,#1
      ST R3,NUMBER
      ;AND R4,R4,#0
      ;ADD R4,R4,R1 ;preserve the single digit
      BR LOOP

OUTPUT
      ;AND R0,R0,#0
      ;ADD R0,R0,R6
      ;PUTS
      LD R7,DIGIT
      ADD R7,R7,R3
      BRp INPUT
      ADD R3,R3,#-1
      BRz SINGLE
      BR TWO

SINGLE
      ;STR R4,R1,#1;AND R4,R4,#0;STR R4,R1,#0;ADD R1,R1,#1
      LDR R7,R6,#0
      LD R2,TWODIGIT
      ADD R7,R7,R2
      BRn INPUT
      BR SINCAL    

TWO ;judge the input
      AND R1,R1,#0
      ADD R1,R1,R6
      LDR R7,R6,#0
      LD R2,ONEDIGIT
      ADD R7,R7,R2
      BRz EQUAL
      BRp INPUT
EQUAL 
      ADD R1,R1,#1
      LDR R7,R1,#0
      LD R2,TWODIGIT
      ADD R7,R7,R2
      BRp INPUT
      

CALCULATE
      LD R0,CHAR      
      LDR R7,R6,#0
      ADD R7,R7,R0
      ;LD R3,NUMBER
      ;ADD R3,R3,#-1
      ;BRz FIBONACCI
      AND R3,R3,#0
      LD R2,BASE
TIMES
      ADD R3,R3,R2
      ADD R7,R7,#-1
      BRp TIMES
      LDR R7,R6,#1
      ADD R7,R7,R0
      ADD R3,R3,R7
      BR FIBO
SINCAL
      LDR R7,R6,#0
      LD R0,CHAR
      ADD R7,R7,R0
      AND R3,R3,#0
      ADD R3,R3,R7
        
FIBO
      AND R0,R0,#0
      ADD R0,R3,#0
      JSR Fibonacci

Fibonacci:
      ADD R6,R6,#-2
      STR R7,R6,#0
      ADD R6,R6,#-1
      STR R5,R6,#0
      ADD R5,R6,#-1
      ADD R6,R6,#-2
      
      LDR R0,R5,#4
      BRz FIB_BASE
      ADD R0,R0,#-1
      BRz FIB_BASE
      LDR R0,R5,#4
      ADD R0,R0,#-1
      ADD R6,R6,#-1
      STR R0,R6,#0
      JSR Fibonacci 

      LDR R0,R6,#0
      ADD R6,R6,#1
      STR R0,R5,#-1
      LDR R0,R5,#4
      ADD R0,R0,#-2
      ADD R6, R6, #-1 ; push n-2
      STR R0, R6, #0
      JSR Fibonacci ; call self 
      
      LDR R0, R6, #0 ; pop return value
      ADD R6, R6, #1
      LDR R1, R5, #-1 ; read temp
      ADD R0, R0, R1 ; Fib(n-1) + Fib(n-2)
      BRnzp FIB_END ; all done
FIB_BASE 
      AND R0, R0, #0 ; base case ¨C return 1
      ADD R0, R0, #1
FIB_END 
      STR R0, R5, #3 ; write return value (R0)
      ADD R6, R5, #1 ; pop local variables
      LDR R5, R6, #0 ; pop dynamic link
      ADD R6, R6, #1
      LDR R7, R6, #0 ; pop return address
      ADD R6, R6, #1
      AND R0,R0,#0
      ADD R0,R0,R7
      PUTS
      RET 

EXIT 
      HALT
MESSAGE .STRINGZ "Please input a number between 3 and 23 :"
MEMORYSPACE .BLKW 10
COUNT .FILL #0
DIGIT .FILL #-2
NEWLINE .FILL #-10
TWODIGIT .FILL #-51
ONEDIGIT .FILL #-50
BASE .FILL #10
CHAR .FILL #-48
LEFT .FILL #1
RIGHT .FILL #1
NUMBER .FILL #1

.END