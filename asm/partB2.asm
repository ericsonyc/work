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
      BR CALCULATE     

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
      

EXIT 
      HALT
MESSAGE .STRINGZ "Please input a number between 3 and 23:"
MEMORYSPACE .BLKW 10
COUNT .FILL #0
DIGIT .FILL #-2
NEWLINE .FILL #-10
TWODIGIT .FILL #-51
ONEDIGIT .FILL #-50
.END