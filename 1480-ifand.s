  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Langauge.
  @ Assume ch is an ASCII character in R0.

  @ if (ch >= 'A' && ch <= 'Z') {
  @ 	ch = ch + 0x20;
  @ }

  LDR R1, ='A'
  LDR R2, ='Z'
  LDR R3, =0x20

  CMP R0, R1 
  BGE GREATEREQUALA

  B End_Main

GREATEREQUALA:
  CMP R0, R2
  BLE LESSEQUALZ

  B End_Main

LESSEQUALZ:
  ADD R0, R0, R3

  B End_Main

  @ End of program ... check your result

End_Main:
  BX    LR

  .end