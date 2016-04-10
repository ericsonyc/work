.ORIG x3000

LD R1, LEFT
LD R2,RIGHT
DIVISION:

AND     R3, R3, 0   ; Zero out R3 /This is the remainder
AND R4, R4, 0   ; Zero out R4 /This is the quotient

NOT     R3, R2      ; Takes the inverse of 2nd input ->R3
ADD     R3, R3 #1   ; Add one to the inverse (for 2s comp)

LOOPD
ADD     R4, R4, #1  ; Add 1 to R4 repeatedly
ADD     R1, R1, R3  ; Subtract input2 from R1
BRN     NEGATIVE
BRZ     ZERO
BRP     LOOPD

NEGATIVE
ADD     R4, R4, #-1
ADD     R3, R1, R2

; Done with divison algorithm.
ZERO
LD  R0, DECCONV     ; Load Decimal converter
ADD     R3, R3, R0  ; Convert back to ASCII
ADD     R4, R4, R0  ; Convert back to ASCII

ST  R3, REMRESULT   ; Store the remainder result
ST  R4, DIVRESULT   ; Store the division result.

LD  R0, DIVRESULT   ; Load Division result into R0
PUTC            ; Print it.
LEA     R0, DIVSTRING   ; Load the string for division.
PUTS            ; Print the string.

LD  R0, REMRESULT   ; Load Remainder result into R0
PUTC            ; Print it.
LEA     R0, REMSTRING   ; Load the string for remainder
PUTS            ; Print the string.

DECCONV .FILL x30
REMRESULT .FILL #0
DIVRESULT .FILL #0
DIVSTRING .STRINGZ "---------\n"
REMSTRING   .STRINGZ "*********\n"
LEFT .FILL #10
RIGHT .FILL #2
.END
