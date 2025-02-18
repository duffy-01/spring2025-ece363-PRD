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
	output reg [31:0] pc
);
	// control inputs
	wire pc_src, result_src, mem_write, alu_src, reg_write;
	wire [3:0] alu_control;
	wire [1:0] imm_src;
	wire [31:0] instruction;

	// ALU inputs
	wire [31:0] A, B, alu_out;
	wire carry_out;

	// ALU assignments
	assign A =  r_read_data1;
	assign B = (imm_src == 2'b00) ? r_read_data2 : instruction[31:20];

	// register file inputs
	wire [4:0] rd, rs1, rs2;
	wire [31:0] r_write_data, r_read_data1, r_read_data2;_

	// register assignments
	assign rd = instruction[11:7];
	assign rs1 = instruction[19:15];
	assign rs2 = instruction[24:20];
	assign r_write_data = (alu_src == 1'b0) ? instruction[31:20] : alu_out;
	
	// memory inputs
	wire [9:0] address;
	wire [31:0] m_write_data, m_read_data;
	
	//// memory assignments
	assign address = (imm_src == 2'b10) ? instruction[31:20] : r_read_data2;
	assign m_write_data = r_read_data2;

	always @(posedge clk or negedge reset) begin
		if (reset) begin
			pc <= 32'b0;
		end
		else begin
			if (pc_src) begin
				pc <= alu_out;
			end else begin
				pc <= pc + 32'd4;
			end
		end
	end

	instruction_rom rom_unit(
		.address(pc),
		.instruction(instruction)
	);
	control control_unit(
		.instruction(instruction),
		.pc_src(pc_src),
		.result_src(result_src),
		.mem_write(mem_write),
		.alu_control(alu_control),
		.imm_src(imm_src),
		.read_data(read_data),
		.read_reg1(read_reg1),
		.read_reg12(read_reg12)
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
		.write_data(m_write_data),
		.mem_write(mem_write),
		.read_data(m_read_data)
	);

	register_file register_file_unit(
		.clk(clk),
		.reset(reset),
		.read_reg1(read_reg1),
		.read_reg2(read_reg2),
		.write_reg(write_reg),
		.write_data(r_write_data),
		.reg_write(reg_write),
		.read_data1(r_read_data1),
		.read_data2(r_read_data2)
	);
endmodule
