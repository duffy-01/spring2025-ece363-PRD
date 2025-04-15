//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement RAM registers for IPU.
//
// Filename: register.sv
// Additional files needed: N/A
//
// Date of last modification: Thursday, 13 February 2025 @ 12:07
//*************************************************************************

module register(
	input clk,					// Clock signal
	input reset,				// Reset signal
	input [4:0] read_reg1,		// Register 1 to read
	input [4:0] read_reg2,		// Register 2 to read
	input [4:0] write_reg,		// Register to write
	input [31:0] write_data,	// Data to write
	input reg_write,			// Write enable signal
	output [31:0] read_data1,	// Data read from register 1
	output [31:0] read_data2,	// Data read from register 2
	output [31:0] read_data3	// Data read from reregister rd for atomics
);
	reg [31:0] reg_file [0:31];
	// Read operations
	assign read_data1 = reg_file[read_reg1]; //read reg 1
	assign read_data2 = reg_file[read_reg2]; //read reg 2
	assign read_data3 = reg_file[write_reg]; //read reg 3

	// Write operation
	always @(posedge clk or posedge reset) begin //on clock edge or reset
		if (reset) begin //reset all if reset triggered
			integer i;
			for (i = 0; i < 32; i = i + 1) begin
				reg_file[i] <= 32'b0;
			end
		end else if (reg_write) begin //write to register if write signal enabled
			reg_file[write_reg] <= write_data;
		end
	end
endmodule
