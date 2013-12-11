// Define Symbolic Names for Signals  and Register Fields


module processor(Clk); 

    input Clk;


// Instantiate modules making up the processor




initial begin
// Initialize all microarchitectural registers
   
   end
     




endmodule

module pipeReg1(clk, pc, instruction);
    // The following are contained in this module:
    // [31:0] pc
    // [31:0] instruction
    
    input clk;
    input [31:0] pc;

endmodule

module pipeReg2();
    // The following are contained in this module:
    // [31:0] pc
    // [10:0] IDCntrl - aluSet, wSel, aluOp(this guy is 3 bits long), memWrite, rDataSel, rWrite, jmp, br
endmodule

module pipeReg3(wbEnable, memRead, memWrite, iType, isBranch, isJump, alures, rt);
    // The following are contained in this module
    // [3:0] ExCntrl - br, memWrite, rDataSel, rWrite
    // [31:0] result
    // [4:0] dst
    // [31:0] ddr
    input wbEnable, memRead, memWrite, iType, isBranch, isJump;
    input [31:0] aluRes;
    input [4:0] inRT;

    output dataMem;
    output [4:0] outRT;
    
    always @(posedge) begin
        
    
        
    
    
endmodule

module pipeReg4();
    // memCntrl (just write)
    // [31:0] data
    // [4:0] dst
    
endmodule
