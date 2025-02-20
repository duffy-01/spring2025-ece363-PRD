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
	input [31:0] address,
	input [31:0] write_data,
	input mem_write,
	input lr,
	input sc,
	output reg sc_success,
	output reg [31:0] read_data
	);
	reg [31:0] RAM [0:1023]; 				// 1024 32-bit words

	// Read operation, continuous
	always @(*) begin
		read_data = RAM[address]; 		//read from specified address
	end
	// Write operation
    always @(posedge clk) begin
        if (lr) begin
            // Load-Reserved: Load value and set reservation
            reserved_addr <= address;
            reservation_flag <= 1;
        end 
		else if (sc) begin
            // Store-Conditional: Write only if reservation is still valid
            if (reservation_flag && (reserved_addr == address)) begin
                RAM[address] <= write_data;  // Perform store
                sc_success <= 1;             // Indicate success
                reservation_flag <= 0;       // Clear reservation
            end else begin
                sc_success <= 0;  // Indicate failure
            end
        end 
		else if (mem_write) begin
            // Normal store operation
            RAM[address] <= write_data;
        end
    end

endmodule
