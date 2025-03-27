interface control_if(input logic clk);
	logic [31:0] instruction;
	logic pc_src;
	logic mem_write; 
	logic [3:0] alu_control;
	logic alu_src;
	logic [1:0] imm_src;
	logic reg_write;
	logic result_src;
	logic atomic_flag;
	logic reserved_flag;
	clocking cb@(posedge clk);
		default input #1 output #0
		output instruction;
		input pc_src, mem_write, alu_control, alu_src, imm_src, reg_write, result_src, atomic_flag, reserved_flag;
	endclocking
	default clocking cb;
	modport TB(clocking cb, 
		output instruction, 
		pc_src, 
		mem_write, 
		alu_control, 
		alu_src, 
		imm_src, 
		reg_write, 
		result_src, 
		atomic_flag, 
		reserved_flag
	);
endinterface