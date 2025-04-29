`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2025 10:58:49 AM
// Design Name: 
// Module Name: pwm
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


module pwm(
    input clk,
    input [7:0] sw,
    output [0:0]led
    );
   //creating a counter
    reg [7:0] counter=0;
    
    
    always @(posedge clk) begin
        if (counter < 100) counter<=counter+1;
        else counter<=0;
    end
    
    
    assign led = (counter<sw) ? 1:0;
endmodule
