  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Calculate the length of the string stored in memory beginning at the
  @ address contained in R1. Store the result in R0. Count the number of
  @ characters up to but NOT including the NULL terminating character.

  MOV  R0, #0         @ Initialize R0 to 0

While:
  LDRB R2, [R1], #1  
  CMP R2, #0        
  BEQ End_Main        
  ADD R0, R0, #1     
  B While  
      
End_Main:
  BX LR
  .end
