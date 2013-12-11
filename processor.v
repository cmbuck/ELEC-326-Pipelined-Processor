`define REG_ADDR_LEN 5
`define MEM_WIDTH 32
`define INSTR_BIT_LEN 32

// Define Symbolic Names for Signals  and Register Fields

/* ALUop goes into the ALU and controls what op it carries out
 RWrite is essentially WriteEnable and goes into the Reg File
 ALUSel selects the input to the ALU, chooses b/w AddrInfo and (rt), goes into 
      MUX just before ALU
 RDataSel chooses input to data to be written to Reg File, picks b/w DataMem an
      ALU result in PipeReg3 and goes into MUX just before Data in PipeReg4 
 WSel chooses between rt and rd to be the register in Reg File written to, goes
      into MUX before dst in PipeReg3 
 MemRead tells us whether we want to read from memory or not, goes into datamem
 MemWrite tells us whether we want to write to memory or not, goes into datamem
 JMP indicates whether we want to Jump or not, goes into MUX before PC 
 BR indicates whether we want top branch or not, goes into and gate before mux 
      before PC  
 */



module processor(Clk); 

    input Clk;
// Instantiate modules making up the processor

   wire [11:0] PipeReg1Bus; //connects output of decoder to PipeReg1
   wire [2:0] aluOp; //connected to intput of ALU
   wire       ALUsel; //connected to mux before ALU
   wire       WSel;
   wire       MemRead; //goes into DataMem
   wire       MemWrite; //goes into DataMem
   wire [15:0] AddrInfo_mux_input; //input to MUX before ALU 
   wire [4:0]  DstReg; //input to DST, output of MUX after rt and rd
   wire [31:0] TargetAddr; //output of ALU, input of DDR
   wire [31:0] Result; //output of ALU
   wire [31:0] rt_mux_input;
   wire [31:0] rs_mux_input;
   
   
   dataMemory DataMemory(MemRead, MemWrite, Address, StoreValue, LoadValue);

   alu ALU(aluOp, operand1, operand2, jmp, br, pc, addrInfo, aluResult, TargetAddr);
   



initial begin
// Initialize all microarchitectural registers
   
   end
     




endmodule

module pipeReg1(clk, pc, instruction);
    // The following are contained in this module:
    // [31:0] pc
    // [31:0] instruction
    
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
        
    
        
    
    end
endmodule // pipeReg3

module pipeReg4();
    // memCntrl (just write)
    // [31:0] data
    // [4:0] dst

 /*   

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
	*/

endmodule


