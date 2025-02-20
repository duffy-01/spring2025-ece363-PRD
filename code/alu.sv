//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement 32-bit ALU capable of addi, ori, andi, lw, and sw.
//
// Filename: alu.sv
// Additional files needed: N/A
//
// Date of last modification: Thursday, 13 February 2025 @ 11:49
//*************************************************************************

/* ALU Arithmetic and Logic Operations (funct3 column)
| alu_op |  ALU Operation 
|  0000  |  alu_out = A + B;        addi	opcode: 0010011
|  1000  |  alu_out = A & B;        andi		=
|  0111  |  alu_out = A | B;        ori			=
|  0010  |  alu_out = memaddress;   sw		opcode: 0100011
|  0010  |  alu_out = memaddress;   lw		opcode: 0000011

*/
`include "definitions.sv"
module alu(
  input [31:0] A, B,
  input [3:0] alu_op,
  output [31:0] alu_out,
  output carry_out
);
  reg [31:0] alu_result;
  wire [32:0] tmp;
  
  assign alu_out = alu_result; // ALU out
  assign tmp = {1'b0,A} + {1'b0,B};
  assign carry_out = tmp[32]; // Carryout flag
  
  always @(*)
    begin
        case(alu_op)
          `ALU_ADD:    alu_result = A + B ;           // add / atom add / address calculations 
          `ALU_AND:    alu_result = A & B ;           // and / atom and
          `ALU_OR:     alu_result = A | B;            // or / atom or
          `ALU_SWAP:   alu_result = B;                // atomic swap
          `ALU_XOR:    alu_result = A ^ B;            // atomic xor
          `ALU_MAX:    alu_result = (A > B) ? A : B;  // atomic Max
          `ALU_MIN:    alu_result = (A > B) ? B : A;  // atomic Min
          //`ALU_LR:     alu_result = A;                // load reserved
          //`ALU_SC:     alu_result = (A == B) ? 32'b1 : 32'b0; // store conditional
          default:     alu_result = 32'b0;            // default 0
    endcase
  end
endmodule