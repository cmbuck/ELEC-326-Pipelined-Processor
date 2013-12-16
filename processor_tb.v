`define MAX_SIMULATION_TIME 800


module processor_TestBench;	

   reg  Clk;

   processor myProcessor(Clk); // Instantiate the processor
   
   integer i;

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
      $display("Time:%3d Clk:%d\n", $time, Clk);
      //for(i = 0; i < 32; i = i + 1) begin
         //$display("%x ", myProcessor.Regfile.reg_array.bit_reg[i].outVal);
         //if(i % 8 == 0 && i != 0) begin
             //$display("\n");
         //end
      //end

        $display("%x\n", myProcessor.Regfile.reg_array.outInputs);


      $display("IFPipeReg PC:%d, Instr:%x\n", myProcessor.IFPipeReg.pcIn, myProcessor.IFPipeReg.instrIn);
      //$display("IDPipeReg\n PC:%d aluSel:%d wSel:%d aluOp:%d memWrite:%d rDataSel:%d rWrite:%d jmp:%d br:%d\n\n***********************************\n\n",
		   //myProcessor.IDPipeReg.pcIn, myProcessor.IDPipeReg.aluSelIn, myProcessor.IDPipeReg.wSelIn, myProcessor.IDPipeReg.aluOpIn, 
		   //myProcessor.IDPipeReg.memWriteIn, myProcessor.IDPipeReg.rDataSelIn, myProcessor.IDPipeReg.rWriteIn, myProcessor.IDPipeReg.jmpIn, myProcessor.IDPipeReg.brIn);
      //$display("EXPipeReg\n br:%d memWrite:%d rDataSel:%d rWrite:%d result:%b dst:%d ddr:%x\n\n***********************************\n\n", myProcessor.EXPipeReg.brIn, 
		   //myProcessor.EXPipeReg.memWriteIn, myProcessor.EXPipeReg.rDataSelIn, myProcessor.EXPipeReg.rWriteIn, myProcessor.EXPipeReg.resultIn, 
		   //myProcessor.EXPipeReg.dstIn, myProcessor.EXPipeReg.ddrIn);
      //$display("MEMPipeReg\n memWrite:%d data:%x dst:%d\n\n***********************************\n\n", myProcessor.MEMPipeReg.rWriteIn, myProcessor.MEMPipeReg.dataIn, 
		   //myProcessor.MEMPipeReg.dstIn); 
   end
endmodule


   




