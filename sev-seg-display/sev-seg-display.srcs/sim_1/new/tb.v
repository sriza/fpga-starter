`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2025 07:43:57 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// the delays of 10ns might now be enough for slow clk
// This testbench in written by taking actual clock into account
module tb();
    //input
    reg clk;
    reg [15:0] sw;
    
    //ouput
    wire led;
    wire [6:0] seg;
    wire dp;
    wire [3:0] an;
    
    top uut(.clk(clk), .sw(sw), .led(led), .seg(seg), .dp(dp), .an(an));
    
    // Clock generation
    // Process starts at time 0ns and loops after every 5ns
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        $display("starting simulation");

        //with all sw set to zero
        $display("display 12");
        sw = 16'd12;
        #10;
        
        // with sw set to one
        $display("display 1");
        sw = 16'd1;
        #10;
        
        //with all sw active
        $display("display 65363 or sth");
        sw = 16'b1111111111111111;
        #10;
        
        //with sw value of 9999
        $display("display 9999");
        sw = 16'd9999;
        #10;
        
        //with sw value of 10000 to check if the led is on
        $display("display 10000");
        sw = 16'd10000;
        #10;
        
        //with random sw value which is valid
        $display("display 2839");
        sw = 16'd2839;
        #10;
        
        //with random invalid sw value
        $display("display 2839");
        sw = 16'd13999;
        #10;
        
        
        $display("simulation complete");
    end
    
endmodule
