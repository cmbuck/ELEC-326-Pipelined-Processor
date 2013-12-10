module alu(aluOp, operand1, operand2, jump, branch, pc, addrInfo, aluResult, targetAddr);

   input wire  [31:0] operand1, operand2;
   input wire [31:0]  pc;
   input wire [25:0]  addrInfo;
   input wire 	      jump, branch;
   input wire [2:0]   aluOp;
   output reg [31:0]  aluResult, targetAddr;
  

   // Use your alu module from Homework 3
   
endmodule




