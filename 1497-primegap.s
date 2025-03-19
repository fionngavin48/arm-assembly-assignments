  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

@ LDR R1, =3

MOV R8, #0
MOV R9, R8 @ Initialize registers to store previous primes

MOV R2, #2 @ Initialize number index
MOV R6, #0 @ Initialize prime count

MOV R3, #1
MOV R11, #2

ADD R7, R1, R3
ADD R7, R7, R3 @ Add 2 to R7 to compare n-1 to n+1

CMP R1, #0
BEQ Zero_Case

WhileLabel:

    CMP R2, #2
    BLT Not_Prime

    CMP R2, #2
    BEQ Prime 

    CMP R6, R7
    BEQ Prime_Gap

    MOV R4, #2 @ Reset divisor for testing primes

    UDIV R10, R2, R11
    ADD R10, R10, #1

    Prime_Check:

        CMP R4, R10
        BEQ Prime

        UDIV R5, R2, R4
        MUL R5, R5, R4
        SUB R5, R2, R5 @ Find remainder and store in R5

        CMP R5, #0
        BEQ Not_Prime

        ADD R4, R4, #1

        B Prime_Check

  Prime:
    MOV R9, R8     @ Move the current prime in R8 to R9 (store previous prime)
    MOV R8, R2     @ Update R8 with the new prime (current prime is now in R8)
    ADD R6, R6, #1
  
  Not_Prime:

  ADD R2, R2, #1

  B WhileLabel

Prime_Gap:

  SUB R0, R8, R9

  B End_Main

Zero_Case:

    MOV R0, #1

  @ End of program ... check your result

End_Main:
  BX    LR

  .end