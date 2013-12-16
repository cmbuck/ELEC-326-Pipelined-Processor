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
      $display("ifPipeReg\n PC:%d, Instr:%b\n\n***********************************\n\n", processor.ifPipeReg.pcIn, processor.ifPipeReg.instrIn);
      $display("idPipeReg\n PC:%d aluSel:%d wSel:%d aluOp:%d memWrite:%d rDataSel:%d rWrite:%d jmp:%d br:%d\n\n***********************************\n\n",
	       processor.idPipeReg.pcIn, processor.idPipeReg.aluSelIn, processor.idPipeReg.wSelIn, processor.idPipeReg.aluOpIn, 
	       processor.idPipeReg.memWriteIn, processor.idPipeReg.rDataSelIn, processor.idPipeReg.rWriteIn, processor.idPipeReg.jmpIn, processor.idPipeReg.brIn);
      $display("exPipeReg\n br:%d memWrite:%d rDataSel:%d rWrite:%d result:%b dst:%d ddr:%x\n\n***********************************\n\n", processor.exPipeReg.brIn, 
	       processor.exPipeReg.memWriteIn, processor.exPipeReg.rDataSelIn, processor.exPipeReg.rWriteIn, processor.exPipeReg.resultIn, 
	       processor.exPipeReg.dstIn, processor.exPipeReg.ddrIn);
      $display("memPipeReg\n memWrite:%d data:%x dst:%d\n\n***********************************\n\n", processor.memPipeReg.memWriteIn, processor.memPipeReg.dataIn, 
	       processor.memPipeReg.dstIn); 
   end
endmodule


   




