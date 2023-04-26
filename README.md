# A-Single-Cycle-MIPS-CPU
This design was made as final project for the CSE331 computer organization course I went through. This CPU was implemented in Verilog HDL using Intel's Quartus Prime design kit.

## Features
 - 16x16-bit registers.
 - 8MB of memory.
 - 32-bit instructions.
 - A 32-bit ALU that supports addition, subtraction, multiplication, and other logic operations.
 
### Supported Instructions
 - add
 - sub
 - addi
 - lw
 - sw
 - beq
 - bne
 - slt
 - slti
 - j
 - jr
 - jal
 - and
 - andi
 - or
 - ori
 - sll
 - srl
 
## Usage
The design was tested using test benches. These test benches load certain instructions to the memory to test the functionality of these instructions.

### Assembler
An assembler implemented in python can be used to convert MIPS assembly code to a binary format that can be used by Quartus to load them into the instruction memory in test benches. The python file asm_to_mem.py can be used for this.

### Testbenches
The test benches are in the "test_benches" directory. Each instruction has a test bench, and an assembly example next to it.
