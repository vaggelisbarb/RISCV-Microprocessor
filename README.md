# Educational RISC-V Processor Implementation  

## Overview  
This repository contains the implementation of an **educational RISC-V processor** using **VHDL**. The project is designed as a learning tool to illustrate processor design principles, instruction execution, and pipelining in the **RISC-V architecture**.  

## Technologies Used  
- **VHDL** – Hardware Description Language for digital design  
- **Xilinx Vivado / Intel Quartus** – FPGA design, simulation, and synthesis  
- **GTKWave** – Waveform analysis and debugging  
- **RISC-V Assembly** – Test programs for functional verification  

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
/src         # VHDL source files  
/tests       # Testbenches and verification scripts  
/docs        # Project documentation and reports  
/screenshots # Simulation and synthesis results  
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

