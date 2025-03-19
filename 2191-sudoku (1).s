  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

@ Sudocode bruteforce approach:
@   for (row = 0; row < 9 && row_result < 2; row++)
@ {
@   for (i = 1; i <= 9 && row_result < 2; i++)
@   {
@     count = 0;
@     for (col = 0; col < 9; col++)
@     {
@       number = grid[row][col];
@       if (number == i)
@       {
@         count++;
@       }
@     }
@     if (count == 0)
@     {
@       row_result = 1;    // incomplete row
@     }
@     else if (count > 1)
@     {
@       row_result = 2;    // invalid row
@     }
@   }
@ }

@ Sudocode bitmap approach:
@ for (row = 0; row < 9; row++)
@ {
@   bitmap = 0;
@   for (col = 0; col < 9; col++)
@   {
@     number = grid[row][col];
@     mask = 1 << (number - 1)  // i.e. 1 shifted left by (number - 1) bit positions    
 
@     // have we already seen this number in this row?
@     if (bitmap & mask != 0)
@    {
@       row_result = 2;         // invalid grid because we already saw this number in this row
@     }
 
@     // update bitmap
@     bitmap = bitmap | mask; 
@   }
 
@   if (row_result < 2 && bitmap != 511)
@   {
@     row_result = 1;
@   }
@ }

Main:


  MOV R0, #0  // R0 -> Row result 
  MOV R1, #0  // R1 -> Col result
  MOV R2, #0  // R2 -> Grid result

  // R3 -> Sudoku grid is stored in memory beginning at the address in R3
  
  MOV R4, #9 // Grid size (number of rows and cols)

  MOV R5, #1 // Init row counter to 0
  MOV R6, #0 // Init col counter to 0
  MOV R8, 0 // Initialise temp byte sized value to 0

  MOV R7, #0 // Initialize bitmap to empty
  MOV R11, #0 // Empty cell flag
  MOV R12, #0x1FF    // Load 0x1FF into R12 for comparing values


  forCols:

  CMP R6, R4 // Check to see if we have reached the end of current row
  BEQ forRows 

  LDRB R8, [R3], #1

  CMP R8, #0        // Check for zero value (empty cell) and skip to avoid logical errors with bitmap
  BNE nonZero

  MOV R11, #1

nonZero:

  SUB R9, R8, #1
  MOV R10, #1 
  LSL R10, R10, R9

  TST R7, R10
  BNE repeatRow
  
  ORR R7, R7, R10

  ADD R6, R6, #1 // Incriment the column counter for this row
  B forCols


  forRows:
  
  CMP R5, R4
  BEQ endRows
  
  @ CMP R7, R12
  @ BNE incompleteRow
  
  LDR R7, =0x00000000 // Clear bitmap
  MOV R6, #0 // Init col counter to 0
  
  ADD R5, R5, #1

  B forCols


repeatRow:
  MOV R0, #2
  CMP R11, #1
  BNE End_Main
  
  MOV R1, #1
  MOV R2, #1

  B End_Main

endRows:
  CMP R11, #1
  BNE End_Main
  
  MOV R0, #1
  MOV R1, #1
  MOV R2, #1

End_Main:
  BX    LR

  .end