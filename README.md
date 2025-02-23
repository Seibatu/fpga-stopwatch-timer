# Stopwatch Timer ⏱️

## Overview
This project implements a **Verilog-based stopwatch timer** that counts from **00 to 99 seconds** and wraps around. The design includes a 
**7-segment display** for real-time visual feedback and supports **start, stop, and reset** functionalities.

## 📜 Features
✅ **Binary Counter Module** to track elapsed time  
✅ **Binary to BCD Converter** for 7-segment display compatibility  
✅ **Clock Divider Module** for stable timing control  
✅ **7-Segment Display Driver** for user-friendly output  
✅ **Testbench Verification** using simulation tools like Vivado 

---

## 📌 System Architecture
This project consists of the following Verilog modules:

1. **Counter Module (`counterCtrl.v`)**  
   - Increments time every second and wraps around at 99.
   - Supports enable (`go`) and reset (`clr`) signals.

2. **Binary to BCD Converter (`bcdCtrl.v`)**  
   - Converts the binary counter value into a BCD format for display.

3. **7-Segment Display Driver (`sevenSegment.v`)**  
   - Controls the display output of the stopwatch.

4. **Top-Level Module (`topModule.v`)**  
   - Integrates all sub-modules and connects the necessary inputs and outputs.

---

## 🛠️ How to Run It
### 1️⃣ Simulation
To test the design before FPGA implementation:
1. Open **Vivado Simulator** .
2. Load `topModule.v` and include all submodules (`counterCtrl.v`, `bcdCtrl.v`, `sevenSegment.v`).
3. Compile and run the testbench.
4. Observe the waveform in the built-in waveform viewer.

### 2️⃣ FPGA Implementation
1. Open **Xilinx Vivado**.
2. Create a new project and add all Verilog files.
3. Assign FPGA board pins according to your hardware setup using a Constraints XDC file.
4. Run synthesis, implementation, and generate the bitstream.
5. Program your bitstream to the FPGA and test using the physical buttons.

---

## 📂 Repository Structure
```
📂 src/               # Verilog source files
   ├── bcdCtrl.v      # Binary to BCD conversion
   ├── counterCtrl.v  # Counter logic   
   ├── sevenSegment.v # 7-segment display driver
   ├── topModule.v     # Top-level module

📂 testbench/       # Testbenches and simulations
📂 waveforms/       # Simulation waveform images
📂 docs/            # Documentation
```

---

## 📸 Simulation Waveform


---

## ✉️ Contact
For any questions or improvements or collaborations, feel free to connect:
- **GitHub:** [Seibatu](https://github.com/Seibatu)
- **LinkedIn:** [Seiba Abdul Rahman](https://www.linkedin.com/in/seiba-abdul-rahman)
