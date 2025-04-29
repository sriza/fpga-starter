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
    output [3:0] led
    );
   //creating a counter
    reg [7:0] counter=0;
    
    always@(posedge clk) begin
        if (counter < 100) counter<=counter+1;
        else counter<=0;
    end
    
    // creating a duty cycle 20% . i.e the led outputs 1 if counter is less than 20
    assign led[3] = (counter<20) ? 1:0;
    
    // creating a duty cycle 40% . i.e the led outputs 1 if counter is less than 20
    assign led[2] = (counter<40) ? 1:0;
    
    // creating a duty cycle 60% . i.e the led outputs 1 if counter is less than 20
    assign led[1] = (counter<60) ? 1:0;
    
    // creating a duty cycle 80% . i.e the led outputs 1 if counter is less than 20
    assign led[0] = (counter<80) ? 1:0;
endmodule
