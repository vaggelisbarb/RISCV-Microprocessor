# Educational RISC-V Processor Implementation

## 📜 Overview
This repository contains the implementation of an educational RISC-V processor using VHDL. The project is designed to serve as a learning tool for understanding the RISC-V architecture, pipelining, and processor design concepts.

## 🛠 Technologies Used
VHDL – Hardware Description Language for design
Xilinx Vivado / Quartus – Simulation and synthesis
GTKWave – Waveform analysis
RISC-V Assembly – Test programs for validation

## 🔍 Features
5-stage pipelined RISC-V processor
Support for RV32I instruction set
Hazard detection and forwarding mechanisms
Basic memory interface for instruction and data access
Testbench for functional verification

## 📌 Testing & Verification
Unit tests for ALU, Register File, and Control Unit
Simulation waveforms to verify execution flow
Execution of RISC-V assembly programs in simulation

## 🖼 Screenshots
(Add waveform screenshots and any relevant visual outputs)

## 📂 Repository Structure
bash
Αντιγραφή
Επεξεργασία
/src        # VHDL source files
/tests      # Testbenches and test programs
/docs       # Documentation and project reports
/screenshots # Simulation results

## 🚀 How to Run
Open Vivado / Quartus
Load the VHDL source files
Run simulation to verify processor execution
Optional: Synthesize the design for FPGA deployment
