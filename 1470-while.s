  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Language.
  @ Assume h is a value in R0.

  @ while (h >= 13) {
  @ 	h = h - 12;
  @ }

  LDR R1, =12

 WhileLabel:
  CMP R0, #13
  BLT End_Main
  SUB R0, R0, R1
  B WhileLabel


End_Main:
  BX    LR

  .end