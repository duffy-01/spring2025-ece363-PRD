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
// Date of last modification: Monday, 24 February 2025 @ 11:50
//*************************************************************************
`include "definitions.sv"

module control(
	input [31:0] instruction,
	output reg pc_src,
	output reg mem_write, 
	output reg [3:0] alu_control,
	output reg alu_src,
	output reg [1:0] imm_src,
	output reg reg_write,
	output reg result_src,
	output reg atomic_flag,
	output reg reserved_flag
);

	// Parse instruction fields
	wire [6:0] opcode   = instruction[6:0];
	wire [2:0] funct3   = instruction[14:12];
	wire [4:0] funct5   = instruction[31:27]; 

	always @(*) begin
		// Default values
		pc_src = 0; result_src = 0; mem_write = 0;
		alu_src = 0; imm_src = 2'b00; reg_write = 0;
		case (opcode)
			`OPCODE_I: begin
				imm_src = 2'b01;
				reg_write = 1;
				mem_write = 0; 
				alu_src = 1;
				result_src = 0;
				case (funct3)
					`FUNCT3_ADDI: alu_control = `ALU_ADD;
					`FUNCT3_ANDI: alu_control = `ALU_AND;
					`FUNCT3_ORI:  alu_control = `ALU_OR;
				endcase
			end

			`OPCODE_ATM: begin
				imm_src = 2'b00;
				reg_write = 1;
				mem_write = 1;
				alu_src = 0;
				result_src = 1;
				atomic_flag = 1;
				case (funct5)
					`F5_ATM_SWAP: alu_control = `ALU_SWAP;   // Swap memory value
					`F5_ATM_ADD: alu_control = `ALU_ADD;     // Add to memory value
					`F5_ATM_AND: alu_control = `ALU_AND;     // AND with memory value
					`F5_ATM_OR:  alu_control = `ALU_OR;      // OR with memory value
					`F5_ATM_XOR: alu_control = `ALU_XOR;     // XOR with memory value
					`F5_ATM_MIN: alu_control = `ALU_MIN;
					`F5_ATM_MAX: alu_control = `ALU_MAX;
					`F5_ATM_LR:  begin alu_control = `ALU_ADD; reserved_flag = 1; end    // Load reserved
					`F5_ATM_SC:  begin alu_control = `ALU_ADD;   reserved_flag = 0; end // Store conditional
				endcase
			end

			`OPCODE_LOAD: begin
				imm_src = 2'b01; 
				reg_write = 1; 
				mem_write = 0;
				alu_src = 1; 
				result_src = 1;
				case (funct3)
					`FUNCT3_LW: alu_control = `ALU_ADD;
				endcase
			end

			`OPCODE_STORE: begin
				imm_src = 2'b10;
				reg_write = 0;
				mem_write = 1;
 				alu_src = 1;
				case (funct3)
					`FUNCT3_SW: alu_control = `ALU_ADD;
				endcase
			end

			default: begin
				pc_src = 0; 
				result_src = 0; 
				mem_write = 0;
				alu_src = 0; 
				imm_src = 2'b00; 
				reg_write = 0;
			end
		endcase
	end

endmodule
