//single port ram module design 

module single_port_ram (
 input [7:0]data,    // 8 bit of input data
 input we,           //Enables write operation
 input [5:0]addr,    //6-bit of adrress to storage the data 
 input clk,  	     //clk pulse
output[7:0]q	     //8-bit of output data 
);

  reg [7:0] ram [63:0]; //actual 64x8 memeory storage 
reg [5:0] addr_reg;   //copy addr to registerd address

always @(posedge clk)
begin 
  if (we)  
    ram[addr]<=data;	// write to RAM using current address
else
  addr_reg<= addr ;	 // write to RAM using previous read address or to store adddr
end
  assign q = ram[addr_reg];   // output 
endmodule


// Dual Port RAM Design.

module dual_port_ram (
  input  [7:0] data_a, data_b,
  input  [5:0] addr_a, addr_b,
  input        we_a, we_b,
  input        clk,
  output wire [7:0] q_a, q_b          
);

  reg [7:0] ram [63:0];           // 64 x 8-bit shared memory
  reg [5:0] addr_a_reg;           // registered address Port a
  reg [5:0] addr_b_reg;           // registered address Port b

  //  Port A 
  always @(posedge clk) begin
    if (we_a && we_b && (addr_a == addr_b))  //checks  values of addr_a& addr_b are same if same collision occurs addr warns where it happens 
      $display("WARNING: Write collision at addr %0d", addr_a);
    else if (we_a)
      ram[addr_a] <= data_a;      // write Port A
    addr_a_reg <= addr_a;         // always latch address
  end

  //  Port B 
  
  always @(posedge clk) begin
    if (!(we_a && we_b && (addr_b == addr_a)))
      if (we_b)
        ram[addr_b] <= data_b;    // write Port B
    addr_b_reg <= addr_b;         // always latch address
  end

  //  outputs 
  
  assign q_a = ram[addr_a_reg];   // output Port A
  assign q_b = ram[addr_b_reg];   // output Port B

endmodule

// loading data into memory from an text(.txt)file 

// module load_memory_file;
 
//   reg [7:0] ram [63:0];   // 64 x 8-bit shared memory
 

//   initial begin
//     $readmemh("memory_data.txt", ram);   // Load hex values from file into ram[]
//     $display("Memory loaded from memory_data.txt");
//     $display("ram[0]=0x%h ram[1]=0x%h ram[2]=0x%h ram[3]=0x%h",
//               ram[0], ram[1], ram[2], ram[3]);
//     $readmemb("memory_data.txt", ram);   // Load binary values from file into ram[]
//     $display("Memory loaded from memory_data.txt");
//     $display("ram[4]=0x%b ram[5]=0x%b ram[6]=0x%h ram[7]=0x%h",
//              ram[4], ram[5], ram[6], ram[7]);
//   end
  