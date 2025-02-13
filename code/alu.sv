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

/* ALU Arithmetic and Logic Operations
|ALU_Sel|   ALU Operation
| 0000  |   alu_out = A + B;        addi
| 0001  |   alu_out = A & B;        andi
| 0010  |   alu_out = A | B;        ori
| 0011  |   alu_out = memaddress;   sw
| 0100  |   alu_out = memaddress;   lw

*/

module alu(
  input [31:0] A, B,
  input [3:0] op_code,
  output [31:0] alu_out,
  output carry_out
);
  reg [7:0] alu_result;
  wire [8:0] tmp;
  
  assign ALU_Out = ALU_Result; // ALU out
  assign tmp = {1'b0,A} + {1'b0,B};
  assign CarryOut = tmp[8]; // Carryout flag
  
  always @(*)
    begin
        case(ALU_Sel)
        4'b0000: // add
           alu_result = A + B ; 
        4'b0001: // and
           alu_result = A & B ;
        4'b0010: // or
           alu_result = A | B;
        4'b0011: // sw
           alu_result = foo;
        4'b0100: // lw
           alu_result = bar;
      default: alu_result = NULL; 
    endcase
  end
endmodule
  
