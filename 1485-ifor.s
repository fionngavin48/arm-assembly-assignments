  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Language.
  @ Assume ch is an ASCII character code in R1 and v is a value in R0.

  @ if (ch=='a' || ch=='e' || ch=='i' || ch=='o' || ch=='u')
  @ {
  @ 	v = 1;
  @ }
  @ else
  @ {
  @ 	v = 0;
  @ }

  LDR R2, ='a'
  LDR R3, ='e'
  LDR R4, ='i'
  LDR R5, ='o'
  LDR R6, ='u'

  CMP R1, R2 
  BEQ MATCH
  CMP R1, R3
  BEQ MATCH
  CMP R1, R4
  BEQ MATCH
  CMP R1, R5
  BEQ MATCH
  CMP R1, R6 
  BEQ MATCH

  MOV R0, #0

  B End_Main

MATCH:

  MOV R0, #1

  B End_Main

  @ End of program ... check your result

End_Main:
  BX    LR

  .end