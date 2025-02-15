//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement ALU controller. Handles instructions and memory.
//
// Filename: control.sv
// Additional files needed: N/A
//
// Date of last modification: Thursday, 13 February 2025 @ 11:50
//*************************************************************************
`include "definitions.sv"
module control(
	input [31:0] instruction,
	output reg pc_src,
	output reg result_src,
	output reg mem_write, 
	output reg [3:0] alu_control,
	output reg alu_src,
	output reg [1:0] imm_src,
	output reg reg_write
);
	//parse instruction
	wire [6:0] opcode   = instruction[6:0];
	wire [2:0] funct3   = instruction[14:12];
	wire [4:0] funct5   = instruction[31:27]; 

	always @(*) begin
		//defaults
		pc_src = 0; result_src = 0; mem_write = 0; alu_control = `ALU_ADD; 
		alu_src = 0; imm_src = 2'b00; reg_write = 0;

		case(opcode)
			`OPCODE_I: begin
				reg_write = 1; alu_src = 1;
				case (funct3)
					`FUNCT3_ADDI: alu_op = `ALU_ADD;
					`FUNCT3_ANDI: alu_op = `ALU_AND;
					`FUNCT3_ORI:  alu_op = `ALU_OR;
				endcase
			end

			`OPCODE_ATM: begin
				reg_write = 1; mem_write = 1; result_src = 0;
				case (funct5)
					`F5_ATM_SWAP: alu_op = `ALU_SWAP;   // Swap memory value
					`F5_ATM_ADD: alu_op = `ALU_ADD;     // Add to memory value
					`F5_ATM_AND: alu_op = `ALU_AND;     // AND with memory value
					`F5_ATM_OR:  alu_op = `ALU_OR;      // OR with memory value
					`F5_ATM_XOR: alu_op = `ALU_XOR;     // XOR with memory value
					`F5_ATM_MIN: alu_op = `ALU_MIN;
					`F5_ATM_MAX: alu_op = `ALU_MAX;
				endcase

			end

			`OPCODE_LOAD: begin

			end

			`OPCODE_STORE: begin

			end
		
		endcase
	end


endmodule