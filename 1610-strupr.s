  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

While:
  LDRB R2, [R1]
  CMP R2, #0
  BEQ EndWhile
  CMP R2, #'a'
  BLO EndIfLwr
  CMP R2, #'z'
  BHI EndIfLwr
  SUB R2, R2, #0x20
  STRB R2, [R1]
EndIfLwr:
  ADD R1, R1, #1
  B While
EndWhile:

End_Main:
  BX    LR

  .end