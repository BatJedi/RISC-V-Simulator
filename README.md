# RISC-V-Simulator
A 64-bit RISC-V simulator written in verilog HDL with support for selected instructions.

To know about the RISC-V ISA, head here: https://content.riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf

The verlilog sources in this project were simulated and tested using Xilinx's Vivado software.

These verilog source files contain one module each which implement a component of the RISC-V single cycle datapath. This datapath will be later modified to add pipelining.

The Instruction Memory module ("IM.v") reads instructions in binary format from a text file.

The memory hierarchy currently contains only of one Data Memory module, which is written in a text file for logging purposes. Modifications to this memory hierarchy to include a data cache and an instructions cache are in progress.

The reg_file module logs the register files into a text file. There are 32 registers x1 - x32, as stated in RISC-V ISA.

To run the simulator, just save your instructions in a text file, modify the instruction memory module to include the path of your instruction file, modify the instruction memory size definition if your instruction file contains more than 32 instructions. The new size should be greater than or equal to 4 X Number of instructions.

Run simulation after giving a clock input to "main" module via a testbench or by "force clock" option if you're using Vivado.

The instructions will be executed and you can check the reg_files and data memory for details/verification.
