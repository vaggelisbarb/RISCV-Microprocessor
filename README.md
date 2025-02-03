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
*(Add simulation waveforms, block diagrams, or FPGA synthesis results here.)*  

Example:  
```md
![Waveform Example](screenshots/waveform.png)
```

## Repository Structure  
```
/                     # VHDL files
/modelsim_waveforms   # Waveform files
/riscv_tests          # Test programs and simulation scripts  
/sigasi_docs          # Documentation related to Sigasi
/testbenches          # Simulation files for verifying the functionality of each design component
/work                 # Compiled or synthesized design files
```

## Getting Started  
To set up and run the project, follow these steps:  

### Prerequisites  
Ensure you have the following tools installed:  
- **Vivado** (for Xilinx FPGA users) or **Quartus** (for Intel FPGA users)  
- **GTKWave** for waveform analysis  

### Running the Simulation  
1. Clone the repository:  
   ```sh
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   ```
2. Open **Vivado** or **Quartus**  
3. Import the VHDL source files  
4. Run **simulation** to verify processor execution  
5. *(Optional)* Synthesize the design for FPGA deployment  

## License  
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.  

## Acknowledgments  
Special thanks to the **University of Ioannina** for supporting this project.  

---

