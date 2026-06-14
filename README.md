INTRODUCTION

This project presents the design and implementation of Single Port and Dual Port RAM using Verilog HDL. 
The designs are simulated and verified using waveform analysis through a VCD (Value Change Dump) file.

Single Port RAM allows one operation at a time — either a read or a write — through a single data bus and address line. It is simple, area-efficient, and widely used in basic memory applications.

Dual Port RAM supports simultaneous read and write operations through two independent ports, making it ideal for high-performance systems where two processes need to access memory concurrently — such as FIFOs, CPUs, and DSP applications.

Key Features of This Project

Synthesizable Verilog RTL code for both Single and Dual Port RAM.

Supports synchronous read and write operations.

Dual port design enables simultaneous access from two independent sources.

Testbench driven simulation with waveform output (.vcd).

Verified using EPWave waveform viewer.
