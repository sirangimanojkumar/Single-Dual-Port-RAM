`timescale 1ns / 1ps

module single_port_ram_tb;
  reg [7:0] data;
  reg [5:0] addr;
  reg we;
  reg clk;
  wire [7:0] q;

  single_port_ram dut(.data(data), .addr(addr), .we(we), .clk(clk), .q(q));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, single_port_ram_tb);
    clk = 1'b1;
    forever #5 clk = ~clk;
  end

  initial begin
    // Write operations is enabled to write data in specific location 
    we   = 1'b1;
    data = 8'h60; addr = 5'd0; #10;
    data = 8'hA1; addr = 5'd1; #10;
    data = 8'h89; addr = 5'd2; #10;
    data = 8'h34; addr = 5'd3; #10;
    data = 8'hC2; addr = 5'd4; #10;
    data = 8'hEF; addr = 5'd5; #10;
    data = 8'hBD; addr = 5'd6; #10;
    data = 8'hFF; addr = 5'd7; #10;

    // Read operations enables when erite operation disabled 
    
    we   = 1'b0;
    addr = 5'd0; #10;
    addr = 5'd1; #10;
    $finish;
  end
endmodule




//Dual Port RAM Design Testbench 


`timescale 1ns / 1ps

module dual_port_ram_tb;

  reg  [7:0] data_a, data_b;
  reg  [5:0] addr_a, addr_b;
  reg        we_a, we_b;
  reg        clk;
  wire [7:0] q_a, q_b;


  
  dual_port_ram dut (
    .data_a (data_a),
    .addr_a (addr_a),
    .we_a   (we_a),
    .data_b (data_b),
    .addr_b (addr_b),
    .we_b   (we_b),
    .clk    (clk),
    .q_a    (q_a),
    .q_b    (q_b)
  );

    initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, dual_port_ram_tb);
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

 
  initial begin

    we_a   = 1'b0; we_b   = 1'b0;
    data_a = 8'h00; data_b = 8'h00;
    addr_a = 6'd0;  addr_b = 6'd0;
    #10;

    //  Port A Write&Port B Write Simultaneously writes to diffrent addr
    
    we_a = 1'b1; we_b = 1'b1;

    data_a = 8'hA1; addr_a = 6'd0;   
    data_b = 8'hB1; addr_b = 6'd1;   
    #10;

    data_a = 8'hA2; addr_a = 6'd2;   
    data_b = 8'hB2; addr_b = 6'd3;
    #10;

    data_a = 8'hA3; addr_a = 6'd4; 
    data_b = 8'hB3; addr_b = 6'd5; 
   
    #10;

    data_a = 8'hA4; addr_a = 6'd6;  
    data_b = 8'hB4; addr_b = 6'd7;  
    #10;

    
    // the Port a& port b reads simultaneouly from diff addr.
       
    we_a = 1'b0; we_b = 1'b0;

    addr_a = 6'd0; addr_b = 6'd1; #10;  
    addr_a = 6'd2; addr_b = 6'd3; #10;  
    addr_a = 6'd4; addr_b = 6'd5; #10;  
    addr_a = 6'd6; addr_b = 6'd7; #10;  

    
    // Where Port a Writes & port b Reads simultaneoulsy in diff addr
   
    
    we_a = 1'b1; we_b = 1'b0;

    data_a = 8'hFF; addr_a = 6'd8;   
                    addr_b = 6'd0;   
    #10;

    data_a = 8'hEE; addr_a = 6'd9;   
                    addr_b = 6'd2;   
    #10;

    
  
    // Where Port a Reads & Port b Writes simultaneously (different addresses)
    
 
    we_a = 1'b0; we_b = 1'b1;

    data_b = 8'hCC; addr_b = 6'd10;  
                    addr_a = 6'd1;   
    #10;

    data_b = 8'hDD; addr_b = 6'd11;  
    addr_a = 6'd3;   
    #10;

   

    
    //  collision if  (Both ports write to SAME address)
    
    $display(" Collision - Both Ports Write to Same addr  ");
    we_a = 1'b1; we_b = 1'b1; 

    data_a = 8'hAA; addr_a = 6'd20;  
    data_b = 8'hBB; addr_b = 6'd20;  
    #10;
    
    //if collision occurs the Result depends on last Excuted Port either(a,b)

    
  
    $finish;
  end

  initial begin
    $monitor("Time=%0t | we_a=%b we_b=%b | addr_a=%0d addr_b=%0d | data_a=0x%h data_b=0x%h | q_a=0x%h q_b=0x%h",
    $time, we_a, we_b, addr_a, addr_b, data_a, data_b, q_a, q_b);
  end

endmodule