`timescale 1ns / 1ps
`include "defines.sv"
`include "alu.sv"

module alu_tb;

  // Testbench signals
  reg [31:0] A, B;       // Inputs to the ALU
  reg [3:0] alu_op;     // ALU operation code
  wire [31:0] alu_out;   // ALU result (output)
  wire carry_out;        // Carry-out flag

  // Instantiate the ALU
  alu dut (
    .A(A),
    .B(B),
    .alu_op(alu_op),
    .alu_out(alu_out),
    .carry_out(carry_out)
  );

  // Test vectors and expected results
  initial begin
    // Initialize inputs
    A = 32'd0;
    B = 32'd0;
    op_code = `ALU_ADD;
    $display("Running ALU Testbench...");
    
    // Test 1: ADD operation
    A = 32'd15;
    B = 32'd10;
    op_code = `ALU_ADD;  // Add operation
    #10; // Wait for ALU to compute
    $display("A = %d, B = %d, ALU_OUT = %d, Carry_Out = %b", A, B, alu_out, carry_out);
    
    // Test 2: AND operation
    A = 32'h0000000C5;
    B = 32'h0000001C4;
    op_code = `ALU_AND;  // AND operation
    #10;
    $display("A = %h, B = %h, ALU_OUT = %h, Carry_Out = %b", A, B, alu_out, carry_out);
    
    // Test 3: OR operation
    A = 32'hA5A5A5A5;
    B = 32'h5A5A5A5A;
    op_code = `ALU_OR;  // OR operation
    #10;
    $display("A = %h, B = %h, ALU_OUT = %h, Carry_Out = %b", A, B, alu_out, carry_out);
    
    // Test 4: SWAP operation (RV32A)
    A = 32'd2;
    B = 32'd1000;
    op_code = `ALU_SWAP; // SWAP operation
    #10;
    $display("A = %d, B = %d, ALU_OUT = %d, Carry_Out = %b", A, B, alu_out, carry_out);

    // Test 5: ADD operation with overflow (Carry-Out test)
    A = 32'h7FFFFFFF;
    B = 32'd1;  // Add 1 to max 32-bit signed integer
    op_code = `ALU_ADD;  // Add operation
    #10;
    $display("A = %h, B = %d, ALU_OUT = %h, Carry_Out = %b", A, B, alu_out, carry_out);
    
    // End the testbench
    $finish;
  end

endmodule