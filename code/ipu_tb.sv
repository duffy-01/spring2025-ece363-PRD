//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement TB for RISC-V IPU.
//
// Filename: ipu_tb.sv
// Additional files needed: ipu.sv
//
// Date of last modification: Thursday, 13 February 2025 @ 12:06
//*************************************************************************

module ipu_tb;
	// Inputs
	reg clk;
	reg reset;
	reg [31:0] pc;
	//dut 
	ipu dut(
		.clk(clk),
		.reset(reset),
		.pc(pc)
	);
	always begin
		#10 clk = ~clk;
	end
	initial begin //reset then run
		clk = 0;
		reset = 1;
		#10 reset = 0;
	end

	//runtime catch
	initial begin
		#2000 $finish;
	end

	//waveform creation (dve)
	initial begin
		$dumpfile("ipu_tb.vcd");
		$dumpvars(0, ipu_tb);
		$display("Dumping VCD file");
		$display("Simulation started");
		$monitor("pc = %b", pc);
	end

	intial begin $monitor("pc = %b", pc); end


endmodule
