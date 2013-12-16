`define REG_ADDR_LEN 5
`define MEM_WIDTH 32
`define INSTR_BIT_LEN 32

// Define Symbolic Names for Signals  and Register Fields

/* ALUop goes into the ALU and controls what op it carries out
 RWrite (isWbEnable) is essentially WriteEnable and goes into the Reg File
 ALUSel (isIType) selects the input to the ALU, chooses b/w AddrInfo and (rt), goes into 
      MUX just before ALU
 RDataSel (isMemRead) chooses input to data to be written to Reg File, picks b/w DataMem an
      ALU result in PipeReg3 and goes into MUX just before Data in PipeReg4 
 WSel (isWriteReg) chooses between rt and rd to be the register in Reg File written to, goes
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

    wire [31:0]  pcRegIn, pcRegOut, pcPlusFour, pcIFRegOut, pcIDRegOut;

    wire [31:0]  instruction, instructionIFRegOut;

    wire [4:0]   rsIFRegOut;
    wire [4:0]   rtIFRegOut, rtIDRegOut;
    wire [4:0]   rdIFRegOut, rdIDRegOut;
    wire [15:0]  immediateIFRegOut, immediateIDRegOut;
    wire [25:0]  jumpAddrIDRegOut;

    wire [25:0]  addrInfoOut; //used in the event of a jump
    wire [2:0]   aluOpDecoderOut,  aluOpIDRegOut;
    wire         isWriteRegDecoderOut, isWriteRegIDRegOut;
    wire         isMemReadDecoderOut,  isMemReadIDRegOut,   isMemReadEXRegOut;
    wire         isMemWriteDecoderOut, isMemWriteIDRegOut,  isMemWriteEXRegOut;
    wire         isITypeDecoderOut,    isITypeIDRegOut;
    wire         isWbEnableDecoderOut, isWbEnableIDRegOut,  isWbEnableEXRegOut, isWbEnableMEMRegOut;
    wire         isBranchDecoderOut,   isBranchIDRegOut,    isBranchEXRegOut;
    wire         isJumpDecoderOut,     isJumpIDRegOut,      isJumpEXRegOut;

    wire [31:0]  rsValRegFileOut, rsValIDRegOut;
    wire [31:0]  rtValRegFileOut, rtValIDRegOut, rtValEXRegOut;

    wire [25:0]  addrInfoHTGOut;

    wire [31:0]  aluResultALUOut, aluResultEXRegOut;
    wire [31:0]  targetAddrALUOut, targetAddrEXRegOut;

    wire [4:0]   dstRegAddrDecoderOut, dstRegAddrVarmanOut, dstRegAddrEXRegOut, dstRegAddrMEMRegOut;

    wire [31:0]  loadValDataMemoryOut;

    wire [31:0]  regWriteDataCamelOut, regWriteDataMEMRegOut;

    wire         isBranching;


    pcReg PCReg(clk, pcRegIn, pcRegOut);
    insMemory InsMemory(pcRegOut, instruction);
    pcAdder PCAdder(pcRegOut, pcPlusFour);

    mux_2input_32bit masoud(isJumpEXRegOut | (isBranchEXRegOut & aluResultEXRegOut[0]), pcPlusFour, targetAddrEXRegOut, pcRegIn);

    ifPipeReg IFPipeReg(clk, pcPlusFour, pcIFRegOut, instruction, instructionIFRegOut);

    assign rsIFRegOut = instructionIFRegOut[25:21];
    assign rtIFRegOut = instructionIFRegOut[20:16];
    assign rdIFRegOut = instructionIFRegOut[15:11];
    assign immediateIFRegOut = instructionIFRegOut[15:0];

    insDecoder INSDecoder(instructionIFRegOut, addrInfoOut, aluOpDecoderOut, dstRegAddrDecoderOut, isMemReadDecoderOut, isMemWriteDecoderOut, isITypeDecoderOut, isWbEnableDecoderOut, isBranchDecoderOut, isJumpDecoderOut);

    s_regFile Regfile(clk, rsIFRegOut, rtIFRegOut, dstRegAddrMEMRegOut, regWriteDataMEMRegOut, isWbEnableMEMRegOut, rsValRegFileOut, rtValRegFileOut);

    // TODO Clean up isWriteReg because it doesn't do anything
    idPipeReg IDPipeReg(clk, pcIFRegOut, pcIDRegOut, isITypeDecoderOut, isITypeIDRegOut, isWriteRegDecoderOut, isWriteRegIDRegOut, aluOpDecoderOut, aluOpIDRegOut, isMemWriteDecoderOut, isMemWriteIDRegOut, isMemReadDecoderOut, isMemreadIDRegOut, isWbEnableDecoderOut, isWbEnableIDRegOut, isJumpDecoderOut, isJumpIDRegOut, isBranchDecoderOut, isBranchIDRegOut, rsValRegFileOut, rsValIDRegOut, rtValRegFileOut, rtValIDRegOut, dstRegAddrDecoderOut, dstRegAddrVarmanOut, immediateIFRegOut, immediateIDRegOut, instructionIFRegOut[25:0], jumpAddrIDRegOut);

    // EX section
    // TODO Clean up ebrahim
    //mux_2input_32bit ebrahim(isITypeIDRegOut, rtValIDRegOut, {{16{immediateIDRegOut[15]}}, immediateIDRegOut}, outData);

    mux_2input_26bit honestToGoodness(isJumpIDRegOut, {10'h0, immediateIDRegOut}, jumpAddrIDRegOut, addrInfoHTGOut);

    alu ALU(aluOpIDRegOut, rsValIDRegOut, rtValIDRegOut, isJumpIDRegOut, isBranchIDRegOut, pcIDRegOut, addrInfoHTGOut, aluResultALUOut, targetAddrALUOut);

    //mux_2input_5bit varman(isWriteRegIDRegOut, rtIDRegOut, rdIDRegOut, dstRegAddrVarmanOut);

    exPipeReg EXPipeReg(clk, isBranchIDRegOut, isBranchEXRegOut, isMemWriteIDRegOut, isMemWriteEXRegOut, isMemReadIDRegOut, isMemReadEXRegOut, isWbEnableIDRegOut, isWbEnableEXRegOut, isJumpIDRegOut, isJumpEXRegOut, aluResultALUOut, aluResultEXRegOut, rtValIDRegOut, rtValEXRegOut, dstRegAddrVarmanOut, dstRegAddrEXRegOut, targetAddrALUOut, targetAddrEXRegOut);

    // MEM section

    dataMemory DataMemory(isMemReadEXRegOut, isMemWriteEXRegOut, aluResultEXRegOut, rtValEXRegOut, loadValDataMemoryOut);

    mux_2input_32bit camel(isMemReadEXRegOut, aluResultEXRegOut, loadValDataMemoryOut, regWriteDataCamelOut);

    assign isBranching = isBranchEXRegOut & aluResultEXRegOut[0];


    memPipeReg MEMPipeReg(clk, isWbEnableEXRegOut, isWbEnableMEMRegOut, regWriteDataCamelOut, regWriteDataMEMRegOut, dstRegAddrEXRegOut, dstRegAddrMEMRegOut);


    initial begin

    end





endmodule

module pcAdder(pcIn, pcOut);
    input [31:0] pcIn;
    output reg [31:0] pcOut;

    always @(*) begin
        pcOut = pcIn + 4;
    end
endmodule

module ifPipeReg(clk, pcIn, pcOut, instrIn, instrOut);
    input clk;
    input [31:0] pcIn, instrIn;
    output reg [31:0] pcOut, instrOut;

    initial begin
        pcOut = 0;
        instrOut = 0;
    end

    always @(posedge clk) begin
        pcOut <= pcIn;
        instrOut <= instrIn;
    end
endmodule

module idPipeReg(clk, pcIn, pcOut, aluSelIn, aluSelOut, wSelIn, wSelOut, aluOpIn, aluOpOut, memWriteIn, memWriteOut, rDataSelIn, rDataSelOut, rWriteIn, rWriteOut, jmpIn, jmpOut, brIn, brOut, rsIn, rsOut, rtIn, rtOut, dstIn, dstOut, immediateIn, immediateOut, jumpAddrIn, jumpAddrOut);
    // The following are contained in this module:
    // [31:0] pc
    // [10:0] IDCntrl - aluSet, wSel, aluOp(this guy is 3 bits long), memWrite, rDataSel, rWrite, jmp, br

    input clk, aluSelIn, wSelIn, memWriteIn, rDataSelIn, rWriteIn, jmpIn, brIn;
    input [31:0] rsIn, rtIn;
    input [4:0] dstIn;
    input [31:0] pcIn;
    input [2:0] aluOpIn;
    input [15:0] immediateIn;
    input [25:0] jumpAddrIn;
    output reg aluSelOut, wSelOut, memWriteOut, rDataSelOut, rWriteOut, jmpOut, brOut;
    output reg [31:0] rsOut, rtOut;
    output reg [4:0] dstOut;
    output reg [31:0] pcOut;
    output reg [2:0] aluOpOut;
    output reg [15:0] immediateOut;
    output reg [25:0] jumpAddrOut;

    initial begin
        aluSelOut = 0;
        wSelOut = 0;
        memWriteOut = 0;
        rDataSelOut = 0;
        rWriteOut = 0;
        jmpOut = 0;
        brOut = 0;
        rsOut = 0;
        rtOut = 0;
        dstOut = 0;
        pcOut = 0;
        pcOut = 0;
        aluOpOut = 0;
        immediateOut = 0;
        jumpAddrOut = 0;
    end

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
        rsOut <= rsIn;
        rtOut <= rtIn;
        dstOut <= dstIn;
        immediateOut <= immediateIn;
        jumpAddrOut <= jumpAddrIn;
    end

endmodule

module exPipeReg(clk, brIn, brOut, memWriteIn, memWriteOut, rDataSelIn, rDataSelOut, rWriteIn, rWriteOut, jumpIn, jumpOut, resultIn, resultOut, rtValIn, rtValOut, dstIn, dstOut, ddrIn, ddrOut);
    // The following are contained in this module
    // [3:0] ExCntrl - br, memWrite, rDataSel, rWrite
    // [31:0] result
    // [4:0] dst
    // [31:0] ddr
    input clk, brIn, memWriteIn, rDataSelIn, rWriteIn, jumpIn;
    input [31:0] resultIn, ddrIn, rtValIn;
    input [4:0] dstIn;
    output reg brOut, memWriteOut, rDataSelOut, rWriteOut, jumpOut;
    output reg [31:0] resultOut, ddrOut, rtValOut;
    output reg [4:0] dstOut;

    initial begin
        EXPipeReg.brOut = 0;
        EXPipeReg.jumpOut = 0;
        EXPipeReg.resultOut = 0;
    end

    always @(posedge clk) begin
        brOut <= brIn;
        memWriteOut <= memWriteIn;
        rDataSelOut <= rDataSelIn;
        rWriteOut <= rWriteIn;
        jumpOut <= jumpIn;
        resultOut <= resultIn;
        dstOut <= dstIn;
        ddrOut <= ddrIn;
        rtValOut <= rtValIn;
    end
endmodule

module memPipeReg(clk, rWriteIn, rWriteOut, dataIn, dataOut, dstIn, dstOut);
    // memCntrl (just write)
    // [31:0] data
    // [2:0] dst
    input clk, rWriteIn;
    input [31:0] dataIn;
    input [4:0] dstIn;

    output reg rWriteOut;
    output reg [31:0] dataOut;
    output reg [4:0] dstOut;

    always @(posedge clk) begin
        dataOut <= dataIn;
        dstOut <= dstIn;
        rWriteOut <= rWriteIn;
    end
endmodule

/* PC Reg */
module pcReg(clk, PCin, PCout);
   input clk;
   input [31:0] PCin;
   output reg [31:0] PCout;

   initial begin
       PCout = 0;
   end

   always @(posedge clk)begin
      PCout <= PCin;
   end
endmodule // PC

//seannned
    //wire [11:0]  PipeReg1Bus; //connects output of decoder to PipeReg1
    //wire [2:0]   aluOp; //connected to intput of ALU
    //wire         ALUsel; //connected to mux before ALU
    //wire         WSel;
    //wire         MemRead; //goes into DataMem
    //wire         MemWrite; //goes into DataMem
    //wire [15:0]  Immediate; //immediate value in the instruction
    //wire [4:0]   DstReg; //input to DST, output of MUX after rt and rd
    //wire [31:0]  TargetAddr; //output of ALU, input of DDR
    //wire [31:0]  Result; //output of ALU
    //wire [31:0]  rt_mux_input;
    //wire [31:0]  rs_mux_input;

    //dataMemory DataMemory(MemRead, MemWrite, TargetAddr, StoreValue, LoadValue);
    //alu ALU(aluOp, operand1, operand2, jmp, br, pc, addrInfo, aluResult, TargetAddr);


