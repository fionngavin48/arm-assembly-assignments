  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

MOV R0, #0
MOV R2, #0
While:
CMP R2, #10
BHS EndWhile

LDR R3, [R1] 
ADD R0, R0, R3 
ADD R1, R1, #4 
ADD R2, R2, #1 

B While 
EndWhile:

  @ End of program ... check your result

End_Main:
  BX    LR

  .end