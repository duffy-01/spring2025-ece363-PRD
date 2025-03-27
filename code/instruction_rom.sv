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
		// addi reg 2 = reg 1 + 3
		rom[0] = 32'b000000000011_00001_000_00010_0010011;
		// addi reg 3 = reg 2 + 4
		rom[1] = 32'b000000000100_00010_000_00011_0010011;
		// sw mem 0 = reg 3
		rom[2] = 32'b0000000_00011_00000_010_00000_0100011;
		// lw reg 4 = mem 0
		rom[3] = 32'b000000000000_00000_010_00100_0000011;
		// addi reg 5 = reg 4 + 5
		rom[4] = 32'b000000000101_00100_000_00101_0010011;
		// ori reg 5 = reg 5 | 5
		rom[5] = 32'b000000000101_00101_110_00101_0010011;
		// andi reg 5 = reg 5 & 3
		rom[6] = 32'b000000000011_00101_111_00101_0010011;
		// sw mem 1 = reg 5
		rom[7] = 32'b0000000_00101_00000_010_00001_0100011;
		// lw reg 6 = mem 1
		rom[8] = 32'b000000000001_00000_010_00110_0000011;
		// addi reg 8 = reg 8 + 1
		rom[9] = 32'b000000000001_01000_000_01000_0010011;
		// atomic swap reg 7 = M[reg 8], M[reg 8] = reg 3  
		rom[10] = 32'b00001_0_0_00011_01000_010_00111_0101111;
		// atomic xor reg 7 = M[reg 8], M[reg 8] = reg 7 ^ reg 3
		rom[11] = 32'b00100_0_0_00011_01000_010_00111_0101111;
		// atomic max reg 7 = M[reg 8], M[reg 8] = reg 7 > reg 3 ? reg 7 : reg 3
		rom[12] = 32'b10100_0_0_00011_01000_010_00111_0101111;
		// atomic min reg 7 = M[reg 8], M[reg 8] = reg 7 > reg 3 ? reg 3 : reg 7
		rom[13] = 32'b10000_0_0_00011_01000_010_00111_0101111;
		// atomic and reg 7 = M[reg 8], M[reg 8] = reg 7 & reg 3
		rom[14] = 32'b01100_0_0_00011_01000_010_00111_0101111;
		// atomic or reg 7 = M[reg 8], M[reg 8] = reg 7 | reg 3
		rom[15] = 32'b01010_0_0_00011_01000_010_00111_0101111;
		// atomic add reg 7 = M[reg 8], M[reg 8] = reg 7 + reg 3
		rom[16] = 32'b00000_0_0_00011_01000_010_00111_0101111;
		// load reserved reg 7 = mem[reg 8]
		rom[17] = 32'b00010_0_0_00000_01000_010_00111_0101111;
		// store conditional mem[reg 8] = reg 7
		rom[18] = 32'b00011_0_0_00111_01000_010_00111_0101111;
		// addi reg 9 = reg 9 + 12
		rom[19] = 32'b00000001100_01001_000_01001_0010011;
	end

	always @(*) begin
		case (address[9:2])
			// addi reg 2 = reg 1 + 3
			8'd0: instruction = 32'b000000000011_00001_000_00010_0010011;
			// addi reg 3 = reg 2 + 4
			8'd1: instruction = 32'b000000000100_00010_000_00011_0010011;
			// sw mem 0 = reg 3
			8'd2: instruction = 32'b0000000_00011_00000_010_00000_0100011;
			// lw reg 4 = mem 0
			8'd3: instruction = 32'b000000000000_00000_010_00100_0000011;
			// addi reg 5 = reg 4 + 5
			8'd4: instruction = 32'b000000000101_00100_000_00101_0010011;
			// ori reg 5 = reg 5 | 5
			8'd5: instruction = 32'b000000000101_00101_110_00101_0010011;
			// andi reg 5 = reg 5 & 3
			8'd6: instruction = 32'b000000000011_00101_111_00101_0010011;
			// sw mem 1 = reg 5
			8'd7: instruction = 32'b0000000_00101_00000_010_00001_0100011;
			// lw reg 6 = mem 1
			8'd8: instruction = 32'b000000000001_00000_010_00110_0000011;
			// addi reg 8 = reg 8 + 1
			8'd9: instruction = 32'b000000000001_01000_000_01000_0010011;
			// atomic swap reg 7 = M[reg 8], M[reg 8] = reg 3  
			8'd10: instruction = 32'b00001_0_0_00011_01000_010_00111_0101111;
			// atomic xor reg 7 = M[reg 8], M[reg 8] = reg 7 ^ reg 3
			8'd11: instruction = 32'b00100_0_0_00011_01000_010_00111_0101111;
			// atomic max reg 7 = M[reg 8], M[reg 8] = reg 7 > reg 3 ? reg 7 : reg 3
			8'd12: instruction = 32'b10100_0_0_00011_01000_010_00111_0101111;
			// atomic min reg 7 = M[reg 8], M[reg 8] = reg 7 > reg 3 ? reg 3 : reg 7
			8'd13: instruction = 32'b10000_0_0_00011_01000_010_00111_0101111;
			// atomic and reg 7 = M[reg 8], M[reg 8] = reg 7 & reg 3
			8'd14: instruction = 32'b01100_0_0_00011_01000_010_00111_0101111;
			// atomic or reg 7 = M[reg 8], M[reg 8] = reg 7 | reg 3
			8'd15: instruction = 32'b01010_0_0_00011_01000_010_00111_0101111;
			// atomic add reg 7 = M[reg 8], M[reg 8] = reg 7 + reg 3
			8'd16: instruction = 32'b00000_0_0_00011_01000_010_00111_0101111;
			// load reserved reg 7 = mem[reg 8]
			8'd17: instruction = 32'b00010_0_0_00000_01000_010_00111_0101111;
			// store conditional mem[reg 8] = reg 7
			8'd18: instruction = 32'b00011_0_0_00111_01000_010_00111_0101111;
			// addi reg 9 = reg 9 + 12
			8'd19: instruction = 32'b00000001100_01001_000_01001_0010011;
			default: instruction = 32'b0;
		endcase
	end
endmodule
