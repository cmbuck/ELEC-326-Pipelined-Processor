module insDecoder(instruction, addrInfo, ALUop, writeReg, memRead, memWrite, iType, wbEnable, isBranch, isJump);

   
   input [31:0] instruction;
   output [25:0] addrInfo;
   output [2:0]  ALUop;
   output [4:0]  writeReg;
   output wbEnable, memRead, memWrite, iType, isBranch, isJump;

   // Use your insDecoder module from Homework 3

endmodule



