/* Only have 2 sizes of 2-input MUXes: 32-bit inputs and 5-bit inputs
 Both of the MUXes are modeled off of the S_regFile MUX_N_Mbit */

module mux_2input_32bit(Select, inData1, inData2, outData);

   /* This mux is to choose b/w register value or address info as input to ALU
    NOTE: when Select is 1, the first input (inData[31:0]) is selected  */
     
   input wire Select;  
   input wire [31:0] inData1, inData2;
   output wire [31:0] outData;
   
   /* NOTE: when Select is 0 the first input (inData[63:31]) is selected */
   assign outData = Select?inData1:inData2;
   
endmodule // Mux_64_32bit

/* This mux is to choose how to increment PC */

module mux_3input_32bit(Select, inData1, inData2, inData3, outData);

   input wire [1:0] Select;
   input wire [31:0] inData1, inData2, inData3;
   output wire [31:0] outData;

   assign outData = (Select == 0)?inData1:(Select == 1)?inData2:inData3;

endmodule // Mux_3input_32bit



/* This mux is to choose which REG to write to in REG_FILE */

module mux_2input_5bit(Select, inData1, inData2, outData);
   
   input wire Select;
   input wire [4:0] inData1, inData2;
   output wire [4:0] outData;
     
   assign outData = Select?inData1:inData2;
   
endmodule // Mux_10_5bit

