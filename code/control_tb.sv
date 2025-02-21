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

module control_tb()
    
    // inputs
    reg instruction;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg clk;
    reg reset;

    // outputs
    wire [3:0] alu_op;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire reg_write;
    wire [1:0] imm_src;
    wire addr_src;
    wire pc_src;    
    reg [31:0] pc;

    
    control dut(
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .clk(clk),
        .reset(reset),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .imm_src(imm_src),
        .addr_src(addr_src),
        .pc_src(pc_src)
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
        $dumpfile("control_tb.vcd");
        $dumpvars(0, control_tb);
        $display("Dumping VCD file");
        $display("Simulation started");
        $monitor("pc=%b, instruction=%b, rs1=%b, rs2=%b, rd=%b, reset=%b", pc, instruction, rs1, rs2, rd, clk, reset);
        $monitor("mem_write=%b, reg_write=%b, imm_src=%b, addr_src=%b, pc_src=%b",
                  mem_write, reg_write, imm_src, addr_src, pc_src);
    end

    
    initial begin
        instruction = 32'b00000000000000000000000000001101; 
        // example instruction
        rs1 = 5'b00000;      // Example rs1
        rs2 = 5'b00001;      // Example rs2
        rd = 5'b00010;       // Example rd
    
    end
endmodule
