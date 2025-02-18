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
// Date of last modification: Thursday, 13 February 2025 @ 12:05
//*************************************************************************

module ipu(
	input clk,
	input reset,
	output [31:0] pc,
	output [31:0] instruction

	wire [31:0] ;


	always @(posedge clk or posedge reset) begin
		if (reset) begin
			pc <= 32'b0;
		end
		else begin
			pc <= pc + 32'b4;
		end
	end

	control control_unit(
		.instruction(instruction),
		.pc_src(pc_src),
		.result_src(result_src),
		.mem_write(mem_write),
		.alu_control(alu_control),
		.alu_src(alu_src),
		.imm_src(imm_src),
		.reg_write(reg_write)
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
		.read_data1(read_data1),
		.read_data2(read_data2)
	);

);
endmodule
