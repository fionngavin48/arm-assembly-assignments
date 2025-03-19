  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

  @
  @ Write a program to count the number of words (language words, not
  @   4-byte words!!) in a null-terminated string in memory. The
  @   string starts at the address in R1. Store the result in R0.
  @
  @ For the purpose of this exercise, assume a word is a sequence of
  @   one or more alphanumeric characters (A-Z, a-z, 0-9) or hyphens
  @   ('-').
  @

Main:
  MOV R0, #0     @ Initialise word counter in R0
  MOV R2, #0     @ Initialise temp storage for current charater in R2
  MOV R3, #0     @ Initialise bit counter in R3
  MOV R4, #0     @ Initialise whitespace flag to 0 in R4

  LDR R5,=0x00    @ Initialise R5 with null terminator (HEX 0x00)


While:
  LDRB R2, [R1], #1  @ Load next character from input string
  ADD R3, R3, #1
  
  CMP R2, #0         @ Check for NULL terminator
  BEQ Null_Terminator

  CMP R3, #1
  BEQ First_Bit

  CMP R4, #1
  BEQ Char_After_WS

  CMP R2, #0x20        @ Is it a white space space? (ASCII whitespace is 32 in decimal)
  BEQ White_Space    @ Branch if the current character is R2 is a whitespace
  CMP R2, #0x09
  BEQ White_Space
  CMP R2, #0x0A
  BEQ White_Space
  CMP R2, #0x0D
  BEQ White_Space

  B While   @ Restart loop

First_Bit:
  CMP R2, #0x20   @   } else if (tempChar == ' ' || tempChar == '\n' || tempChar == '\r' || tempChar == '\t') {             
  BEQ While       @      whiteSpace = true;
  B New_Word

Char_After_WS:
  MOV R4, #0  @ Clear whitespace flag
  CMP R2, #0x20
  BEQ White_Space
  CMP R2, #0x09
  BEQ White_Space
  CMP R2, #0x0A
  BEQ White_Space
  CMP R2, #0x0D
  BEQ White_Space
  B New_Word

White_Space:
  MOV R4, #1
  B While                @ Restart loop

New_Word:
  ADD R0, R0, #1    @       wordCount++
  B While

Null_Terminator:
  STRB R5, [R1], #1  @ Ensure null terminator is written at the end of the string


End_Main:
  BX    LR

  .end

// Specified non space separators
@ CMP R2, #0x09
@ BEQ White_Space
@ CMP R2, #0x0A
@ BEQ White_Space
@ CMP R2, #0x0D
@ BEQ White_Space