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



module processor(clk);

    input clk;
    // Instantiate modules making up the processor

    wire [31:0]  pc, pcPlusFour, pcIFRegOut;

    wire [31:0]  instruction, instructionIFRegOut;

    wire [11:0]  PipeReg1Bus; //connects output of decoder to PipeReg1
    wire [2:0]   aluOp; //connected to intput of ALU
    wire         ALUsel; //connected to mux before ALU
    wire         WSel;
    wire         MemRead; //goes into DataMem
    wire         MemWrite; //goes into DataMem
    wire [15:0]  Immediate; //immediate value in the instruction
    wire [4:0]   DstReg; //input to DST, output of MUX after rt and rd
    wire [31:0]  TargetAddr; //output of ALU, input of DDR
    wire [31:0]  Result; //output of ALU
    wire [31:0]  rt_mux_input;
    wire [31:0]  rs_mux_input;

    //dataMemory DataMemory(MemRead, MemWrite, TargetAddr, StoreValue, LoadValue);
    //alu ALU(aluOp, operand1, operand2, jmp, br, pc, addrInfo, aluResult, TargetAddr);

    insMemory InsMemory(pc, instruction);
    ifPipeReg IFPipeReg(clk, pcPlusFour, pcIFRegOut, instruction, instructionIFRegOut);
    pcAdder PCAdder(pc, pcPlusFour);
    mux_3input_32bit(/*TODO select*/, pcPlusFour, /*TODO something1*/, /*TODO something2*/, /*TODO outData*/);


    initial begin
    // Initialize all microarchitectural registers

    end





endmodule

module pcAdder(pcIn, pcOut)
    input [31:0] pcIn;
    output [31:0] pcOut;

    always @(*) begin
        pcOut = pcIn + 4;
    end
endmodule

module ifPipeReg(clk, pcIn, pcOut, instrIn, instrOut);
    input clk;
    input [31:0] pcIn, instrIn;
    output reg [31:0] pcOut, instrOut;

    always @(posedge clk) begin
        pcOut <= pcIn;
        instrOut <= instrIn;
    end
endmodule

module idPipeReg(clk, pcIn, pcOut, aluSelIn, aluSelOut, wSelIn, wSelOut, aluOpIn, aluOpOut, memWriteIn, memWriteOut, rDataSelIn, rDataSelOut, rWriteIn, rWriteOut, jmpIn, jmpOut, brIn, brOut);
    // The following are contained in this module:
    // [31:0] pc
    // [10:0] IDCntrl - aluSet, wSel, aluOp(this guy is 3 bits long), memWrite, rDataSel, rWrite, jmp, br

    input clk, aluSelIn, wSelIn, memWriteIn, rDataSelIn, rWriteIn, jmpIn, brIn;
    input [31:0] pcIn;
    input [3:0] aluOpIn;
    output reg aluSelOut, wSelOut, memWriteOut, rDataSelOut, rWriteOut, jmpOut, brOut;
    output reg [31:0] pcOut;
    output [3:0] aluOpOut;

    always @(posedge clk) begin
        aluSelOut <= aluSelIn;
        pcOut <= pcIn;
        wSelOut <= wSelIn;
        aluSelOut <= aluSelIn;
        memWriteOut <= memWriteIn;
        rDataSelOut <= rDataSelIn;
        rWriteOut <= rWriteIn;
        jmpOut <= jmpIn;
        brOut <= brIn;
    end

endmodule

module exPipeReg(clk, brIn, brOut, memWriteIn, memWriteOut, rDataSelIn, rDataSelOut, rWriteIn, rWriteOut, resultIn, resultOut, dstIn, dstOut, ddrIn, ddrOut);
    // The following are contained in this module
    // [3:0] ExCntrl - br, memWrite, rDataSel, rWrite
    // [31:0] result
    // [4:0] dst
    // [31:0] ddr
    input clk, brIn, memWriteIn, rDataSelIn, rWriteIn;
    input [31:0] resultIn, ddrIn;
    input [4:0] dstIn;
    output reg brOut, memWriteOut, rDataSelOut, rWriteOut;
    output reg [31:0] resultOut, ddrOut;
    output reg [4:0] dstOut;

    always @(posedge clk) begin
        brOut <= brIn;
        memWriteOut <= memWriteIn;
        rDataSelOut <= rDataSelIn;
        rWriteOut <= rWriteIn;
        resultOut <= resultIn;
        dstOut <= dstIn;
        ddrOut <= ddrIn;
    end
endmodule

module memPipeReg(clk, memWriteIn, memWriteOut, dataIn, dataOut, dstIn, dstOut);
    // memCntrl (just write)
    // [31:0] data
    // [2:0] dst
    input clk, memWriteIn;
    input [31:0] dataIn;
    input [5:0] dstIn;

    output reg memWriteOut;
    output reg [31:0] dataOut;
    output reg [31:0] dstOut;

    always @(posedge clk) begin
        dataOut <= dataIn;
        dstOut <= dstIn;
        memWriteOut <= memWriteIn;
    end
endmodule


