module alu(aluOp, operand1, operand2, jump, branch, pc, addrInfo, aluResult, targetAddr);

input wire  [31:0] operand1, operand2;
input wire [31:0] pc;
input wire [25:0] addrInfo;
input wire jump, branch;
input wire [2:0] aluOp;

output reg [31:0] aluResult, targetAddr;

   // Set "aluResult" to  the result of the ALU operation indicated by "aluOp".
   // Set "targetAddr" if either "branch" or "jump" signal is  set.
   
   // aluOP operations
   // 1: Add operands.
   // 2: Subtract operand2 from operand1.
   // 3: Bitwise AND of operands.
   // 4: Bitwise OR of operands.
   // 5: Output set to TRUE if operand1 is less than operand2 interpreted as unsigned integers; else set to FALSE.
   // 6: Output set to TRUE if operands are equal; else set to FALSE.
   // 7: Output set to TRUE if operand1 is less than operand2 interpreted as signed integers; else set to FALSE.

    initial begin
        aluResult = 0;
        targetAddr = 0;
    end

always @(*)
begin
	case (aluOp)
	3'h1:	aluResult = operand1 + operand2;
	3'h2:	aluResult = operand1 - operand2;
	3'h3:	aluResult = operand1 & operand2;
	3'h4:	aluResult = operand1 | operand2;
	3'h5:	aluResult = operand1 < operand2;
	3'h6:	aluResult = operand1 == operand2;
	3'h7:	aluResult = $signed(operand1) < $signed(operand2);
	default:	aluResult = 32'hx;
	endcase

   // Target Address for Branch
   //  Sign-extend the lower 16 bits of  "addrInfo", scale it by 4, and add to  "pc".  
if (branch == 1'b1)
	targetAddr = ({{16{addrInfo[15]} }, addrInfo[15:0] } << 2) + pc;

   // Target Address for Jump
   // The 26-bit "addrInfo" is scaled by 4 and concatenated to the 4 high-order bits of "pc". 
else if (jump == 1'b1)
	targetAddr = { pc[31:28], addrInfo << 2 };

end

endmodule



