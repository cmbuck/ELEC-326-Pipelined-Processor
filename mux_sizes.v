/* Only have 2 sizes of 2-input MUXes: 32-bit inputs and 5-bit inputs
 Both of the MUXes are modeled off of the S_regFile MUX_N_Mbit */

module mux_64_32bit(Select, inData, outData);

   /* This mux is to choose b/w register value or address info as input to ALU
    NOTE: when Select is 1, the first input (inData[31:0]) is selected  */
     
   input Select;  
   input [63:0] inData;
   output [31:0] outData;
   
   wire [32:0] 	 inData1, inData2;
   
   assign inData1 = inData[31:0]; 
   assign inData2 = inData[63:31];
   
   /* NOTE: when Select is 0 the first input (inData[63:31]) is selected */
   assign outData = Select?inData1:inData2;
   
endmodule // Mux_64_32bit

/* This mux is to choose how to increment PC */

module mux_3input_32bit(Select, inData, outData);

   input [1:0] Select;
   input [95:0] inData; // 3 inputs, 32bit --> 3*32 = 96
   output [31:0] outData;

   wire [31:0] 	 inData1, inData2, inData3;
   
   assign inData1 = inData[31:0];
   assign inData2 = inData[63:32];
   assign inData3 = inData[95:64];

   assign outData = (Select == 0)?inData1:(Select == 1)?inData2:inData3;

endmodule // Mux_3input_32bit



/* This mux is to choose which REG to write to in REG_FILE */

module mux_10_5bit(Select, inData, outData);
   
   input Select;
   input [9:0] inData;
   output [4:0] outData;

   wire [4:0] 	inData1, inData2;
   
   assign inData1 = inData[4:0];
   assign inData2 = inData[9:5];
   
   assign outDat = Select?inData1:inData2;
   
endmodule // Mux_10_5bit

