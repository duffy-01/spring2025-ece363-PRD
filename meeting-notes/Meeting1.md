
# PRD Meeting 1
Shane Duffy, Liam Burke

## GitHub.
* Add Liam to GitHub. 
* How do we want to share work?

## Design Structure. Wanted to emphasize modularity and organization.

### ipu.sv (Top-level):
* This will contain all instantiations of all other modules.
* Final implementation

### control.sv
* Control unit logic
* Takes in instruction input and generates control signals

### alu.sv
* Exactly what it says on the tin.

### register.sv
* Implements storage and access to processor registers.
* Works with control, but standalone for clarity.

### instruction_rom.sv
* Stores instructions as per green card specs

### defines.sv (totally optional)
* Constants
* Opcodes
* Register names

### testbench.sv
* Exactly what it says on the tin.


	
