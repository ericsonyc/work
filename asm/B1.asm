.ORIG x3000 
INPUT LEA R0,MESSAGE
      PUTS
      AND R0,R0,#0
      AND R1,R1,#0
      AND R6,R6,#0
      AND R2,R2,#0
      AND R3,R3,#0
      LEA R6,MEMORYSPACE ; saves the address of the storage memory block
      ADD R1,R6,#0
LOOP
    GETC               ; input character -> r0
    ST R0,COUNT
    OUT               ; r0 -> console    

    LD R7,COUNT
    LD R2,NEWLINE
    ;NOT R2,R2
    ADD R7,R7,R2
    BRz OUTPUT
    STR R0,R1,#0       ; r0 -> ( memory address stored in r1 + 0 )
    ADD R1,R1,#1       ; increments the memory pointer so that it
                       ; always points at the next available block
    ;ADD R3,R3,#-1
    BR LOOP

OUTPUT 
    LD R2,MIN
    LDR R7,R6,#0
    ADD R7,R7,R2
    BRn EXIT
    LD R2,MAX
    LDR R7,R6,#0
    ADD R7,R7,R2
    BRp EXIT

    ;BR CALCULATE    
    ;AND R0,R0,#0
    ;ADD R0,R6,#0
;CALCULATE
    AND R5,R5,#0
    ;ADD R5,R5,R6
    LDR R5,R6,#0
    AND R1,R1,#0
    LD R2,MASK_COUNT
    NOT R2,R2
    ADD R2,R2,#1
WHILE_LOOP
    ADD R3,R1,R2
    BRz LOOP_END
    LEA R3,BINARY
    ADD R3,R3,R1
    LDR R4,R3,#0
    AND R4,R4,R5
    BRz NO_BIT
    LD R0,ASCII_ONE
    OUT
    ADD R1,R1,#1
    BRnzp WHILE_LOOP
NO_BIT
    LD R0,ASCII_ZERO
    OUT
    ADD R1,R1,#1
    BRnzp WHILE_LOOP
LOOP_END
    LD R0,ENTER
    OUT
    BR INPUT    

EXIT
    HALT

BINARY .FILL b0000000000001000
       .FILL b0000000000000100
       .FILL b0000000000000010
       .FILL b0000000000000001
       .FILL b0000000000000000

MESSAGE	.STRINGZ "Please input an integer(0-9):"
MEMORYSPACE .blkw 10 ; declares empty space to store the string
MIN .FILL #-48
MAX .FILL #-57
COUNT .FILL 1
NEWLINE .FILL #-10
ENTER       .FILL   x000A
NUMBER .FILL #0
ASCII_ZERO  .FILL   x0030
ASCII_ONE   .FILL   x0031
MASK_COUNT  .FILL   x04     ; loop limit = 4
    .END