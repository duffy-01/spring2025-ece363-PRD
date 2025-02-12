# RISC-V Instruction Processing Unit

# Problem Alignment
RISC-V is known for customization of the processor architecture to meet the needs of a
client. This means the design is very modular.

You will be designing the appropriate control block that will read an instruction from a
memory block and process it through the principles of the ISA to create the appropriate
control signals.

# High Level Approach
Modular design of the appropriate sequential and combinational logic systems for
processing a ROM-resident code application to create the control signals for the
processor elements.

A subset of the RISC-V ISA is to be supported. Signals should be based on the single
cycle processor design.

# Goals
*1. Read the instructions from the ROMResident Code
*2. Process instructions based on the RISCV ISA to generate control signals
*3. This includes register selection and immediate values
*4. Optimize the design for ASIC production
