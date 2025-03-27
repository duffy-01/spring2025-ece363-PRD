//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Purpose of program: Harness for control.sv
//
// Filename: control.test_top.sv
// Additional files needed: N/A
//
// Date of last modification: Thursday, 27 March 2025 @ 11:50
//************************************************************************

module control_top;
    parameter sim_cycle = 10;
    reg sys_clk;

    control_if top_if(sys_clk);
    control_tb test(top_if);
    control dut(
		.instruction(top_if.instruction),
		.pc_src(top_if.pc_src),
		.mem_write(top_if.mem_write), 
		.alu_control(top_if.alu_control),
		.alu_src(top_if.alu_src),
		.imm_src(top_if.imm_src),
		.reg_write(top_if.reg_write),
		.result_src(top_if.result_src),
		.atomic_flag(top_if.atomic_flag),
		.reserved_flag(top_if.reserved_flag)
	);

    // system clock
    
    initial begin
        sys_clk = 0
        forever begin $(sim_cycle/2) sys_clk = ~sys_clk; end
    end

    endmodule
    