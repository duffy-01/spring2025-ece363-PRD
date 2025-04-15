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
// Date of last modification: Monday, 14 April 2025 @ 12:40
//*************************************************************************

program control_tb(control_if.TB control);

    // Task to update instruction and display values
    task instruction_update(input string inst_name, input logic [31:0] instr);
        control.instruction = instr;
		repeat(1) @control.cb;
        $display("%s             %b       %b          %03b      %b       %b           %04b         %b          %b           %b",
                 inst_name, control.pc_src, control.result_src, control.imm_src, control.alu_src, control.alu_control, control.mem_write, control.reg_write, control.atomic_flag, control.reserved_flag);
    endtask

    initial begin //reset then run
        // Display header
        $display("Instruction       pc_src  result_src  imm_src  alu_src  alu_control  mem_write  reg_write  atomic_flag  reserved_flag");
        // addi reg 2 = reg 1 + 3
        instruction_update("addi   ", 32'b000000000011_00001_000_00010_0010011);
        // addi reg 3 = reg 2 + 4
        instruction_update("addi   ", 32'b000000000100_00010_000_00011_0010011);
        // sw mem 0 = reg 3
        instruction_update("sw     ", 32'b0000000_00011_00000_010_00000_0100011);
        // lw reg 4 = mem 0
        instruction_update("lw     ", 32'b000000000000_00000_010_00100_0000011);
        // addi reg 5 = reg 4 + 5
        instruction_update("addi   ", 32'b000000000101_00100_000_00101_0010011);
        // ori reg 5 = reg 5 | 5
        instruction_update("ori    ", 32'b000000000101_00101_110_00101_0010011);
        // andi reg 5 = reg 5 & 3
        instruction_update("andi   ", 32'b000000000011_00101_111_00101_0010011);
        // sw mem 1 = reg 5
        instruction_update("sw     ", 32'b0000000_00101_00000_010_00001_0100011);
        // lw reg 6 = mem 1
        instruction_update("lw     ", 32'b000000000001_00000_010_00110_0000011);
        // addi reg 8 = reg 8 + 1
        instruction_update("addi   ", 32'b000000000001_01000_000_01000_0010011);
        // atomic swap reg 7 = M[reg 8], M[reg 8] = reg 3
        instruction_update("amoswap", 32'b00001_0_0_00011_01000_010_00111_0101111);
        // atomic xor reg 7 = M[reg 8], M[reg 8] = reg 7 ^ reg 3
        instruction_update("amoxor ", 32'b00100_0_0_00011_01000_010_00111_0101111);
        // atomic max reg 7 = M[reg 8], M[reg 8] = reg 7 > reg 3 ? reg 7 : reg 3
        instruction_update("amomax ", 32'b10100_0_0_00011_01000_010_00111_0101111);
        // atomic min reg 7 = M[reg 8], M[reg 8] = reg 7 > reg 3 ? reg 3 : reg 7
        instruction_update("amomin ", 32'b10000_0_0_00011_01000_010_00111_0101111);
        // atomic and reg 7 = M[reg 8], M[reg 8] = reg 7 & reg 3
        instruction_update("amoand ", 32'b01100_0_0_00011_01000_010_00111_0101111);
        // atomic or reg 7 = M[reg 8], M[reg 8] = reg 7 | reg 3
        instruction_update("amoor  ", 32'b01010_0_0_00011_01000_010_00111_0101111);
        // atomic add reg 7 = M[reg 8], M[reg 8] = reg 7 + reg 3
        instruction_update("amoadd ", 32'b00000_0_0_00011_01000_010_00111_0101111);
        // load reserved reg 7 = mem[reg 8]
        instruction_update("lr     ", 32'b00010_0_0_00000_01000_010_00111_0101111);
        // store conditional mem[reg 8] = reg 7
        instruction_update("sc     ", 32'b00011_0_0_00111_01000_010_00111_0101111);
        // addi reg 9 = reg 9 + 12
        instruction_update("addi   ", 32'b000000000110_01001_000_01001_0010011);
        // load reserved reg 7 = mem[reg 8]
        instruction_update("lr     ", 32'b00010_0_0_00000_01000_010_00111_0101111);
        // store conditional mem[reg 8] = reg 7
        instruction_update("sc     ", 32'b00011_0_0_00111_01000_010_00111_0101111);
		$finish;
	end
	

    // Runtime catch
    initial begin
        #20000 $finish;
    end

    // Waveform creation (dve)
    initial begin
        $dumpfile("control_tb.vcd");
        $dumpvars;
    end

endprogram
