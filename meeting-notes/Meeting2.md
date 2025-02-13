# Meeting 2
Liam Burke, Shane Duffy

## Written Organization
### Executive Summary
* We will treat the executive summary as a problem proposition section. 

### Secondary Summary
* Background into RISC-V
* Sneak in a joke or two.

### Chapter 1: High level architecture
* High level
* Relations
* Connections
* Block diagram

### Chapter 2: Implementation
* Addressing how architecture was handled in the code.
* Here's what "alu.sv" does, in detail.
  
### Chapter 3
* Results
* Shortcomings

## Some Coding Principles / Specification
* ALWAYS ASSUME 32-BIT ARCHITECTURE
  * i.e. 32-bit memory
  * 32-bit ALU
  * 32-bit everything!
 
## ALU
* lw, pull 32-bit item from memory, put in register
* sw, pull a 32-bit register value into memory
* addi, ori, andi ---> self explanatory

## Memory
* Need to **implement separate file**
```Verilog
wire [XXX:0] address;
// XXX+1 address lines from cpu​
wire [YYY:0] ram_address; //YYY+1 addresses​
reg [31:0] ram_mem[0:ZZZ]; //32 bit wide mem with ZZZ+1 locations​
$readmemh("program.dat", ram_mem);
```

# Tasks
- [ ] Implement .sv files as soon as possible for harnessing and verification processes. Note: save ipu.sv and ipu_tb for Tuesday.
- [ ] Implement TB.sv files for each completed module.
- [ ] Write introductory sections, perhaps conduct some literature search for relevant RISC-V info.
- [ ] Generate block diagram of design overview. Verify correctness in approach.

