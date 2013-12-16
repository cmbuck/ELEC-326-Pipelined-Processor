`define MAX_SIMULATION_TIME 800
`define P myProcessor
`define D INSDecoder

module processor_TestBench;	

   reg  Clk;

   processor myProcessor(Clk); // Instantiate the processor
   
   integer i;

   initial begin
      Clk = 0;
      #10;
   end
   
   always @(*) begin
     while ($time < `MAX_SIMULATION_TIME)
       begin
          	#5; Clk = ~Clk;
       end
   end
   
   
   always @(negedge Clk)  begin
      $display("Time:%3d Clk:%d\n", $time, Clk);
      //for(i = 0; i < 32; i = i + 1) begin
         //$display("%x ", myProcessor.Regfile.reg_array.bit_reg[i].outVal);
         //if(i % 8 == 0 && i != 0) begin
             //$display("\n");
         //end
      //end

      //$display("%x", `P.ALU.writeReg);

      $display("IFPipeReg: PC:%x, Instr:%x", myProcessor.PCReg.PCout, myProcessor.IFPipeReg.instrOut);
      $display("Decoder: ins: %x, addrInfo: %x, aluOp: %x, writeReg:%x, memRead:%x, memWrite:%x, iType:%x, wbEnable:%x, isBranch:%x, isJump:%x", `P.`D.instruction, `P.`D.addrInfo, `P.`D.ALUop, `P.`D.writeReg, `P.`D.memRead, `P.`D.memWrite, `P.`D.iType, `P.`D.wbEnable, `P.`D.isBranch, `P.`D.isJump);  
      $display("IDPipeReg: PC:%x aluSel:%x wSel:%x aluOp:%x memWrite:%x rDataSel:%x rWrite:%x jmp:%x br:%x rsv:%x, rtv:%x, addrInfo:%x, isMemRead:%x",
           myProcessor.IDPipeReg.pcOut, myProcessor.IDPipeReg.aluSelOut, myProcessor.IDPipeReg.wSelOut, myProcessor.IDPipeReg.aluOpOut, 
           myProcessor.IDPipeReg.memWriteOut, myProcessor.IDPipeReg.rDataSelOut, myProcessor.IDPipeReg.rWriteOut, myProcessor.IDPipeReg.jmpOut, myProcessor.IDPipeReg.brOut, myProcessor.IDPipeReg.rsOut, myProcessor.IDPipeReg.rtOut, myProcessor.honestToGoodness.outData, myProcessor.IDPipeReg.rDataSelOut);
      $display("aluOp: %x, op1: %x, op2: %x, jmp: %x, br: %x, pc %x, addrInfo %x, aluRes: %x, trgtAddr: %x", myProcessor.ALU.aluOp, myProcessor.ALU.operand1, myProcessor.ALU.operand2, myProcessor.ALU.jump, myProcessor.ALU.branch, myProcessor.ALU.pc, myProcessor.ALU.addrInfo, myProcessor.ALU.aluResult, myProcessor.ALU.targetAddr);
      $display("EXPipeReg: br:%x memWrite:%x rDataSel:%x rWrite:%x result:%x dst:%x ddr:%x isMemRead:%x", myProcessor.EXPipeReg.brOut, 
           myProcessor.EXPipeReg.memWriteOut, myProcessor.EXPipeReg.rDataSelOut, myProcessor.EXPipeReg.rWriteOut, myProcessor.EXPipeReg.resultOut, 
           myProcessor.EXPipeReg.dstOut, myProcessor.EXPipeReg.ddrOut, `P.EXPipeReg.rDataSelOut);
      $display("MEMPipeReg: memWrite:%x data:%x dst:%x", myProcessor.MEMPipeReg.rWriteOut, myProcessor.MEMPipeReg.dataOut, 
           myProcessor.MEMPipeReg.dstOut); 
       $display("alu: %x, in2: %x, muxSEL: %x", `P.camel.inData1, `P.camel.inData2, `P.camel.Select);
      $display("%x\n", myProcessor.Regfile.outInputs);
      $display("************************************************");      
   end
endmodule


   




