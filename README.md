# Educational RISC-V Processor Implementation  

## Overview  
This repository presents a model of a pipelined processor based on the **RISC-V architecture**, implemented in the hardware description language **VHDL**. The design prioritizes simplicity while ensuring correctness through thorough testing with a variety of commands and sequences.

## Technologies Used  
The following tools and technologies were employed in the development and testing of the processor:

- **VHDL** – Hardware Description Language for digital design  
- **Intel Quartus** – FPGA design, simulation, and synthesis  
- **Sigasi Studio Eclipse Plugin** – Hardware design tool  
- **ModelSim** – Waveform analysis and debugging  
- **RARS** – RISC-V Assembler and Simulator  

## Features  
The project offers the following key features:

- **5-stage pipelined RISC-V processor**  
- **Support for the RV32I instruction set**  
- **Hazard detection and forwarding mechanisms**  
- **Memory interface for instruction and data access**  
- **Comprehensive testbench for functional validation**  

---

## Testing & Verification  
The processor was extensively tested through:

- **Unit testing** of key components such as the ALU, Register File, and Control Unit  
- **Simulation waveforms** to analyze instruction execution and pipeline behavior  
- **Execution of RISC-V assembly programs** to ensure functional correctness  

---

## Screenshots  

### Complete RISC-V Model (RV32I)  
![riscv_processorCollapsed](https://github.com/user-attachments/assets/639215f8-6ce8-4b68-a552-2734b2b7a43d)

### Waveform of the Final Model's Operation  
![test2](https://github.com/user-attachments/assets/fcbdbaac-c437-4d6d-ac0b-569198e8c105)

---

## Repository Structure  
The project directory structure is organized as follows:
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

The `components` folder contains the individual modules that make up the complete RISC-V processor design. Below is a summary of the key components:

### **ALU (Arithmetic Logic Unit)**  
Responsible for performing arithmetic and logical operations.

<img src="https://github.com/user-attachments/assets/8d2a670f-ffe9-4a88-b754-60d9738e7cbb" width="240" height="130"/>  
<img src="https://github.com/user-attachments/assets/f7bd47fe-4e58-4832-816f-ef6602b34d97" width="240" height="130"/>  
<img src="https://github.com/user-attachments/assets/ad8299d1-5101-43ae-9850-c8504408eb76" width="240" height="130"/>

### **Control Unit**  
Decodes instructions and generates control signals for other components.

<img src="https://github.com/user-attachments/assets/ef2e9506-254c-450c-a30c-99c99e6a1314" width="280" height="150"/>

### **Registers**  
Implements the register file, providing read/write access to the processor's registers.

<img src="https://github.com/user-attachments/assets/8917de86-70fc-4ca8-aa76-5ddc21582d72" width="280" height="150"/>

### **Memory**  
Simulates the data and instruction memory for the processor.

<img src="https://github.com/user-attachments/assets/50ebc3e0-f160-4c1f-84aa-9290aa7c5a71" width="340" height="180"/>
<img src="https://github.com/user-attachments/assets/a83b1788-0cdf-42ef-8927-1b155a97a360" width="340" height="180"/>

### **Instruction Decode**  
Handles the decoding of instructions in the pipeline.

<img src="https://github.com/user-attachments/assets/69dc4108-1de2-4549-ac9b-2ace6a02df64" width="280" height="150"/>

### **Instruction Execution**  
Handles the execution of instructions in the pipeline.

<img src="https://github.com/user-attachments/assets/e9daf533-89d8-4f9d-933f-e64511abd266" width="400" height="200"/>

---

Each component is implemented in VHDL and can be independently tested and simulated using corresponding testbenches.

---

## Getting Started  

Follow these steps to set up and run the project:

### Prerequisites  
Ensure the following tools are installed:  
- **Quartus** (for Intel FPGA users)  
- **ModelSim** for waveform analysis  

### Running the Simulation  
1. Clone the repository:  
   ```sh
   git clone https://github.com/vaggelisbarb/RISCV-Microprocessor.git
   cd RISCV-Microprocessor
   ```
2. Open **Quartus**  
3. Import the VHDL source files  
4. Run **simulation** to verify processor execution  
5. *(Optional)* Synthesize the design for FPGA deployment  

## Acknowledgments  
Special thanks to the **University of Ioannina** for supporting this project.  

---

