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
		if (dut.control_unit.instruction == 32'b1) begin
			$finish;
		end
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

	initial begin $monitor("pc = %b", pc); end

    // File handle for logging
    integer log_file;

    // Open the log file
    initial begin
        log_file = $fopen("log.txt", "w");
        if (log_file == 0) begin
            $display("Error: Could not open log file.");
            $finish;
        end
    end

    // Close the log file at the end of the simulation
    initial begin
        #600 $fclose(log_file);
    end

    // Display memory and register contents
    always @(posedge clk) begin
        $fdisplay(log_file, "Memory Contents:");
        for (int i = 0; i < 32; i = i + 1) begin
            $fdisplay(log_file, "RAM[%0d] = %h", i, dut.memory_unit.RAM[i]);
        end

        $fdisplay(log_file, "Register File Contents:");
        for (int j = 0; j < 32; j = j + 1) begin
            $fdisplay(log_file, "reg_file[%0d] = %h", j, dut.register_file_unit.reg_file[j]);
        end
    end

endmodule
