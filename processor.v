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

module pipeReg3();
endmodule

module pipeReg4();
endmodule
