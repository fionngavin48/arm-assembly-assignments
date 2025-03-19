  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global   getTileNumber
  .global   getTileWidth
  .global   getTileHeight
  .global   getTileArea
  .global   setTile


@ getTileNumber Subroutine

@ Return the number of the tile at the given grid reference
@
@ Parameters:
@   R0: address of the grid (2D array) in memory
@   R1: address of grid reference in memory (a NULL-terminated
@       string, e.g. "B8")
@
@ Return:
@   R0: tile number

getTileNumber:

  PUSH {R3-R6, LR}

  MOV R6, R0  // Load the address of the grid into R6
  
  LDRB R2, [R1]   // Load the first byte (the letter)
  ADD R1, R1, #1  // Move to the next byte (the number)
  
  SUB R2, R2, #'A' // Subtract ASCII value of 'A' to get row index
  
  LDRB R3, [R1]  // Load the column number (as a character)
  SUB R3, R3, #'0' // Convert ASCII character to integer 
  SUB R3, R3, #1
 
  MOV R4, #9  // Set the number of columns in the grid (8 for example)

  MUL R3, R3, R4  // row (0 indexed, so for row 7 R3 will be 6) * number of columns in grid
  ADD R0, R3, R2  // (row * number of columns) + column number 

  MOV R5, #4  // Temp storage for value #4
  MUL R0, R5  // R0 * 4 (account for word size (4 bytes))

  LDR R0, [R6, R0]  // Load the value from the grid using the tile number (R0 as the offset)
  
  POP {R3-R6, PC}






@ getTileWidth Subroutine

@ Return the width of the tile at the given grid reference
@
@ Parameters:
@   R0: address of the grid (2D array) in memory
@   R1: address of grid reference in memory (a NULL-terminated
@       string, e.g. "D7")
@
@ Return:
@   R0: width of tile (in units)

getTileWidth:

  PUSH {R3-R10, LR}

  MOV R9, #0  // Initialise backwards width counter 
  MOV R10, #0  // Initialise forwards width counter 

  MOV R6, R0  // Load the address of the grid into R6
  
  LDRB R2, [R1]   // Load the first byte (the letter)
  ADD R1, R1, #1  // Move to the next byte (the number)
  
  SUB R2, R2, #'A' // Subtract ASCII value of 'A' to get row index
  
  LDRB R3, [R1]  // Load the column number (as a character)
  SUB R3, R3, #'0' // Convert ASCII character to integer 
  SUB R3, R3, #1
 
  MOV R4, #9  // Set the number of columns in the grid (8 for example)

  MUL R3, R3, R4  // row (0 indexed, so for row 7 R3 will be 6) * number of columns in grid
  ADD R0, R3, R2  // (row * number of columns) + column number 

  MOV R5, #4  // Temp storage for value #4
  MUL R0, R5  // R0 * 4 (account for word size (4 bytes))

  LDR R8, [R6, R0]  // Load the value from the grid using the tile number (R0 as the offset)
  
  
  .LbackLoop: // Loop to find end of tile backwards

  SUB R0, #4 
  LDR R7, [R6, R0]  // Load the value from the grid using the tile number (R0 as the offset)
  
  CMP R7, R8
  BNE .LtileEnd

  MOV R7, R8

  ADD R9, R9, #1 // Increment width counter by 1

  B .LbackLoop


  .LresetOffset:
  MOV R4, #0
  ADD R9, R9, #1
  MUL R5, R9, R5
  ADD R0, R0, R5
  .LforwardLoop:  // Loop to find end of tile forwards

  ADD R0, #4 
  LDR R7, [R6, R0]  // Load the value from the grid using the tile number (R0 as the offset)
  
  CMP R7, R8  // Check to see if tile number is the same
  BNE .LtileEnd // If not, branch to 'tileEnd'

  MOV R7, R8 // Copy tile number to temp storage in R8

  ADD R10, R10, #1 // Increment width counter by 1

  B .LforwardLoop


  .LtileEnd:
 // Check to see if forwardLoop has been completed and start it if not

  CMP R4, #0
  BNE .LresetOffset   

  ADD R0, R9, R10  // Calculate tile width from width counters both ways

  POP {R3-R10, PC}






@ getTileHeight Subroutine

@ Return the height of the tile at the given grid reference
@
@ Parameters:
@   R0: address of the grid (2D array) in memory
@   R1: address of grid reference in memory (a NULL-terminated
@       string, e.g. "D7")
@
@ Return:
@   R0: height of tile (in units)

getTileHeight:

  PUSH {R3-R10, LR}

  MOV R9, #0  // Initialise backwards width counter 
  MOV R10, #0  // Initialise forwards width counter 

  MOV R6, R0  // Load the address of the grid into R6
  
  LDRB R2, [R1]   // Load the first byte (the letter)
  ADD R1, R1, #1  // Move to the next byte (the number)
  
  SUB R2, R2, #'A' // Subtract ASCII value of 'A' to get row index
  
  LDRB R3, [R1]  // Load the column number (as a character)
  SUB R3, R3, #'0' // Convert ASCII character to integer 
  SUB R3, R3, #1
 
  MOV R4, #9  // Set the number of columns in the grid (8 for example)

  MUL R3, R3, R4  // row (0 indexed, so for row 7 R3 will be 6) * number of columns in grid
  ADD R0, R3, R2  // (row * number of columns) + column number 

  MOV R5, #4  // Temp storage for value #4
  MUL R0, R5  // R0 * 4 (account for word size (4 bytes))

  LDR R8, [R6, R0]  // Load the value from the grid using the tile number (R0 as the offset)
  
  
  .LupLoop: // Loop to find end of tile backwards

  SUB R0, #36 
  LDR R7, [R6, R0]  // Load the value from the grid using the tile number (R0 as the offset)
  
  CMP R7, R8
  BNE .LvertTileEnd

  MOV R7, R8

  ADD R9, R9, #1 // Increment width counter by 1

  B .LupLoop


  .LvertResetOffset:
  MOV R4, #0
  ADD R9, R9, #1
  MOV R3, #9
  MUL R5, R5, R3
  MUL R5, R9, R5
  ADD R0, R0, R5
  .LdownLoop:  // Loop to find end of tile forwards

  ADD R0, #36 
  LDR R7, [R6, R0]  // Load the value from the grid using the tile number (R0 as the offset)
  
  CMP R7, R8  // Check to see if tile number is the same
  BNE .LvertTileEnd // If not, branch to 'tileEnd'

  MOV R7, R8 // Copy tile number to temp storage in R8

  ADD R10, R10, #1 // Increment width counter by 1

  B .LdownLoop


  .LvertTileEnd:
  CMP R4, #0   // Check to see if forwardLoop has been completed and start it if not
  BNE .LvertResetOffset  

  ADD R0, R9, R10  // Calculate tile width from width counters both ways

  POP {R3-R10, PC}






@ getTileArea Subroutine

@ Return the area of the tile at the given grid reference
@
@ Parameters:
@   R0: address of the grid (2D array) in memory
@   R1: address of grid reference in memory (a NULL-terminated
@       string, e.g. "D7")
@
@ Return:
@   R0: area of tile (in square units)



getTileArea:

  PUSH  {R4-R6, LR}   
  
  MOV   R4, R0        // Copy the grid address
  MOV   R5, R1        // Copy the grid reference address

  BL    getTileWidth  // Call getTileWidth
  MOV   R6, R0        // Store in R6

  MOV   R0, R4        // Restore grid address
  MOV   R1, R5        // Restore grid reference

  BL    getTileHeight // Call getTileHeight
  MUL   R0, R6, R0    // Multiply width * height

  POP   {R4-R6, PC}   



@ setTile Subroutine

@ Update a grid in memory to place a new tile of a given size with
@   its top-left corner located at a given grid reference. The number
@   assigned to the new tile should be the lowest positive integer
@   that does not already appear in the grid. The grid should only be
@   updated if the new tile fits at the specified location.
@
@ Parameters:
@   R0: address of the grid (2D array) in memory
@   R1: address of grid reference in memory (a NULL-terminated
@       string, e.g. "D7")
@   R2: width of new tile (in units)
@   R3: height of new tile (in units)
@
@ Return:
@   none




setTile:
  PUSH  {LR}

  @
  @ setTile subroutine implementation
  @

  POP   {PC}

  .end
