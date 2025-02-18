//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Full implementation of RISC-V IPU.
//
// Filename: ipu.sv
// Additional files needed: N/A
//
// Date of last modification: 18 February 2025
//*************************************************************************

module ipu(
	input clk,
	input reset,
	output reg [31:0] pc,
	output [31:0] instruction
);
	// control inputs
	wire pc_src, result_src, mem_write, alu_src, reg_write;
	wire [3:0] alu_control;
	wire [1:0] imm_src;

	// ALU inputs
	wire [31:0] A, B, alu_out;
	wire carry_out;

	// register file inputs
	wire [4:0] rd, rs1, rs2;
	wire [31:0] write_data, read_data1, read_data2;

	// memory inputs
	wire [31:0] address, write_data, read_data;


	always @(posedge clk or negedge reset) begin
		if (reset) begin
			pc <= 32'b0;
		end
		else begin
			if (pc_src) begin
				pc <= alu_out;
			end else begin
				pc <= pc + 32'b4;
			end
		end
	end

	control control_unit(
		.instruction(instruction),
		.pc_src(pc_src),
		.result_src(result_src),
		.mem_write(mem_write),
		.alu_control(alu_control),
		.imm_src(imm_src),
		.rd(rd),
		.rs1(rs1),
		.rs2(rs2)
	);

	alu alu_unit(
		.A(A),
		.B(B),
		.alu_op(alu_control),
		.alu_out(alu_out),
		.carry_out(carry_out)
	);
	memory memory_unit(
		.clk(clk),
		.address(address),
		.write_data(write_data),
		.mem_write(mem_write),
		.read_data(read_data)
	);

	register_file register_file_unit(
		.clk(clk),
		.reset(reset),
		.reg_write(reg_write),
		.rd(rd),
		.rs1(rs1),
		.rs2(rs2),
		.write_data(write_data),
		.instruction(instruction)
		.write_data(write_data),
		.read_data1(read_data1),
		.read_data2(read_data2)
	
	);
endmodule
