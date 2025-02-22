`include "definitions.sv"
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

	// register file
	wire [4:0] rd, rs1, rs2;
	reg [31:0] r_write_data; 
	wire [31:0] r_read_data1, r_read_data2, r_read_data3;
	//reg_file variable
	reg [31:0] reg_file [0:31];


	// ALU inputs
	wire [31:0] A, B, alu_out;
	wire carry_out;

	// memory inputs
	wire [31:0] address;
	wire [31:0] m_write_data, m_read_data;
	wire sc;
	wire lr;
	wire sc_success;

	wire [11:0] immediate = (imm_src == 2'b01) ? instruction[31:20] : {instruction[31:25], instruction[11:7]};
	// register assignments
	assign rd = instruction[11:7];
	assign rs1 = instruction[19:15];
	assign rs2 = instruction[24:20];

	// ALU assignments
	assign A = (alu_src == 1'b0 && result_src == 1) ? r_read_data3 : r_read_data1;
	assign B = (alu_src == 1'b0) ? r_read_data2 : immediate;
	
	// memory assignments
	assign address = (imm_src == 2'b00) ? r_read_data1 : alu_out;
	assign m_write_data = (imm_src == 2'b00) ? alu_out : r_read_data2;
	assign sc = (alu_control == `ALU_SC);
	assign lr = (alu_control == `ALU_LR);

	// program counter assignment
	always @(posedge clk or posedge reset) begin
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
	// reg write data assignment
	always @(*) begin
		if (sc_success == 1'b1) begin
			r_write_data = 32'b0; //clear rd id sc success
		end
		else if (result_src == 1) begin
			r_write_data = m_read_data; //if result_src = 1, we write from memory to reg
		end
		else begin
			r_write_data = alu_out; //otherwise, write from alu to reg
		end
	end

	// instantiate modules
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
		.reset(reset),
		.address(address),
		.write_data(m_write_data),
		.mem_write(mem_write),
		.read_data(m_read_data),
		.lr(lr),
		.sc(sc),
		.sc_success(sc_success)
	);

	register register_file_unit(
		.clk(clk),
		.reset(reset),
		.read_reg1(rs1),
		.read_reg2(rs2),
		.write_reg(rd),
		.write_data(r_write_data),
		.reg_write(reg_write),
		.read_data1(r_read_data1),
		.read_data2(r_read_data2),
		.read_data3(r_read_data3)
	);
endmodule