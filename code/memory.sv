//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Thursday, 13 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement RAM.
//
// Filename: memory.sv
// Additional files needed: N/A
//
// Date of last modification: Thursday, 13 February 2025 @ 11:47
//*************************************************************************

module memory(
	input clk,
	input [9:0] address,
	input [31:0] write_data,
	input mem_write,
	output [31:0] read_data
	);
	reg [31:0] RAM [0:1023]; 				// 1024 32-bit words

	// Read operation, continuous
	always @(*) begin
		read_data = RAM[address]; 		//read from specified address
	end
	// Write operation
	always @(posedge) begin 				//on clock edge
		if (reg_write) begin 				//write to address if write signal enabled
			RAM[address] <= write_data;
		end
	end

endmodule
