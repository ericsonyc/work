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
      BR FIBONACCI
SINCAL
      LDR R7,R6,#0
      LD R0,CHAR
      ADD R7,R7,R0
      AND R3,R3,#0
      ADD R3,R3,R7


        
FIBONACCI
      LD R0,LEFT
      LD R1,RIGHT
      ADD R2,R0,R1
      ST R1,LEFT
      ST R2,RIGHT
      LEA R4,DIVNUMBER
      AND R1,R1,#0
      AND R2,R2,#0
      ADD R1,R1,#5
      ADD R2,R2,#1
      BR OUTCONSOLE     
CC    
      LD R0,SPACE
      OUT
      ADD R3,R3,#-1
      BRp FIBONACCI
      BR EXIT

OUTCONSOLE
      LDR R7,R4,#0
      BR DIVISION
TEMP
      ADD R6,R6,#0
      BRz ZEROC
      LD R0,DIVRESULT
      LD R7,DECCONV
      ADD R0,R0,R7
      OUT
ZEROC  ;ADD R2,R2,#1
      ADD R4,R4,R2
      LD R0,REMRESULT
      ADD R1,R1,#-1
      BRz CC
      BR OUTCONSOLE         

DIVISION
      AND R5, R5, 0   ; Zero out R5 /This is the remainder
      AND R6, R6, 0   ; Zero out R6 /This is the quotient
      NOT R5, R7      ; Takes the inverse of 2nd input ->R3
      ADD R5, R5 #1   ; Add one to the inverse (for 2s comp)

LOOPD
      ADD R6, R6, #1  ; Add 1 to R6 repeatedly
      ADD R0, R0, R5  ; Subtract input2 from R1
      BRN NEGATIVE
      BRZ ZERO
      BRP LOOPD

NEGATIVE
      ADD R6, R6, #-1
      ADD R5, R0, R7
      ;LD R1,DECCONV
      ;ADD R5,R5,R1
      ;ADD R6,R6,R1
      ;BR EEE

      ; Done with divison algorithm.
ZERO
      ;LD  R1, DECCONV     ; Load Decimal converter
      ;ADD R5, R5, R1  ; Convert back to ASCII
      ;ADD R6, R6, R1  ; Convert back to ASCII

;EEE
      ST  R5, REMRESULT   ; Store the remainder result
      ST  R6, DIVRESULT   ; Store the division result.

      ;LD  R0, DIVRESULT   ; Load Division result into R0
      ;PUTC            ; Print it.

      ;LD  R0, REMRESULT   ; Load Remainder result into R0
      ;PUTC            ; Print it.
      BR TEMP


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

SPACE .FILL x20
DECCONV .FILL x30
REMRESULT .FILL #0
DIVRESULT .FILL #0
DIVNUMBER .FILL #10000
          .FILL #1000
          .FILL #100
          .FILL #10
          .FILL #1
.END