`define REG_ADDR_LEN 5
`define MEM_WIDTH 32
`define INSTR_BIT_LEN 32
// Define Symbolic Names for Signals  and Register Fields


module processor(Clk); 

    input Clk;


// Instantiate modules making up the processor




initial begin
// Initialize all microarchitectural registers
   
   end
     




endmodule

module pipeReg1(clk, pcIn, pcOut, instrIn, instrOut);
    input clk;
    input [`INSTR_BIT_LEN - 1:0] pcIn, instrIn;
    output reg [`INSTR_BIT_LEN - 1:0] pcOut, instrOut;

    always @(posedge clk)
    begin
        pcOut <= pcIn;
        instrOut <= instrIn;
    end
endmodule

module pipeReg2();
endmodule

module pipeReg3();
endmodule

module pipeReg4(clk,
                wbEnableIn, wbEnableOut,
                memReadIn, memReadOut,
                memWriteIn, memWriteOut,
                iTypeIn, iTypeOut,
                isBranchIn, isBranchOut,
                isJumpIn, isJumpOut,
                dataIn, dataOut,
                dstIn, dstOut);

    input clk;
    input wbEnableIn, memReadIn, memWriteIn, iTypeIn, isBranchIn, isJumpIn;
    output reg wbEnableOut, memReadOut, memWriteOut, iTypeOut, isBranchOut, isJumpOut;
    input [`MEM_WIDTH - 1:0] dataIn;
    output reg [`MEM_WIDTH - 1:0] dataOut;
    input [`REG_ADDR_LEN - 1:0] dstIn;
    output reg [`REG_ADDR_LEN - 1:0] dstOut;

    always @(posedge clk)
    begin
        wbEnableOut <= wbEnableIn;
        memReadOut <= memReadIn;
        memWriteOut <= memWriteIn;
        iTypeOut <= iTypeIn;
        isBranchOut <= isBranchIn;
        isJumpOut <= isJumpIn;
    end

endmodule
