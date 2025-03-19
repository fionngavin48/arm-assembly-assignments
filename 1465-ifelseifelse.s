  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Langauge.
  @ Assume v is a value in R1 and a is a value in R0.

  @ if (v < 10) {
  @ 	a = 1;
  @ }
  @ else if (v < 100) {
  @ 	a = 10;
  @ }
  @ else if (v < 1000) {
  @ 	a = 100;
  @ }
  @ else {
  @ 	a = 0;
  @ }  

  CMP R1, #10
  BLT VLESS10

  CMP R1, #100
  BLT VLESS100

  CMP R1, #1000
  BLT VLESS1000

  MOV R0, #0

  B End_Main

VLESS10:
  MOV R0, #1

  B End_Main

VLESS100:
  LDR R0, =10

  B End_Main

VLESS1000:
  LDR R0, =100

  B End_Main


End_Main:
  BX    LR

  .end