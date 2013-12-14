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

   wire [11:0]  PipeReg1Bus; //connects output of decoder to PipeReg1
   wire [2:0]   aluOp; //connected to intput of ALU
   wire         ALUsel; //connected to mux before ALU
   wire         WSel;
   wire         MemRead; //goes into DataMem
   wire         MemWrite; //goes into DataMem
   wire [15:0]  AddrInfo_mux_input; //input to MUX before ALU 
   wire [4:0]   DstReg; //input to DST, output of MUX after rt and rd
   wire [31:0]  TargetAddr; //output of ALU, input of DDR
   wire [31:0]  Result; //output of ALU
   wire [31:0]  rt_mux_input;
   wire [31:0]  rs_mux_input;


   dataMemory DataMemory(MemRead, MemWrite, Address, StoreValue, LoadValue);

   alu ALU(aluOp, operand1, operand2, jmp, br, pc, addrInfo, aluResult, TargetAddr);




    initial begin
    // Initialize all microarchitectural registers

    end





endmodule

module IFPipeReg(clk, pcIn, pcOut, instrIn, instrOut);
    input clk;
    input [31:0] pcIn, instrIn;
    output reg [31:0] pcOut, instrOut;

    always @(posedge clk) begin
        pcOut <= pcIn;
        instrOut <= instrIn;
    end
endmodule

module IDPipeReg(clk, pcIn, pcOut, aluSetIn, aluSetOut, wSelIn, wSelOut, aluOpIn, aluOpOut, memWriteIn, memWriteOut, rDataSelIn, rDataSelOut, rWriteIn, rWriteOut, jmpIn, jmpOut, brIn, brOut);
    input clk, aluSetIn, wSelIn, memWriteIn, rDataSelIn, rWriteIn, jmpIn, brIn;
    input [31:0] pcIn;
    input [3:0] aluOpIn;
    output reg aluSetOut, wSelOut, memWriteOut, rDataSelOut, rWriteOut, jmpOut, brOut;
    output reg [31:0] pcOut;
    output [3:0] aluOpOut;

    always @(posedge clk) begin
        aluSetOut <= aluSetIn;
        pcOut <= pcIn;
        wSelOut <= wSelIn;
        aluSelOut <= aluSelIn;
        memWriteOut <= memWriteIn;
        rDataSelOut <= rDataSelIn;
        rWriteOut <= rWriteIn;
        jmpOut <= jmpIn;
        brOut <= brIn;
    end

    // The following are contained in this module:
    // [31:0] pc
    // [10:0] IDCntrl - aluSet, wSel, aluOp(this guy is 3 bits long), memWrite, rDataSel, rWrite, jmp, br
endmodule

module EXPipeReg(clk, wbEnable, memRead, memWrite, iType, isBranch, isJump, alures, rt);
    // The following are contained in this module
    // [3:0] ExCntrl - br, memWrite, rDataSel, rWrite
    // [31:0] result
    // [4:0] dst
    // [31:0] ddr
    input clk, wbEnable, memRead, memWrite, iType, isBranch, isJump;
    input [31:0] aluRes;
    input [4:0] inRT;

    output dataMem;
    output [4:0] outRT;

    always @(posedge clk) begin
        
    end
endmodule // pipeReg3

module MEMPipeReg(clk, memWriteIn, memWriteOut, dataIn, dataOut, dstIn, dstOut);
    // memCntrl (just write)
    // [31:0] data
    // [2:0] dst
    input clk, memWriteIn;
    input [31:0] dataIn;
    input [2:0] dstIn;

    output reg memWriteOut;
    output reg [31:0] dataOut;
    output reg [31:0] dstOut;

    always @(posedge clk) begin
        dataOut <= dataIn;
        dstOut <= dstIn;
        memWriteOut <= memWriteIn;
    end

endmodule


