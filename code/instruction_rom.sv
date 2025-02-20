//*************************************************************************
// Author(s): Liam Burke, Shane Duffy
// Creation Date: Tuesday, 11 February 2025
// Class: ECE 363 - Design of Digital Systems
// Assignment: PRD Option 1
// Due date: (Initial submission) Friday, 21 February 2025 @ 23:59
//
// Purpose of program: Implement basic instruction set.
//
// Filename: instruction_rom.sv
// Additional files needed: N/A
//
// Date of last modification: Thursday, 13 February 2025 @ 12:03
//*************************************************************************

module instruction_rom(
	input [31:0] address,
	output reg [31:0] instruction
);
	reg [31:0] rom [0:255];

	initial begin
		// Initialize ROM with instructions
		// Format: rom[address] = instruction;
		rom[0] = 32'b000000000001_00000_000_00001_0010011; // ADDI x1, x0, 1
		rom[1] = 32'b000000000001_00001_111_00010_0010011; // ANDI x2, x1, 1
		rom[2] = 32'b000000000001_00010_110_00011_0010011; // ORI x3, x2, 1
		rom[3] = 32'b000000000000_00011_010_00100_0000011; // LW x4, 0(x3)
		rom[4] = 32'b000000000000_00100_010_00101_0100011; // SW x5, 0(x4)
		rom[5] = 32'b00001_00110_00101_010_00111_0101111;  // ATM SWAP x7, x5, x6
		rom[6] = 32'b00000_00111_00110_010_01000_0101111;  // ATM ADD x8, x6, x7
		rom[7] = 32'b01100_01000_00111_010_01001_0101111;  // ATM AND x9, x7, x8
		rom[8] = 32'b01010_01001_01000_010_01010_0101111;  // ATM OR x10, x8, x9
		rom[9] = 32'b00100_01010_01001_010_01011_0101111;  // ATM XOR x11, x9, x10
		rom[10] = 32'b10100_01011_01010_010_01100_0101111; // ATM MAX x12, x10, x11
		rom[11] = 32'b10000_01100_01011_010_01101_0101111; // ATM MIN x13, x11, x12
		rom[12] = 32'b00010_01101_01100_010_01110_0101111; // LR x14, x12
		rom[13] = 32'b00011_01110_01101_010_01111_0101111; // SC x15, x13, x14
	end

	always @(*) begin
		instruction = rom[address[9:2]]; // Read instruction from ROM, account for pc+4
	end
endmodule
