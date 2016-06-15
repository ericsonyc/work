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
      
      LD    R6,INIT_PTR   ; load initial stack pointer
      LD    R5,INIT_PTR   ; load initial frame pointer
      ADD R5,R5,#1
      BR    MAIN

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
ORIGIN .FILL #0
INIT_PTR .FILL x5000
DATA .FILL #0
CHARACTER .FILL x30
ADDRESS .FILL #0

SPACE .FILL x20
DECCONV .FILL x30
REMRESULT .FILL #0
DIVRESULT .FILL #0
DIVNUMBER .FILL #10000
          .FILL #1000
          .FILL #100
          .FILL #10
          .FILL #1

MAIN
;; setup caller portion of activation record
;; push function parameters
            ADD R3,R3,#-1
         
            STR   R3,R6,#0      ; Push step 2: copy param val=5 to stack
            JSR   Fibonacci     ; call factorial

            LDR   R0,R6,#0      ; load result of call into a register
            ST R0,ORIGIN
            AND R1,R1,#0
            LEA R1,DIVNUMBER
            AND R2,R2,#0
            ADD R2,R2,#1
            AND R3,R3,#0
            ADD R3,R3,#5
RESULT
            LD R0,ORIGIN
            LDR R7,R1,#0
            BR DIVISION
TEMP
            ADD R6,R6,#0
            BRp TT
            ADD R3,R3,#-1
            ADD R1,R1,R2
            BR RESULT
TT
            LD R0,ORIGIN
            LDR R7,R1,#0 	    
            BR DIVISION2
JUDGE
            LD R0,DIVRESULT
            LD R4,CHARACTER
            ADD R0,R0,R4
            OUT
            LD R0,REMRESULT
            ST R0,ORIGIN
            ADD R1,R1,#1
            ADD R3,R3,#-1
            BRp TT
            HALT


Fibonacci
	ADD R6, R6, #-2 ; skip ret val, push ret addr
 	STR R7, R6, #0
	ADD R6, R6, #-1 ; push dynamic link
	STR R5, R6, #0
 	ADD R5, R6, #-1 ; set frame pointer
 	ADD R6, R6, #-2 ; space for locals and temps
 	LDR R0, R5, #4 ; load n
 	BRz FIB_BASE ; check for terminal cases
 	ADD R0, R0, #-1
 	BRz FIB_BASE 
	LDR R0, R5, #4 ; read parameter n
 	ADD R0, R0, #-1 ; calculate n-1
 	ADD R6, R6, #-1 ; push n-1
 	STR R0, R6, #0
 	JSR Fibonacci ; call self
        
 	LDR R0, R6, #0 ; pop return value
 	ADD R6, R6, #1
 	STR R0, R5, #-1 ; store in temp
 	LDR R0, R5, #4 ; read parameter n
 	ADD R0, R0, #-2 ; calculate n-2
 	ADD R6, R6, #-1 ; push n-2
 	STR R0, R6, #0
 	JSR Fibonacci ; call self 
	LDR R0, R6, #0 ; pop return value
 	ADD R6, R6, #1
 	LDR R1, R5, #-1 ; read temp
 	ADD R0, R0, R1 ; Fib(n-1) + Fib(n-2)
 	BRnzp FIB_END ; all done
	FIB_BASE AND R0, R0, #0 ; base case ¨C return 1
 	ADD R0, R0, #1
	FIB_END STR R0, R5, #3 ; write return value (R0)
 	ADD R6, R5, #1 ; pop local variables
 	LDR R5, R6, #0 ; pop dynamic link
 	ADD R6, R6, #1
 	LDR R7, R6, #0 ; pop return address
 	ADD R6, R6, #1
 RET

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

DIVISION2
      AND R5, R5, 0   ; Zero out R5 /This is the remainder
      AND R6, R6, 0   ; Zero out R6 /This is the quotient
      NOT R5, R7      ; Takes the inverse of 2nd input ->R3
      ADD R5, R5 #1   ; Add one to the inverse (for 2s comp)

LOOPD2
      ADD R6, R6, #1  ; Add 1 to R6 repeatedly
      ADD R0, R0, R5  ; Subtract input2 from R1
      BRN NEGATIVE2
      BRZ ZERO2
      BRP LOOPD2

NEGATIVE2
      ADD R6, R6, #-1
      ADD R5, R0, R7
      ;LD R1,DECCONV
      ;ADD R5,R5,R1
      ;ADD R6,R6,R1
      ;BR EEE2

      ; Done with divison algorithm.
ZERO2
      ;LD  R1, DECCONV     ; Load Decimal converter
      ;ADD R5, R5, R1  ; Convert back to ASCII
      ;ADD R6, R6, R1  ; Convert back to ASCII

;EEE2
      ST  R5, REMRESULT   ; Store the remainder result
      ST  R6, DIVRESULT   ; Store the division result.

      BR JUDGE

.END