| Find sum of elements in an integer array.
| R1 should be initialized with the number of  elements in the array.
| The sum is accumulated in R0.
| The base address of the array is assumed to be zero.
| R2 holds the address of the element to be accessed next.
| The code assumes that all registers except R1 have been initialized to zero.
	
LOOP:
LD   	R3, 0(R2)	|  	80430000     
ADDI  	R1, R1, -1      |	2021FFFF
NOP			|	00000000
ADD 	R0, R0, R3	|	00030020
BEQ	R1, R4, DONE    |	10240004 
ADDI   	R2, R2, 4	|	20420004	
NOP			|	00000000
NOP			|	00000000
BEQ 	R6, R6, LOOP	|	10C6FFF7
DONE:	
NOP			|	00000000
NOP			|	00000000
NOP			|	00000000

