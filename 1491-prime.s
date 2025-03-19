  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Write a program to determine whether the numberin R1 is
  @   a prime number.
  @ Put 1 in R0 if the number is prime and 0 if it is not
  @   prime.

  @ LDR R1, =10

  CMP R1, #2
  BLT Not_Prime

  CMP R1, #2
  BEQ Prime  

  MOV R2, #2
  MOV R4, #1

  UDIV R5, R1, R2
  ADD R5, R5, R2

  WhileLabel:

    CMP R2, R5
    BEQ Prime

    UDIV R3, R1, R2
    MUL R3, R3, R2
    SUB R3, R1, R3

    CMP R3, #0
    BEQ Not_Prime

    ADD R2, R2, R4

    B WhileLabel @ Branch back to start of loop

Prime:
MOV R0, #1
B End_Main

Not_Prime:
MOV R0, #0
B End_Main

  @ End of program ... check your result

End_Main:
  BX    LR

  .end