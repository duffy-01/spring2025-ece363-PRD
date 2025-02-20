`include "definitions.sv"

module control(
	input [31:0] instruction,
	output reg pc_src,
	output reg result_src,
	output reg mem_write, 
	output reg [3:0] alu_control,
	output reg alu_src,
	output reg [1:0] imm_src,
	output reg reg_write
);

	// Parse instruction fields
	wire [6:0] opcode   = instruction[6:0];
	wire [2:0] funct3   = instruction[14:12];
	wire [4:0] funct5   = instruction[31:27]; 

	alu_controller alu_ctrl(
        .opcode(opcode),
        .funct3(funct3),
        .funct5(funct5),
        .alu_control(alu_control)
    );

	always @(*) begin
		// Default values
		pc_src = 0; result_src = 0; mem_write = 0;
		alu_src = 0; imm_src = 2'b00; reg_write = 0;
		case (opcode)
			`OPCODE_I: begin
				imm_src = 2'b00;
				reg_write = 1;
				mem_write = 0; 
				alu_src = 1;
			end

			`OPCODE_ATM: begin
				imm_src = 2'b00;
				reg_write = 1;
				mem_write = 1;
				alu_src = 0;

			end

			`OPCODE_LOAD: begin
				imm_src = 2'b10; 
				reg_write = 1; 
				mem_write = 0;
				alu_src = 1; 

			end

			`OPCODE_STORE: begin
				imm_src = 2'b01;
				reg_write = 0;
				mem_write = 1;
 				alu_src = 1;
			end

			default: begin
				pc_src = 0; 
				result_src = 0; 
				mem_write = 0;
				alu_src = 0; 
				imm_src = 2'b00; 
				reg_write = 0;
			end
		endcase
	end

endmodule
