Probelm statement :  most basic memory implementations only support single port RAM, which allows only one operation — either a read or a write — at any given clock cycle. This creates a serious bottleneck in performance when the system demands simultaneous access to memory from multiple sources. in a pipelined processor, the CPU needs to fetch an instruction and read/write data at the same time.

Tools : Vivado/EDA Playground,GTKwave

Design : 

1.designed a Dual Port RAM with two fully independent ports — Port A and Port B — each having its own clock, address bus, data bus, and write enable signal. This allows two separate operations to happen simultaneously in the same clock cycle without any conflict, completely eliminating the bottleneck that single port RAM suffers from.
                               

 2. By giving each port its own independent clock signal (clk_a and clk_b), the dual port RAM can interface with two different modules operating at different frequencies, making it suitable for real-world multi-clock digital systems like FIFOs and communication interfaces.

3.To ensure the design works correctly, I wrote a dedicated testbench that applies different read and write combinations on both ports and captures the output as a VCD (Value Change Dump) file. I then verified the waveforms using GTKWave, confirming that both ports operate correctly and independently without interfering with each other.
