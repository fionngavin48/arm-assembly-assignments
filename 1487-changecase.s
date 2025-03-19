  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Change the case of the character in R0


  LDR R1, ='a'
  LDR R2, ='z'
  LDR R3, ='A'
  LDR R4, ='Z'

  LDR R5, =0X20
  
  CMP R0, R1 
  BGE GREATEREQUALa

  CMP R0, R3
  BGE GREATEREQUALA

  B End_Main

GREATEREQUALa:
  CMP R0, R2
  BLE LESSEQUALz

  B End_Main

GREATEREQUALA:
  CMP R0, R4
  BLE LESSEQUALZ

  B End_Main

LESSEQUALz:
  SUB R0, R0, R5
  B End_Main

LESSEQUALZ:
  ADD R0, R0, R5
  B End_Main

  @ End of program ... check your result

End_Main:
  BX    LR

  .end