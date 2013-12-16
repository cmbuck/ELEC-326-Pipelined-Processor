//  Suggestion:
//  Define  macros like the following commented block. That alllows you to use  meangful symbolic names (rather than 
// hard-to-parse and easy to  mangle) bit strings in the main code.

//Macros
//Defined as their opcodes
`define RType 6'h0
`define ADDI  6'h8
`define	LOAD  6'h20
`define	STORE 6'h30
`define	BEQ   6'h4
`define	JMP   6'h2

//Defined as their funct values
`define ADD  6'h20
`define SUB  6'h22
`define AND  6'h24
`define  OR  6'h25
`define SLT  6'h2A
`define NOP  6'h0

//Defined as part of instruction
`define OPCODE	instruction[31:26]
`define R_D		instruction[15:11]
`define R_T		instruction[20:16]
`define ADDRINFO	instruction[25:0]
`define FUNCT	instruction[5:0]



module insDecoder(instruction, addrInfo, ALUop, writeReg, memRead, memWrite, iType, wbEnable, isBranch, isJump);

input wire [31:0] instruction;
output wire [25:0] addrInfo;
output reg [2:0] ALUop;
output wire [4:0] writeReg;
output wire wbEnable, memRead, memWrite, iType, isBranch, isJump;


   /*
    Input: 
                   32-bit "instruction"
    Outputs:
    
    isBranch, isJump : TRUE  if instruction is branch or jump respectively; FALSE  otherwise.
    memRead: TRUE if instruction will read from data memory; FALSE otherwise.
    memWrite: TRUE if instruction will write to  data memory; FALSE otherwise.
    wbEnable: TRUE if instruction will write a result to a register; FALSE otherwise
    iType: TRUE if it is an IType instruction that is not a Branch; FALSE for Branch and non I-Type istructions.
    
    writeReg: id of register to be written; dont care if wbEnable is set to FALSE.
    addrInfo: the 26 LSBs of the instruction
    ALUop:  Defined by Table 2/
   
    */
	
	assign isBranch = 	(`BEQ == `OPCODE);
	assign isJump	 =	(`JMP == `OPCODE);
	assign memRead	 =	(`LOAD == `OPCODE);
	assign memWrite =	(`STORE == `OPCODE);
	assign wbEnable =	((`OPCODE == `RType && `FUNCT != 0) || `OPCODE == `ADDI || `OPCODE == `LOAD);
	assign iType	 =	(`OPCODE == `ADDI || `OPCODE == `LOAD || `OPCODE == `STORE);
	assign writeReg =	(`OPCODE == `RType ? `R_D : `R_T);
	assign addrInfo =	 `ADDRINFO;

	always @(*) begin
	//TODO: add case for ALUop
	case (`OPCODE)
		`ADDI:	ALUop = 1;
		`LOAD:	ALUop = 1;
		`STORE:	ALUop = 1;
		`BEQ:	ALUop = 6;
		`RType:	begin
			case (`FUNCT)
				`ADD:	ALUop = 1;
				`SUB:	ALUop = 2;
				`AND:	ALUop = 3;
				`OR:	ALUop = 4;
				`SLT:	ALUop = 5;
				default:	ALUop = 3'hx;
			endcase
			end
		default:	ALUop = 3'hx;
	endcase
	end
endmodule



