//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement ALU controller. Handles instructions and memory.
//
// Filename: definitions.sv
// Additional files needed: N/A
//
// Date of last modification: Thursday, 13 February 2025 @ 11:57
//*************************************************************************
`ifndef DEFINITIONS_SV
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

// ----------------------------
// GENERAL CONSTANTS
`define RLEN           32           //register size
// ----------------------------



`endif