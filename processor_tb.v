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
			   $display("Time:%3d Clk: %d", $time, Clk);
   end
endmodule


   





