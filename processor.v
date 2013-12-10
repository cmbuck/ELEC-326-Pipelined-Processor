// Define Symbolic Names for Signals  and Register Fields


module processor(Clk); 

    input Clk;


// Instantiate modules making up the processor




initial begin
// Initialize all microarchitectural registers
   
   end
     




endmodule

module pipeReg1(clk, pc, instruction);
    input clk;
    input [31:0] pc;

endmodule

module pipeReg2();
/*	Fields in this register:
 *	PC, Control, (rs), (rt), rs, rt, rd, addr info
 *  
 */
endmodule

module pipeReg3(wbEnable, memRead, memWrite, iType, isBranch, isJump, alures, rt);
    input wbEnable, memRead, memWrite, iType, isBranch, isJump;
    input [31:0] aluRes;
    input [4:0] inRT;

    output dataMem;
    output [4:0] outRT;
    
    always @(posedge) begin
        
    
        
    
    
endmodule

module pipeReg4();
endmodule
