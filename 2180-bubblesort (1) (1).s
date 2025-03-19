  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

@
@ Implement the well-known bubblesort algorithm to sort a sequence
@ of word-size values in ascending order. The values should be sorted
@ 'in-place', overwriting the original sequence. A pseudocode description
@ of 'bubblesort' is provided below for convenience.
@
@ The sequence of values ('array' below) begins in memory at the address in R0.
@ The number of values in the sequence (variable 'n' below) is in R1.
@
@ do {
@   swapped = false;
@   for (i = 1; i < n; i++) {
@     if (array[i−1] > array[i]) {
@       tmpswap = array[i−1];
@       array[i−1] = array[i];
@       array[i] = tmpswap;
@       swapped = true ;
@     }
@   }
@   n = n - 1;
@ } while ( swapped );
@



do: 
  MOV R4, #0 @ flag == false; 
 
  MOV R5, #1 @ i = 1;
for:
  CMP R5, R1
  BHS endFor

  SUB R6, R5, #1  @array[i−1]
  @ accessing array 
  LDR R7,[R0, R6, LSL #2]   @ R6 is the offset 
  LDR R8, [R0, R5, LSL #2 ] @ R5 is the offset 
  CMP R7, R8                @ if (array[i−1] > array[i]) {.  this is the if bit.
  BLE endIf

  STR R8, [R0, R6, LSL #2]    @ tmpswap = array[i−1];
  STR R7, [R0, R5, LSL #2]    @ array[i] = tmpswap;
  MOV R4, #1


endIf:
  ADD R5, R5, #1 @ i++;
  b for
endFor:
  SUB R1, R1, #1  @n = n - 1;
  CMP R4, #1
  BEQ do
  



@   *****ANSWER*****
@ do:
@   MOV R4, #0 @ flag = false;

@   MOV R5, #1

@ for:
@   CMP R5, R1
@   BHS  endFor     @ oppsoite of  i < n;

@   SUB R6, R5, #1 @ i - 1
@   LDR R7, [R0, R6, LSL #2] @ starts in RO
@   LDR R8, [R0, R5, LSL #2] 
@   CMP R7, R8 @ if statement 
@   BLE endIf @ opposite condtition.

@   STR R8, [R0, R6, LSL #2]
@   STR R7, [R0, R5,LSL #2]
@   MOV R4, #1



@ endIf:
@   ADD R5, R5, #1 @ i++
@   b for



@ endFor:
@   @ n in R1
@   SUB R1, R1, #1
@   CMP R4, #1
@   BEq do

@ end:
End_Main:
  BX    LR

  .end