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

<<<<<<< HEAD
module pipeReg1(clk, pc, instruction);
    // The following are contained in this module:
    // [31:0] pc
    // [31:0] instruction
    
=======
module pipeReg1(clk, pcIn, pcOut, instrIn, instrOut);
>>>>>>> a138b461d95190a7a4f28ae2c30971111f9345b7
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
<<<<<<< HEAD
    // The following are contained in this module:
    // [31:0] pc
    // [10:0] IDCntrl - aluSet, wSel, aluOp(this guy is 3 bits long), memWrite, rDataSel, rWrite, jmp, br
=======
/*	Fields in this register:
 *	PC, Control, (rs), (rt), rs, rt, rd, addr info
 *  
 */
>>>>>>> a138b461d95190a7a4f28ae2c30971111f9345b7
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

<<<<<<< HEAD
module pipeReg4();
    // memCntrl (just write)
    // [31:0] data
    // [4:0] dst
    
=======
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

>>>>>>> a138b461d95190a7a4f28ae2c30971111f9345b7
endmodule
