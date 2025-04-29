`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2025 04:35:08 PM
// Design Name: 
// Module Name: tb_pwm_switch
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


module tb_pwm_switch();
    reg [7:0] switch = 8'b00000010;
    reg clk = 0;
    wire led;
    
    pwm utt(
    .clk(clk),
    .sw(switch),
    .led(led));

    
    always #1 clk = ~clk;
    
endmodule
