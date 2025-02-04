# Educational RISC-V Processor Implementation  

## Overview
This repository contains a model of a pipelined processor based on the **RISC-V architecture**, implemented in the hardware description language **VHDL**, with an emphasis on the simplicity of the final design.
To confirm the correct operation of the implemented model, a large number of individual commands and sequences of commands were executed.

## Technologies Used  
- **VHDL** – Hardware Description Language for digital design  
- **Intel Quartus** – FPGA design, simulation, and synthesis
- **Sigasi Studio Eclipse Plugin** – Hardware design tool 
- **ModelSim** – Waveform analysis and debugging  
- **RARS** – RISC-V Assembler and Simulator 

## Features  
- **5-stage pipelined RISC-V processor**  
- **Support for RV32I instruction set**  
- **Hazard detection and forwarding mechanisms**  
- **Memory interface for instruction and data access**  
- **Comprehensive testbench for functional validation**  

## Testing & Verification  
The processor has been thoroughly tested and verified through:  
- **Unit testing** of key components (ALU, Register File, Control Unit)  
- **Simulation waveforms** to analyze instruction execution and pipeline behavior  
- **Execution of RISC-V assembly programs** to validate functional correctness  

## Screenshots  

### Complete RISC-V Model (RV32I):  
![riscv_processorCollapsed](https://github.com/user-attachments/assets/639215f8-6ce8-4b68-a552-2734b2b7a43d)

### Waveform of the Final Model's Operation:
![test2](https://github.com/user-attachments/assets/fcbdbaac-c437-4d6d-ac0b-569198e8c105)

---

## Repository Structure  
```
/components           # VHDL files
/modelsim_waveforms   # Waveform files
/riscv_tests          # Test programs and simulation scripts  
/sigasi_docs          # Documentation related to Sigasi
/testbenches          # Simulation files for verifying the functionality of each design component
/work                 # Compiled or synthesized design files
```

---

## Components Folder

The `components` folder contains various modules responsible for different functions in the RISC-V processor. Below is a summary of each component:

### **ALU (Arithmetic Logic Unit)**  
Responsible for performing arithmetic and logical operations.

![ALU](https://github.com/user-attachments/assets/8d2a670f-ffe9-4a88-b754-60d9738e7cbb)  
![ALU Control Unit](https://github.com/user-attachments/assets/f7bd47fe-4e58-4832-816f-ef6602b34d97)  
![ALU MUX](https://github.com/user-attachments/assets/ad8299d1-5101-43ae-9850-c8504408eb76)

### **Control Unit**  
Decodes instructions and generates control signals for other components.

![Control Unit](https://github.com/user-attachments/assets/ef2e9506-254c-450c-a30c-99c99e6a1314)

### **Registers**  
Implements the register file, providing read/write access to the processor's registers.

![Registers](https://github.com/user-attachments/assets/8917de86-70fc-4ca8-aa76-5ddc21582d72)

### **Program Counter**  
Keeps track of the current instruction address.

### **Memory**  
Simulates the data and instruction memory for the processor.

![Memory](https://github.com/user-attachments/assets/50ebc3e0-f160-4c1f-84aa-9290aa7c5a71)

### **Instruction Decode**  
Handles the decoding of instructions in the pipeline.

![Instruction Decode](https://github.com/user-attachments/assets/69dc4108-1de2-4549-ac9b-2ace6a02df64)

---

Each component is implemented in VHDL and can be independently tested and simulated using the corresponding testbenches.

## Getting Started  
To set up and run the project, follow these steps:  

### Prerequisites  
Ensure you have the following tools installed:  
- **Quartus** (for Intel FPGA users)  
- **ModelSim** for waveform analysis  

### Running the Simulation  
1. Clone the repository:  
   ```sh
   git clone https://github.com/vaggelisbarb/RISCV-Microprocessor.git
   cd your-repo
   ```
2. Open **Quartus**  
3. Import the VHDL source files  
4. Run **simulation** to verify processor execution  
5. *(Optional)* Synthesize the design for FPGA deployment  

## License  
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.  

## Acknowledgments  
Special thanks to the **University of Ioannina** for supporting this project.  

---

