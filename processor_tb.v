`define MAX_SIMULATION_TIME 800


module processor_TestBench;	

   reg  Clk;

   processor myProcessor(Clk); // Instantiate the processor
   

   initial begin
      Clk = 0;
   end

   always @(*) begin
     while ($time < `MAX_SIMULATION_TIME)
       begin
          	#5; Clk = ~Clk;
       end
   end
   
   
   always @(negedge Clk)  begin
      $display("Time:%3d Clk:%d\n\n", $time, Clk);
      $display("ifPipeReg\n PC:%d, Instr:%b\n\n***********************************\n\n", ifPipeReg.pcIn, ifPipeReg.instrIn);
      $display("idPipeReg\n PC:%d aluSel:%d wSel:%d aluOp:%d memWrite:%d rDataSel:%d rWrite:%d jmp:%d br:%d\n\n***********************************\n\n",
	       idPipeReg.pcIn, idPipeReg.aluSelIn, idPipeReg.wSelIn, idPipeReg.aluOpIn, idPipeReg.memWriteIn, idPipeReg.rDataSelIn, idPipeReg.rWriteIn, idPipeReg.jmpIn, idPipeReg.brIn);
      $display("exPipeReg\n br:%d memWrite:%d rDataSel:%d rWrite:%d result:%b dst:%d ddr:%x\n\n***********************************\n\n", exPipeReg.brIn, exPipeReg.memWriteIn, exPipeReg.rDataSelIn, exPipeReg.rWriteIn, exPipeReg.resultIn, exPipeReg.dstIn, exPipeReg.ddrIn);
      $display("memPipeReg\n memWrite:%d data:%x dst:%d\n\n***********************************\n\n", memPipeReg.memWriteIn, memPipeReg.dataIn, memPipeReg.dstIn); 
   end
endmodule


   




