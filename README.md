# RISC-V Instruction Processing Unit

## Problem Alignment
RISC-V is known for customization of the processor architecture to meet the needs of a
client. This means the design is very modular.

You will be designing the appropriate control block that will read an instruction from a
memory block and process it through the principles of the ISA to create the appropriate
control signals.

## High Level Approach
Modular design of the appropriate sequential and combinational logic systems for
processing a ROM-resident code application to create the control signals for the
processor elements.

A subset of the RISC-V ISA is to be supported. Signals should be based on the single
cycle processor design.

## Goals
1. Read the instructions from the ROM-Resident Code
2. Process instructions based on the RISC-V ISA to generate control signals
3. This includes register selection and immediate values
4. Optimize the design for ASIC production

## ISA
The instructions processor must support a subset of RV32I and all RV32A instructions.
The instructions from RV32I that must be included are: addi, ori, andi, lw, sw
You may reference the green card from Dr. Arrvindh Shriraman from Simon Fisher
University for instruction format: [https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.
pdf]()

## Instruction Memory
For simplicity of testing, you should use the following code elements to develop and load
values into the ROM for your program. You can use other approaches if you want as well.
(Order and appropriate placement has not been provided, they may belong in your design
or the testbench)

```Verilog
wire [XXX:0] address; // XXX+1 address lines from cpu
wire [YYY:0] ram_address; //YYY+1 addresses
reg [31:0] ram_mem[0:ZZZ]; //32 bit wide mem with ZZZ+1 locations
$readmemh("program.dat", ram_mem);
```
### PRD created by Dr. Jennifer Winikus, Lehigh University P.C. Rossin College of Engineering, Department of ECE
&copy; Dr. Jennifer Winikus
