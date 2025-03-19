  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  arraymove

@
@ arraymove subroutine
@ Move an element of an array from one index to
@   another index.
@ Parameters:
@   R0: arrayAddr – array start address
@   R1: move element from this index
@   R2: move element to this index
@ Return:
@   none
@

@
@ Write array of word-size values.
@ a program that will move an array element from an old index to
@ a new index in an 
@ The figure illustrates an array in which an element is moved from
@ old index 6 to new index 3. Note how the elements between the old
@ and new indices have been moved to fill the “gap” that was left in
@ the array.
@
@   BEFORE    7, 2, 5, 9, 1, 3, 2, 3, 4
@                               ^
@                            
@   AFTER     7, 2, 5, 2, 9, 1, 3, 3, 4
@                      ^
@         
@ The start address of the array will be in R0, the old index of the
@ element to move will be in R1 and the destination index to which the
@ element should be moved will be in R2.
@

arraymove:

  PUSH {R4-R6, LR}    @ remember to also PUSH any other registers (R4, R5, ...) used in your subroutine
                
  LDR R4, [R0, R1, LSL #2 ] // Load the element to be moved
  MOV R5, R2

  CMP R5, R1
  BGT .LleftToRight
  BEQ .LendLoop

  .LrightToLeft:

    LDR R6, [R0, R5, LSL #2]  @ Load the value that is to be shifted so it is not overwritten
    STR R4, [R0, R5, LSL #2]  @ Store the last aquired value

    CMP R5, R1
    BEQ .LendLoop

    ADD R5, R5, #1

    MOV R4, R6
    B .LrightToLeft

  .LleftToRight:

    LDR R6, [R0, R5, LSL #2]
    STR R4, [R0, R5, LSL #2]

    CMP R5,R1 
    BEQ .LendLoop

    SUB R5, R5, #1

    MOV R4, R6 

    B .LleftToRight

    .LendLoop:

  POP {R4-R6, PC}   
                  
  .end