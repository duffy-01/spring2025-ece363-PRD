//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement TB for RISC-V IPU.
//
// Filename: control_tb.sv
// Additional files needed: control.sv
//
// Date of last modification: Friday, 21 February 2025 @ 12:06
//*************************************************************************

module control_tb();

    reg clk;
    reg reset;
    reg [31:0] pc;
    
	ipu dut(
		.clk(clk),
		.reset(reset),
		.pc(pc)
	);

    always begin
		#20 clk = ~clk;
	end
	initial begin //reset then run
		clk = 0;
		reset = 1;
		#20 reset = 0;
	end

	//runtime catch
	initial begin
		#20000 $finish;
	end

    //waveform creation (dve)
    initial begin
        $dumpfile("control_tb.vcd");
        $dumpvars(0, control_tb);
        $display("Dumping VCD file");
        $display("Simulation started");
        $monitor("pc=%b, instruction=%b, reset=%b", pc, dut.control_unit.instruction, clk, reset);
        $monitor("mem_write=%b, reg_write=%b, imm_src=%b, result_src=%b, pc_src=%b",
        dut.control_unit.mem_write, dut.control_unit.reg_write, dut.control_unit.imm_src, dut.control_unit.result_src, dut.control_unit.pc_src);
    end

endmodule
