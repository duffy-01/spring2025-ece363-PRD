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
		#20 clk = ~clk;
	end
	initial begin //reset then run
		clk = 0;
		reset = 1;
		#20 reset = 0;
	end

	//runtime catch
	initial begin
		#600 $finish;
	end

	//waveform creation (dve)
	initial begin
		$dumpfile("ipu_tb.vcd");
		$dumpvars(0, ipu_tb);
		$display("Dumping VCD file");
		$display("Simulation started");
		$monitor("pc = %b", pc);
	end

	initial begin $monitor("pc = %b", pc); end

	// Display memory and register contents
	always @(posedge clk) begin
		$display("Memory Contents:");
		for (int i = 0; i < 32; i = i + 1) begin
			$display("RAM[%0d] = %h", i, dut.memory_unit.RAM[i]);
		end

		$display("Register File Contents:");
		for (int j = 0; j < 32; j = j + 1) begin
			$display("reg_file[%0d] = %h", j, dut.register_file_unit.reg_file[j]);
		end
	end

endmodule
