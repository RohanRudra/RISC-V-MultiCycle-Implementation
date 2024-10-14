# RISC-V Multicycle Processor in Verilog

This project implements a multicycle RISC-V processor using Verilog. The design comprises various components, including the program counter, ALU, memory, registers, and control logic. The multicycle architecture allows for executing RISC-V instructions across multiple clock cycles, improving efficiency and simplifying control logic.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Modules](#modules)
- [Simulation](#simulation)
- [Contributing](#contributing)

## Features

- Implements RISC-V instruction set architecture.
- Multicycle operation, allowing complex instructions to execute over multiple clock cycles.
- Modular design for easy integration and testing of individual components.
- Support for various RISC-V instruction types: R-type, I-type, S-type, SB-type, and U-type.

## Architecture

The processor is structured into several key components:

1. **Program Counter (PC)**: Keeps track of the address of the next instruction to be executed.
2. **Memory Module**: Handles read and write operations to a defined memory space.
3. **Instruction Register**: Stores the Instruction from the previous cycles for further usage.
4. **Memory Data Register**: Stores the Data from the previous cycles for further usage.
5. **Control FSM**: Manages the control signals needed for operation based on the instruction type.
6. **Registers Block**: Contains 32 general-purpose registers for data storage and manipulation.
7. **ALU (Arithmetic Logic Unit)**: Performs arithmetic and logical operations on the data.
8. **Multiplexers (Muxes)**: Direct data flow between various components based on control signals.


## Modules

### 1. `Program_Counter`
Handles the program counter logic for the processor.

### 2. `RegistersBlock`
Implements a set of 32 registers used to store data and addresses.

### 3. `ALUunit`
Performs arithmetic and logical operations.

### 4. `Memory`
Manages read and write operations for data storage.

### 5. `ImmGen`
Generates immediate values based on the instruction format.

### 6. `Control_FSM`
Controls the flow of data and operations within the processor based on the current instruction.

### 7. `Gates`
Includes basic logic gates (AND, OR) used in control logic.

### 8. `Muxes`
Handles multiplexing to select appropriate inputs based on control signals.



## Simulation

A testbench (`tb.v`) is provided to simulate the operation of the top-level module. It initializes the clock and reset signals, allowing you to observe the processor's behavior during execution.

### Example Testbench Initialization
```verilog
initial begin
    clk = 0;
    reset = 1;
    #7 reset = 0;
    #2000; // Run the simulation for 2000 time units
end

always begin
    #10 clk = ~clk; // Toggle clock every 10 time units
end
```

## Contributing

Contributions are welcome! If you have suggestions for improvements or additional features, please fork the repository and submit a pull request.

