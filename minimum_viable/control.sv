//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement controller. Handles instructions and memory.
//
// Filename: control.sv
// Additional files needed: N/A
//
// Date of last modification: Monday, 24 February 2025 @ 11:50
//************************************************************************

`define DEFINITIONS_SV
// ----------------------------
// RISC-V OPCODES
`define OPCODE_R       7'b0110011  // R-type (Standard ALU) (not actually needed) 
`define OPCODE_I       7'b0010011  // I-type (Immediate ALU)
`define OPCODE_LOAD    7'b0000011  // I-type (Load)
`define OPCODE_STORE   7'b0100011  // S-type (Store)
`define OPCODE_ATM     7'b0101111  // atomic operations
// ----------------------------

// ----------------------------
// ALU OPCODES
`define ALU_ADD		   4'b0000     //add ops
`define ALU_OR         4'b0001     //or ops
`define ALU_AND		   4'b0010     //and ops
`define ALU_SWAP       4'b0011     //atomic swap ops
`define ALU_XOR        4'b0100     //xor ops
`define ALU_MAX		   4'b0101     //max ops
`define ALU_MIN        4'b0110     //min ops
`define ALU_LR		   4'b0111     //max ops
`define ALU_SC         4'b1000     //min ops

// ----------------------------

// ----------------------------
// FUNCT3 Vals
`define FUNCT3_ADDI	   3'b000     //addi funct 3 code
`define FUNCT3_ORI	   3'b110     //ori funct 3 code
`define FUNCT3_ANDI	   3'b111     //and funct 3 code
`define FUNCT3_LW	   3'b010     //lw funct 3 code (may not be needed)
`define FUNCT3_SW	   3'b010     //lw funct 3 code (may not be needed)
`define FUNCT3_ATM	   3'b010     //RV32A funct 3 code (may not be needed)
// ----------------------------

// ----------------------------
// RV32A FUNCT5 Vals
`define F5_ATM_SWAP	   5'b00001     //atomic swap f5 code
`define F5_ATM_ADD	   5'b00000     //atomuc add f5 code
`define F5_ATM_AND	   5'b01100     //atomic and f5 code
`define F5_ATM_OR	   5'b01010     //atomic or f5 code
`define F5_ATM_XOR	   5'b00100     //atomic xor f5 code
`define F5_ATM_MAX	   5'b10100     //atomic max f5 code
`define F5_ATM_MIN	   5'b10000     //atomic min f5 code
`define F5_ATM_LR	   5'b00010     //load reserved f5 code
`define F5_ATM_SC	   5'b00011     //store cond f5 code
// ----------------------------


//*************************************************************************

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
		atomic_flag = 0;
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